// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// ==============================
// ==============================
import '/custom_code/actions/index.dart'; // (← FlutterFlowで作成した他のCustom Actionをまとめたindex)
import '/flutter_flow/custom_functions.dart'; // (← FlutterFlowのCustom Function)

// ==============================
// ==============================

import 'dart:convert';

// もしYouTube Data APIのCustom Actionを用意している場合、以下でインポート
import '/backend/api_requests/api_calls.dart';
// ↑ ここで "ChannelsListAPICallCall" と "PlaylistItemsListAPICallCall" を使える想定

// "myActions" 別名でCustom Actionsを参照
import '/custom_code/actions/index.dart' as myActions;

// Hive関連
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// 【メイン入口】
/// loadChannelData: 指定チャンネルを読み込み、FFAppStateに動画リストを構築
///   1) 24時間以内にキャッシュ済みか判定
///   2) 有効なら「Hive保存のJSON」を読み込み
///   3) 古い or 無い => 1ページfetch + 差し込み更新
///   4) FFAppState().test に動画リストを反映 & 先頭動画を選択
Future<void> loadChannelData(String channelId) async {
  debugPrint('\n=== [Debug] loadChannelData START ===');
  debugPrint('channelId => $channelId');

  // 1) Quick exit if channelId empty
  if (channelId.isEmpty) {
    debugPrint('[Debug] channelId is empty => clearing UI...');
    _clearUIState();
    return;
  }

  // 2) If channel changed, reset UI states
  final oldCh = FFAppState().ChannelId;
  if (oldCh != channelId) {
    debugPrint('[Debug] channel changed => oldCh=$oldCh, new=$channelId');
    _clearUIState();
    // Switch
    FFAppState().ChannelId = channelId;
  }

  // 3) Check 24h Cache
  final isValid = await myActions.isChannelCacheValid(channelId, '86400000');
  debugPrint('[Debug] isChannelCacheValid($channelId) => $isValid');

  if (isValid) {
    // 3-A) cache is valid => read from Hive
    final cachedJson = await myActions.getCachedVideoListForChannel(channelId);
    if (cachedJson != null && cachedJson.isNotEmpty) {
      final parsed = jsonDecode(cachedJson) as Map<String, dynamic>;
      final storedChId = parsed["channelId"]?.toString() ?? '';
      if (storedChId == channelId) {
        // match => use
        debugPrint('[Debug] channelId matched => use cached JSON');
        FFAppState().videoListJson = cachedJson;

        // JSON から uploadsPlaylistId / nextPageToken を復元
        final cachedUpId = parsed["uploadsPlaylistId"]?.toString() ?? '';
        final cachedNextToken = parsed["nextPageToken"]?.toString() ?? '';
        FFAppState().uploadsPlaylistId = cachedUpId;
        FFAppState().nextPageToken = cachedNextToken;
      } else {
        // mismatch => fetch 1page
        debugPrint('[Debug] mismatch => fetchOnePage');
        await _fetchOnePageAndMerge(channelId);
      }
    } else {
      debugPrint('[Debug] no cached => fetchOnePage');
      await _fetchOnePageAndMerge(channelId);
    }
  } else {
    // 3-B) cache invalid => fetchOnePage
    debugPrint('[Debug] cache not valid => fetchOnePage');
    await _fetchOnePageAndMerge(channelId);
  }

  // 4) parse JSON => fill test
  // ↓ デバッグログ省略: FFAppState().videoListJson => ...
  final items =
      await myActions.extractItemsListFromJson(FFAppState().videoListJson);
  FFAppState().test = (items ?? []).toList();
  debugPrint('[Debug] FFAppState().test => length=${FFAppState().test.length}');

  // 5) pick first => set selectedVideoId => HTML
  if (FFAppState().test.isNotEmpty) {
    final firstVidId =
        await myActions.extractVideoIdFromJson(FFAppState().videoListJson);
    FFAppState().selectedVideoId = firstVidId ?? '';
    FFAppState().HTMLForWebView =
        _buildIframeHtml(FFAppState().selectedVideoId);

    // set selectedItem, icon
    FFAppState().selectedItem = FFAppState().test.first;
    final snippet = FFAppState().selectedItem?['snippet'];
    if (snippet != null && snippet['channelId'] != null) {
      final topChId = snippet['channelId'].toString();
      final iconUrl = await myActions.findIconUrlByChannelId(topChId);
      FFAppState().selectedIconUrl = iconUrl ?? '';
    } else {
      FFAppState().selectedIconUrl = '';
    }
  } else {
    // empty => clear
    FFAppState().selectedVideoId = '';
    FFAppState().HTMLForWebView = '';
    FFAppState().selectedItem = null;
    FFAppState().selectedIconUrl = '';
  }

  debugPrint('=== [Debug] loadChannelData END ===\n');
}

