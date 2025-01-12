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
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/backend/api_requests/api_calls.dart'; // ← これで PlaylistItemsListAPICallCall を使える
import 'dart:convert';

Future<String?> loadMoreVideosForChannel(String channelId) async {
  // 1) FFAppState に現在の nextPageToken があるか確認
  final currentPageToken = FFAppState().nextPageToken;
  if (currentPageToken == null || currentPageToken.isEmpty) {
    // 次ページが存在しない(または取得済み) → 処理せず終了
    return 'No more pages';
  }

  debugPrint(
      '=== loadMoreVideosForChannel START with nextPageToken=$currentPageToken ===');

  // 2) まず channelIdから "uploadsPlaylistId" を取得済みなら使う or
  //    既に FFAppState に保存しているなら使う
  final uploadsId = FFAppState().uploadsPlaylistId;
  if (uploadsId == null || uploadsId.isEmpty) {
    return 'No uploads playlist ID found for channel=$channelId';
  }

  // 3) 追加取得のAPIコール
  //    FlutterFlow上で "PlaylistItemsListAPICallCall" に
  //    nextPageToken という引数が定義されている想定
  final playlistRes = await PlaylistItemsListAPICallCall.call(
    uploadsPlaylistId: uploadsId,
    nextPageToken: currentPageToken, // ← 修正済み: pageToken → nextPageToken
    maxResults: 50,
  );
  if (playlistRes == null || playlistRes.succeeded == false) {
    return 'API call failed or returned error';
  }

  // 4) JSONレスポンスを取り出す
  final rawBody = playlistRes.jsonBody;
  if (rawBody == null) {
    return 'No jsonBody found';
  }

  // 5) newItems を抽出（"items" 配列）
  final newItems = getJsonField(rawBody, r'$.items').toList();
  debugPrint('New items => $newItems');

  // 6) nextPageToken を取得
  final newPageToken = getJsonField(rawBody, r'$.nextPageToken').toString();
  debugPrint('New nextPageToken => $newPageToken');

  // 7) 既存の "test" リストに追加する
  final oldList = FFAppState().test;
  if (oldList is List) {
    oldList.addAll(newItems);
    FFAppState().test = oldList;
  }

  // 8) nextPageToken 更新（無い場合は空に）
  if (newPageToken.isEmpty) {
    FFAppState().nextPageToken = '';
  } else {
    FFAppState().nextPageToken = newPageToken;
  }

  debugPrint('=== loadMoreVideosForChannel DONE ===');
  return null;
}
