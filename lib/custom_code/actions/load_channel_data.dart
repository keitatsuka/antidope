// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import '/backend/api_requests/api_calls.dart';
import '/custom_code/actions/index.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/custom_code/actions/index.dart' as myActions;
import 'dart:convert';

Future<void> loadChannelData(String channelId) async {
  debugPrint('\n=== [Debug] loadChannelData START ===');
  debugPrint('channelId => $channelId');

  // 1) Quick exit if channelId empty
  if (channelId.isEmpty) {
    debugPrint('[Debug] channelId is empty => clearing UI...');
    FFAppState().videoListJson = '';
    FFAppState().test = [];
    FFAppState().selectedVideoId = '';
    FFAppState().HTMLForWebView = '';
    FFAppState().selectedItem = null;
    FFAppState().selectedIconUrl = '';
    FFAppState().nextPageToken = '';
    FFAppState().uploadsPlaylistId = '';
    return;
  }

  // --- (1) チャンネルが違う場合はリセット ---
  final oldCh = FFAppState().ChannelId;
  if (oldCh != channelId) {
    debugPrint('[Debug] channel changed => oldCh=$oldCh, new=$channelId');
    // リセット
    FFAppState().uploadsPlaylistId = '';
    FFAppState().nextPageToken = '';
    FFAppState().videoListJson = '';
    // もし oldCh のUI状態をクリアしたいなら testなども空に
    FFAppState().test = [];
    FFAppState().ChannelId = channelId;
  }

  // 2) Check if cache is valid (24h)
  final isValid = await myActions.isChannelCacheValid(channelId, '86400000');
  debugPrint('[Debug] isChannelCacheValid($channelId) => $isValid');

  if (isValid) {
    // (2) read from Hive
    final cachedJson = await myActions.getCachedVideoListForChannel(channelId);
    debugPrint(
        '[Debug] getCachedVideoListForChannel($channelId) => $cachedJson');

    // --- (3) キャッシュのchannelIdと一致しているか判定 ---
    if (cachedJson != null && cachedJson.isNotEmpty) {
      final parsed = jsonDecode(cachedJson) as Map<String, dynamic>;
      final storedChId = parsed["channelId"]?.toString() ?? '';
      if (storedChId == channelId) {
        // ok => 使う
        FFAppState().videoListJson = cachedJson;
      } else {
        // mismatch => fetch
        await _fetchAndCacheOnePage(channelId);
      }
    } else {
      debugPrint('[Debug] no cached => fetch first page');
      await _fetchAndCacheOnePage(channelId);
    }
  } else {
    debugPrint('[Debug] cache not valid => fetchOnePage');
    await _fetchAndCacheOnePage(channelId);
  }

  // 3) after fetch => parse
  debugPrint(
      '[Debug] FFAppState().videoListJson => ${FFAppState().videoListJson}');
  final items =
      await myActions.extractItemsListFromJson(FFAppState().videoListJson);
  FFAppState().test = (items ?? []).toList();
  debugPrint('[Debug] FFAppState().test => length=${FFAppState().test.length}');

  // 4) set top video
  if (FFAppState().test.isNotEmpty) {
    final firstVid =
        await myActions.extractVideoIdFromJson(FFAppState().videoListJson);
    FFAppState().selectedVideoId = firstVid ?? '';
    FFAppState().HTMLForWebView =
        _buildIframeHtml(FFAppState().selectedVideoId);

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
    // clear
    FFAppState().selectedVideoId = '';
    FFAppState().HTMLForWebView = '';
    FFAppState().selectedItem = null;
    FFAppState().selectedIconUrl = '';
  }

  debugPrint('=== [Debug] loadChannelData END ===\n');
}

Future<void> _fetchAndCacheOnePage(String channelId) async {
  debugPrint('=== [Debug] _fetchAndCacheOnePage => $channelId ===');

  // 1) get channel detail => uploadsPlaylistId
  final chRes = await ChannelsListAPICallCall.call(channelId: channelId);
  if (chRes == null || !chRes.succeeded) {
    debugPrint('[Debug] ChannelsListAPICallCall failed => $channelId');
    return;
  }
  final upId = getJsonField(
        chRes.jsonBody,
        r'$.items[0].contentDetails.relatedPlaylists.uploads',
      )?.toString() ??
      '';

  if (upId.isEmpty) {
    debugPrint('[Debug] cannot find uploadsPlaylistId => return');
    return;
  }
  FFAppState().uploadsPlaylistId = upId;

  // 2) fetch 1 page
  final listRes = await PlaylistItemsListAPICallCall.call(
    uploadsPlaylistId: upId,
    token: '',
  );
  if (listRes == null || !listRes.succeeded) {
    debugPrint('[Debug] playlistRes fail => $listRes');
    return;
  }

  final rawBody = listRes.jsonBody;
  if (rawBody == null) {
    return;
  }
  final raw = (rawBody is String) ? rawBody : jsonEncode(rawBody);

  // nextPageToken
  final nextToken = getJsonField(rawBody, r'$.nextPageToken')?.toString() ?? '';
  FFAppState().nextPageToken = nextToken;

  // (4) store => Hive
  //   channelIdを記録しておけば後続で mismatchチェック できる
  Map<String, dynamic> parsed;
  try {
    parsed = jsonDecode(raw) as Map<String, dynamic>;
  } catch (e) {
    parsed = {};
  }
  parsed["channelId"] = channelId;
  final finalJson = jsonEncode(parsed);

  // 5) store
  final storedJson = await myActions.storeVideoListJsonSafely(
    finalJson,
    channelId,
  );
  FFAppState().videoListJson = storedJson ?? '';
}

String _buildIframeHtml(String videoId) {
  return '''
<html>
 <head>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <style>
     .video-container {
       position: relative; width: 100%; padding-top: 65%; overflow: hidden;
     }
     .video-container iframe {
       position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: 0;
     }
   </style>
 </head>
 <body style="margin:0;padding:0;overflow:hidden;">
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
