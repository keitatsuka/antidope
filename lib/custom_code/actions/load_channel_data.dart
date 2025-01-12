// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// lib/custom_code/actions/load_channel_data.dart

// ---------------------
// 1) FlutterFlow標準 import
// ---------------------
// ↑ DO NOT REMOVE OR MODIFY THE CODE ABOVE! と被らないように注意

// ---------------------
// 2) API呼び出しや Custom Actions を import
// ---------------------
import '/backend/api_requests/api_calls.dart';
import '/custom_code/actions/index.dart' as myActions;
import 'dart:convert';

// ---------------------
// 3) loadChannelData 関数
// ---------------------
Future<void> loadChannelData(String channelId) async {
  debugPrint('=== loadChannelData START ===');
  debugPrint('channelId => $channelId');

  if (channelId.isEmpty) {
    debugPrint('channelId is empty → clear UI & return');
    FFAppState().videoListJson = '';
    FFAppState().test = [];
    FFAppState().selectedVideoId = '';
    FFAppState().HTMLForWebView = '';
    FFAppState().selectedItem = null;
    FFAppState().selectedIconUrl = ''; // アイコンもクリア

    // ★ 追加: nextPageToken や uploadsPlaylistId もクリアするなら
    FFAppState().nextPageToken = '';
    FFAppState().uploadsPlaylistId = '';
    return;
  }

  // 1) キャッシュが有効か判定
  final isValid = await myActions.isChannelCacheValid(channelId, '86400000');
  debugPrint('[isChannelCacheValid] => $isValid');

  if (isValid) {
    final cachedJson = await myActions.getCachedVideoListForChannel(channelId);
    debugPrint('[getCachedVideoListForChannel] => $cachedJson');

    if (cachedJson != null && cachedJson.isNotEmpty) {
      FFAppState().videoListJson = cachedJson;
    } else {
      debugPrint('cachedJson is empty -> fetchAndCacheVideoList');
      await _fetchAndCacheVideoList(channelId);
    }
  } else {
    debugPrint('cache not valid -> fetchAndCacheVideoList');
    await _fetchAndCacheVideoList(channelId);
  }

  debugPrint('FFAppState().videoListJson => ${FFAppState().videoListJson}');

  // 2) itemsを抽出
  debugPrint('=== extractItemsListFromJson start ===');
  final items =
      await myActions.extractItemsListFromJson(FFAppState().videoListJson);
  debugPrint('=== extractItemsListFromJson done. items => $items');

  // "test"に格納
  FFAppState().test = (items ?? []).toList();

  // 3) 先頭動画の設定
  if (FFAppState().test.isNotEmpty) {
    // -----------------------------
    // (1) 動画IDを取得してWebView用HTMLを生成
    // -----------------------------
    final firstVideoId =
        await myActions.extractVideoIdFromJson(FFAppState().videoListJson);
    debugPrint('extracted firstVideoId => $firstVideoId');

    FFAppState().selectedVideoId = firstVideoId ?? '';
    FFAppState().HTMLForWebView = '''
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          .video-container {
            position: relative;
            width: 100%;
            padding-top: 65%; /* アスペクト比16:9の一例 */
            overflow: hidden;
          }
          .video-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 0;
          }
        </style>
      </head>
      <body style="margin:0;padding:0;overflow:hidden;">
        <div class="video-container">
          <iframe
            src="https://www.youtube.com/embed/${FFAppState().selectedVideoId}?autoplay=0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen>
          </iframe>
        </div>
      </body>
    </html>
    ''';

    // -----------------------------
    // (2) 選択中アイテムの更新
    // -----------------------------
    FFAppState().selectedItem = FFAppState().test.first;

    // -----------------------------
    // (3) チャンネルIDを取り出し → チャンネルアイコンURLを探す
    // -----------------------------
    final snippet = FFAppState().selectedItem?['snippet'];
    if (snippet != null && snippet['channelId'] != null) {
      final topChannelId = snippet['channelId'].toString();
      debugPrint('topChannelId => $topChannelId');

      // findIconUrlByChannelIdを呼ぶ
      final iconUrl = await myActions.findIconUrlByChannelId(
        topChannelId,
      );

      // アイコンURLが取得できればセット、無ければ空にする
      if (iconUrl != null && iconUrl.isNotEmpty) {
        FFAppState().selectedIconUrl = iconUrl;
      } else {
        FFAppState().selectedIconUrl = '';
      }
      debugPrint('selectedIconUrl => ${FFAppState().selectedIconUrl}');
    } else {
      // snippetやchannelIdが無い場合
      FFAppState().selectedIconUrl = '';
    }
  } else {
    // 要素が無い場合、各種クリア
    debugPrint('FFAppState().test is empty -> clearing UI');
    FFAppState().selectedVideoId = '';
    FFAppState().HTMLForWebView = '';
    FFAppState().selectedItem = null;
    FFAppState().selectedIconUrl = '';
  }

  debugPrint('=== loadChannelData END ===');
}

// ---------------------
// 4) API呼び出し＆キャッシュ保存
//    "loadChannelData" 内だけで使う private関数例
// ---------------------
Future<void> _fetchAndCacheVideoList(String channelId) async {
  debugPrint('=== _fetchAndCacheVideoList START => $channelId');

  final channelRes = await ChannelsListAPICallCall.call(channelId: channelId);
  debugPrint(
      'channelRes => ${channelRes?.jsonBody} (succeeded? ${channelRes?.succeeded})');

  if (channelRes?.succeeded ?? false) {
    // ★ 1) uploadsPlaylistId を取得し FFAppState に保存
    final uploadsId = getJsonField(
      channelRes?.jsonBody ?? '',
      r'$.items[0].contentDetails.relatedPlaylists.uploads',
    )?.toString();

    debugPrint('uploadsId => $uploadsId');
    FFAppState().uploadsPlaylistId = uploadsId ?? ''; // ★ 追加

    // PlaylistのAPIコール
    final playlistRes = await PlaylistItemsListAPICallCall.call(
      uploadsPlaylistId: FFAppState().uploadsPlaylistId,
      // 1回目なので pageToken は空に
    );
    debugPrint('playlistRes => ${playlistRes?.jsonBody}');

    if (playlistRes?.succeeded ?? false) {
      // 1) レスポンスを純粋なJSON文字列に
      final result = playlistRes?.jsonBody;
      String raw;
      if (result == null) {
        raw = '';
      } else if (result is String) {
        raw = result;
      } else {
        raw = jsonEncode(result);
      }
      debugPrint('raw video JSON => $raw');

      // ★ 2) nextPageToken を取得し、FFAppStateに保存
      final newPageToken =
          getJsonField(result, r'$.nextPageToken')?.toString() ?? '';
      debugPrint('initial nextPageToken => $newPageToken');
      FFAppState().nextPageToken = newPageToken; // ★ 追加

      // 2) Hiveに保存
      final storedJson =
          await myActions.storeVideoListJsonSafely(raw, channelId);
      debugPrint('storeVideoListJsonSafely => $storedJson');

      // 3) キャッシュ用のタイムスタンプ更新
      await myActions.updateChannelTimestamp(channelId);

      // 4) FFAppStateに格納
      FFAppState().videoListJson = storedJson ?? '';
    }
  }

  debugPrint('=== _fetchAndCacheVideoList END');
}
