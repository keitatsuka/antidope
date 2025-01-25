// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// storeVideoListJsonSafely.dart (修正後)

import 'dart:convert';
import 'package:hive/hive.dart';

Future<String?> storeVideoListJsonSafely(
  String? responseBody,
  String? channelId,
) async {
  if (responseBody == null || channelId == null) return null;

  // responseBodyが既に文字列のJSONかどうかチェック
  String rawJsonString;
  if (responseBody is String) {
    rawJsonString = responseBody;
  } else {
    rawJsonString = jsonEncode(responseBody);
  }

  if (rawJsonString.isEmpty) {
    return null;
  }

  try {
    // 【ADDED】JSON内部に channelId を埋め込みたい場合
    // 1) decode
    Map<String, dynamic> parsed;
    try {
      parsed = jsonDecode(rawJsonString) as Map<String, dynamic>;
    } catch (e) {
      // パース失敗時 => そのまま保存も可能だが、衝突回避したいなら return
      debugPrint('[Debug] storeVideoListJsonSafely parse error => $e');
      return null;
    }

    // 2) channelIdを記録 (すでにあるなら上書きOK)
    parsed["channelId"] = channelId;

    // 3) 再encode
    final merged = jsonEncode(parsed);

    // 【CHANGED】channelsBoxを開き、'videoList_$channelId' へput
    final box = Hive.box('channelsBox');
    await box.put('videoList_$channelId', merged);

    return merged;
  } catch (e) {
    debugPrint('[Debug] storeVideoListJsonSafely error => $e');
    return null;
  }
}