/// ====================
/// _fetchOnePageAndMerge
/// ====================
/// 24h後など、1ページだけ再取得し 既存リスト先頭に差し込む例
Future<void> _fetchOnePageAndMerge(String channelId) async {
  debugPrint('=== [Debug] _fetchOnePageAndMerge => $channelId ===');

  // 1) call ChannelsList => get uploadsPlaylistId
  final chRes = await ChannelsListAPICallCall.call(channelId: channelId);
  if (chRes == null || !chRes.succeeded) {
    debugPrint('[Debug] ChannelsListAPICallCall fail => $channelId');
    return;
  }
  final upId = getJsonField(
        chRes.jsonBody,
        r'$.items[0].contentDetails.relatedPlaylists.uploads',
      )?.toString() ??
      '';
  if (upId.isEmpty) {
    debugPrint('[Debug] cannot find uploadsPlaylistId => skip');
    return;
  }

  // 2) fetch 1 page => "latest" items
  final latestRes = await PlaylistItemsListAPICallCall.call(
    uploadsPlaylistId: upId,
    token: '', // always 1st page
  );
  if (latestRes == null || !latestRes.succeeded) {
    debugPrint('[Debug] playlistRes fail => $latestRes');
    return;
  }
  final newBody = latestRes.jsonBody;
  if (newBody == null) return;

  final newStr = (newBody is String) ? newBody : jsonEncode(newBody);

  // 1ページ目 nextPageToken
  final newNextToken =
      getJsonField(newBody, r'$.nextPageToken')?.toString() ?? '';

  // 3) parse new items
  final newItems = getJsonField(newBody, r'$.items').toList();
  debugPrint('[Debug] newItems(1st page) => count=${newItems.length}');

  // 4) load old JSON => old items
  String oldRaw = FFAppState().videoListJson;
  if (oldRaw.isEmpty) {
    oldRaw = '{}';
  }
  Map<String, dynamic> oldJson;
  try {
    oldJson = jsonDecode(oldRaw) as Map<String, dynamic>;
  } catch (e) {
    oldJson = <String, dynamic>{};
  }

  // mismatch => reset if needed
  final oldCh = (oldJson["channelId"] ?? '') as String;
  if (oldCh.isNotEmpty && oldCh != channelId) {
    oldJson = <String, dynamic>{};
  }

  // old items
  List<dynamic> oldItems = [];
  if (oldJson["items"] is List) {
    oldItems = oldJson["items"] as List<dynamic>;
  }

  // 5) create Set of old videoIds => for dedup
  final oldIdSet = <String>{};
  for (final it in oldItems) {
    if (it is Map) {
      final snippet = it["snippet"];
      if (snippet is Map) {
        final rid = snippet["resourceId"];
        if (rid is Map && rid["videoId"] is String) {
          oldIdSet.add(rid["videoId"] as String);
        }
      }
    }
  }

  // 6) loop newItems in reverse => insert(0, item)
  int insertedCount = 0;
  for (int i = newItems.length - 1; i >= 0; i--) {
    final item = newItems[i];
    if (item is Map) {
      final snippet = item["snippet"];
      if (snippet is Map) {
        final rid = snippet["resourceId"];
        if (rid is Map && rid["videoId"] is String) {
          final vid = rid["videoId"] as String;
          if (!oldIdSet.contains(vid)) {
            oldItems.insert(0, item);
            oldIdSet.add(vid);
            insertedCount++;
          }
        }
      }
    }
  }
  debugPrint('[Debug] insertedCount => $insertedCount');

  // 7) combine => store to JSON
  oldJson["channelId"] = channelId;
  oldJson["uploadsPlaylistId"] = upId;
  oldJson["nextPageToken"] = newNextToken;
  oldJson["items"] = oldItems;

  final mergedJsonStr = jsonEncode(oldJson);

  // 8) store to Hive
  await myActions.storeVideoListJsonSafely(mergedJsonStr, channelId);
  FFAppState().videoListJson = mergedJsonStr;

  // 9) set to FFAppState
  FFAppState().uploadsPlaylistId = upId;
  FFAppState().nextPageToken = newNextToken;

  // 10) update timestamp => fresh
  await myActions.updateChannelTimestamp(channelId);

  debugPrint('=== [Debug] _fetchOnePageAndMerge done ===');
}

/// ====================
/// _clearUIState: UI初期化
/// ====================
void _clearUIState() {
  FFAppState().videoListJson = '';
  FFAppState().test = [];
  FFAppState().selectedVideoId = '';
  FFAppState().HTMLForWebView = '';
  FFAppState().selectedItem = null;
  FFAppState().selectedIconUrl = '';
  FFAppState().nextPageToken = '';
  FFAppState().uploadsPlaylistId = '';
}

/// ====================
/// _buildIframeHtml: HTML生成
/// ====================
String _buildIframeHtml(String videoId) {
  return '''
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    .video-container {
      position: relative;
      width: 100%;
      padding-top: 65%;
      overflow: hidden;
    }
    .video-container iframe {
      position: absolute;
      top: 0; left: 0;
      width: 100%; height: 100%;
      border: 0;
    }
  </style>
</head>
<body style="margin:0; padding:0; overflow:hidden;">
  <div class="video-container">
    <iframe
      src="https://www.youtube.com/embed/$videoId?autoplay=0"
      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
      allowfullscreen>
    </iframe>
  </div>
</body>
</html>
''';
}
