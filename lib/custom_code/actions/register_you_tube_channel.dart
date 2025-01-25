// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// register_you_tube_channel.dart
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import '/backend/api_requests/api_calls.dart';
import '/custom_code/actions/index.dart';
import '/custom_code/actions/load_channel_data.dart'; // => to call loadChannelData
import 'dart:convert';

Future<dynamic> registerYouTubeChannel(String url) async {
  debugPrint('=== registerYouTubeChannel START ===');
  // 1) parse
  final parsedStr = parseYouTubeUrlAction(url);
  if (parsedStr == null || parsedStr.isEmpty) {
    return {"status": "error", "message": "Empty parse result"};
  }
  final obj = jsonDecode(parsedStr);
  final vid = obj["videoId"] as String?;
  final chId = obj["channelId"] as String?;
  final customName = obj["customName"] as String?;

  String extractedChId = '';

  if (vid != null && vid.isNotEmpty) {
    // find channel from video
    final videoRes = await VideosListAPICallCall.call(id: vid);
    if (videoRes == null || !videoRes.succeeded) {
      return {"status": "error", "message": "VideosList fail"};
    }
    extractedChId =
        getJsonField(videoRes.jsonBody, r'$.items[0].snippet.channelId')
            .toString();
    if (extractedChId.isEmpty) {
      return {
        "status": "error",
        "message": "Cannot extract channelId from video"
      };
    }
    // get channel info
    final chRes = await ChannelsListAPICallCall.call(channelId: extractedChId);
    if (chRes == null || !chRes.succeeded) {
      return {"status": "error", "message": "ChannelList fail"};
    }
    final chName =
        getJsonField(chRes.jsonBody, r'$.items[0].snippet.title').toString();
    final chIcon = getJsonField(
            chRes.jsonBody, r'$.items[0].snippet.thumbnails.default.url')
        .toString();

    // save
    await saveYoutubeChannelToHive(extractedChId, chName, chIcon);
  } else if (chId != null && chId.isNotEmpty) {
    // direct channel
    extractedChId = chId;
    final chRes = await ChannelsListAPICallCall.call(channelId: chId);
    if (chRes == null || !chRes.succeeded) {
      return {"status": "error", "message": "ChannelList fail 2"};
    }
    final chName =
        getJsonField(chRes.jsonBody, r'$.items[0].snippet.title').toString();
    final chIcon = getJsonField(
            chRes.jsonBody, r'$.items[0].snippet.thumbnails.default.url')
        .toString();
    await saveYoutubeChannelToHive(chId, chName, chIcon);
  } else if (customName != null && customName.isNotEmpty) {
    return {"status": "error", "message": "Not supported customName yet"};
  } else {
    return {"status": "error", "message": "No videoId / channelId"};
  }

  // reload channel list => FFAppState().channelsList
  final updatedList = await fetchChannelsListFromHiveAsJson();
  FFAppState().channelsList = (updatedList as List).toList();

  // loadChannelData => get nextPageToken
  if (extractedChId.isNotEmpty) {
    FFAppState().ChannelId = extractedChId;
    await loadChannelData(extractedChId);
  }

  debugPrint('=== registerYouTubeChannel END ===');
  return {"status": "ok", "channelId": extractedChId};
}
