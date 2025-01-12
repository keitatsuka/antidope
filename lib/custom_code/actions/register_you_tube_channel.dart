// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// File: register_youtube_channel.dart
import '/backend/api_requests/api_calls.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

/// Action Name: registerYouTubeChannel
/// Arguments: (String url)
/// Return: JSON
/// Flow:
///   1) parseYouTubeUrlAction(url) → "videoId","channelId","customName"
///   2) if videoId => VideosListAPI -> ChannelsListAPI -> saveHive
///   3) else if channelId => ChannelsListAPI -> saveHive
///   4) reload channels -> FFAppState().channelsList
///   5) clearVideoListJson
///   6) return {"status":"ok"} or {"status":"error","message":"..."}
Future<dynamic> registerYouTubeChannel(String url) async {
  // 0) parse
  final parseJsonString = parseYouTubeUrlAction(url);
  if (parseJsonString == null || parseJsonString.isEmpty) {
    return {"status": "error", "message": "Empty parse result"};
  }
  final parseObj = jsonDecode(parseJsonString);
  final videoId = parseObj["videoId"] as String?;
  final channelId = parseObj["channelId"] as String?;
  final customName = parseObj["customName"] as String?;

  // 1) if videoId != null => VideosListAPI
  if (videoId != null && videoId.isNotEmpty) {
    final videoRes = await VideosListAPICallCall.call(id: videoId);
    if (videoRes == null || videoRes.succeeded == false) {
      return {"status": "error", "message": "VideosList API failed"};
    }
    // channelIdを取得
    final extractedChId =
        getJsonField(videoRes.jsonBody, r'$.items[0].snippet.channelId')
            .toString();
    if (extractedChId.isEmpty) {
      return {
        "status": "error",
        "message": "Cannot extract channelId from videoRes"
      };
    }
    // さらに channel info
    final channelRes =
        await ChannelsListAPICallCall.call(channelId: extractedChId);
    if (channelRes == null || channelRes.succeeded == false) {
      return {"status": "error", "message": "ChannelsList API failed"};
    }
    final chName =
        getJsonField(channelRes.jsonBody, r'$.items[0].snippet.title')
            .toString();
    final chIcon = getJsonField(
            channelRes.jsonBody, r'$.items[0].snippet.thumbnails.default.url')
        .toString();
    // 保存
    await saveYoutubeChannelToHive(
      extractedChId,
      chName,
      chIcon,
    );

    // 2) else if channelId != null => ChannelsListAPI
  } else if (channelId != null && channelId.isNotEmpty) {
    final channelRes = await ChannelsListAPICallCall.call(channelId: channelId);
    if (channelRes == null || channelRes.succeeded == false) {
      return {"status": "error", "message": "ChannelsList API failed"};
    }
    final chName =
        getJsonField(channelRes.jsonBody, r'$.items[0].snippet.title')
            .toString();
    final chIcon = getJsonField(
            channelRes.jsonBody, r'$.items[0].snippet.thumbnails.default.url')
        .toString();

    // save
    await saveYoutubeChannelToHive(
      channelId,
      chName,
      chIcon,
    );

    // 3) else if customName != null => fallback
  } else if (customName != null && customName.isNotEmpty) {
    // ここはユーザーの要件によって処理を追加する
    // e.g. ChannelsListAPICallCall, or "Cannot handle customName yet"
    return {"status": "error", "message": "Custom name not supported yet"};
  } else {
    return {"status": "error", "message": "No videoId / channelId found"};
  }

  // 4) reload channels -> FFAppState
  final updatedList = await fetchChannelsListFromHiveAsJson();
  FFAppState().channelsList = (updatedList as List).toList();

  // 5) clearVideoListJson
  await clearVideoListJson();

  // 6) return success
  return {"status": "ok"};
}
