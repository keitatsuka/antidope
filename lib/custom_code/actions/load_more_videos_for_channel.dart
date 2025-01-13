// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// load_more_videos_for_channel.dart
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import '/custom_code/actions/index.dart' as myActions;
import '/backend/api_requests/api_calls.dart';
import 'dart:convert';

Future<String?> loadMoreVideosForChannel(String channelId) async {
  debugPrint('\n=== [Debug] loadMoreVideosForChannel START ===');
  debugPrint('channelId => $channelId');

  // 1) check
  if (channelId.isEmpty) {
    return 'channelId empty';
  }
  if (FFAppState().ChannelId != channelId) {
    // mismatch => skip
    return 'Channel changed mid-load.';
  }
  final token = FFAppState().nextPageToken ?? '';
  if (token.isEmpty) {
    return 'No more pages.';
  }
  final upId = FFAppState().uploadsPlaylistId ?? '';
  if (upId.isEmpty) {
    return 'No uploadsPlaylistId => cannot loadMore';
  }

  // 2) call
  final listRes = await PlaylistItemsListAPICallCall.call(
    uploadsPlaylistId: upId,
    token: token,
  );
  if (listRes == null || !listRes.succeeded) {
    return 'API fail.';
  }
  final newBody = listRes.jsonBody;
  if (newBody == null) {
    return 'No data';
  }

  // parse items
  final newItems = getJsonField(newBody, r'$.items').toList();
  final newToken = getJsonField(newBody, r'$.nextPageToken').toString();

  // 3) append to FFAppState().test
  final oldList = FFAppState().test;
  oldList.addAll(newItems);
  FFAppState().test = oldList;

  FFAppState().nextPageToken = newToken.isEmpty ? '' : newToken;

  // 4) read old JSON => merge => store
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
  // if mismatch => reset
  final storedCh = (oldJson["channelId"] ?? '') as String;
  if (storedCh.isNotEmpty && storedCh != channelId) {
    oldJson = <String, dynamic>{};
  }

  // combine
  oldJson["items"] = FFAppState().test;
  oldJson["nextPageToken"] = newToken;
  oldJson["channelId"] = channelId;

  final mergedStr = jsonEncode(oldJson);
  await myActions.storeVideoListJsonSafely(mergedStr, channelId);
  FFAppState().videoListJson = mergedStr;

  debugPrint('=== [Debug] loadMoreVideosForChannel DONE ===');
  return null;
}
