// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // 他のcustom actionsをまとめたファイル
import '/flutter_flow/custom_functions.dart'; // custom functions

import 'dart:convert';
import '/backend/api_requests/api_calls.dart'; // FlutterFlowで生成されたYouTube Data API
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// fetchVideoDataAndCreateBookmark
///  - [videoId] を元に YouTube Data API (videos) を呼び出し、
///    snippetやtitleなどを取得して createBookmark.
///  - 成功時: true, 失敗時: false を返す
Future<bool> fetchVideoDataAndCreateBookmark(String videoId) async {
  debugPrint('=== fetchVideoDataAndCreateBookmark START ===');
  debugPrint('videoId => $videoId');

  try {
    // 1) YouTube Data API: videos?id=videoId を呼び出し
    debugPrint(
        '[fetchVideoData] => calling VideosListAPICallCall with id=$videoId');
    final res = await VideosListAPICallCall.call(
      id: videoId,
    );

    // 2) API成功判定
    if (res == null) {
      debugPrint('[fetchVideoData] => res is null => fail');
      debugPrint('=== fetchVideoDataAndCreateBookmark END (null response) ===');
      return false;
    }
    if (!res.succeeded) {
      debugPrint('[fetchVideoData] => res.succeeded == false => fail');
      debugPrint('res.succeeded => ${res.succeeded}');
      debugPrint('res.statusCode => ${res.statusCode}');
      debugPrint('res.jsonBody => ${res.jsonBody}');
      debugPrint('=== fetchVideoDataAndCreateBookmark END (API error) ===');
      return false;
    }

    final jsonBody = res.jsonBody;
    if (jsonBody == null) {
      debugPrint('[fetchVideoData] => jsonBody is null => fail');
      debugPrint('=== fetchVideoDataAndCreateBookmark END (jsonBody=null) ===');
      return false;
    }

    debugPrint('[fetchVideoData] => jsonBody => $jsonBody');

    // 3) items[0] を取り出す
    final items = getJsonField(jsonBody, r'$.items').toList();
    debugPrint('[fetchVideoData] => items.length => ${items.length}');

    if (items.isEmpty) {
      debugPrint('[fetchVideoData] => items isEmpty => fail');
      debugPrint('=== fetchVideoDataAndCreateBookmark END (no items) ===');
      return false;
    }

    final item = items[0];
    debugPrint('[fetchVideoData] => first item => $item');

    // snippet を取得
    final snippet = getJsonField(item, r'$.snippet');
    debugPrint('[fetchVideoData] => snippet => $snippet');

    if (snippet == null) {
      debugPrint('[fetchVideoData] => snippet is null => fail');
      debugPrint('=== fetchVideoDataAndCreateBookmark END (no snippet) ===');
      return false;
    }

    // 4) resourceId 下に videoId を埋め込む (createBookmark で "snippet.resourceId.videoId" を参照するため)
    final resourceId = {"videoId": videoId};

    final itemData = {
      "kind": getJsonField(item, r'$.kind'),
      "etag": getJsonField(item, r'$.etag'),
      "id": getJsonField(item, r'$.id'),
      "snippet": {
        "publishedAt": getJsonField(snippet, r'$.publishedAt'),
        "channelId": getJsonField(snippet, r'$.channelId'),
        "channelTitle": getJsonField(snippet, r'$.channelTitle'),
        "title": getJsonField(snippet, r'$.title'),
        "thumbnails": getJsonField(snippet, r'$.thumbnails'),
        "resourceId": resourceId,
      },
    };

    debugPrint(
        '[fetchVideoData] => itemData (for createBookmark) => $itemData');

    // 5) createBookmark に渡す
    debugPrint('[fetchVideoData] => calling createBookmark...');
    await createBookmark(itemData);

    debugPrint('=== fetchVideoDataAndCreateBookmark END (success=true) ===');
    return true;
  } catch (e) {
    debugPrint('[Error] fetchVideoDataAndCreateBookmark => $e');
    debugPrint('=== fetchVideoDataAndCreateBookmark END (exception=false) ===');
    return false;
  }
}
