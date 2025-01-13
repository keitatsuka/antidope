// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:convert';
import '/backend/api_requests/api_calls.dart';
import '/custom_code/actions/index.dart' as myActions;

Future<String?> loadMoreVideosForChannel(String channelId) async {
  debugPrint('\n=== [Debug] loadMoreVideosForChannel START ===');
  debugPrint('channelId => $channelId');

  // 1) checks
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
  if (listRes == null || !(listRes.succeeded)) {
    return 'API fail.';
  }
  final body = listRes.jsonBody;
  if (body == null) {
    return 'No data.';
  }

  // parse new items
  final newItems = getJsonField(body, r'$.items').toList();
  final newToken = getJsonField(body, r'$.nextPageToken').toString();

  // 3) append
  final oldList = FFAppState().test;
  oldList.addAll(newItems);
  FFAppState().test = oldList;

  FFAppState().nextPageToken = (newToken.isEmpty) ? '' : newToken;

  // 4) merge JSON => store
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
  final storedCh = (oldJson["channelId"] ?? '') as String;
  if (storedCh.isNotEmpty && storedCh != channelId) {
    oldJson = <String, dynamic>{};
  }

  // combine
  oldJson["channelId"] = channelId;
  oldJson["uploadsPlaylistId"] = upId; // ← keep track in JSON
  oldJson["nextPageToken"] = FFAppState().nextPageToken;
  oldJson["items"] = FFAppState().test;

  final merged = jsonEncode(oldJson);
  await myActions.storeVideoListJsonSafely(merged, channelId);
  FFAppState().videoListJson = merged;

  // update timestamp => fresh
  await myActions.updateChannelTimestamp(channelId);

  debugPrint('=== [Debug] loadMoreVideosForChannel DONE ===');
  return null;
}
