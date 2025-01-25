// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// getCachedVideoListForChannel.dart (修正後)

import 'dart:convert';
import 'package:hive/hive.dart';

Future<String?> getCachedVideoListForChannel(String channelId) async {
  // 【CHANGED】"videoList_$channelId" というキーを読む
  final box = Hive.box('channelsBox');
  final jsonString = box.get('videoList_$channelId', defaultValue: null);
  if (jsonString == null) {
    return null;
  }

  // 【ADDED】(任意) channelIdと合っているか確認したい場合は以下
  //   ここでは単にjsonStringを返すのみ。
  // try {
  //   final parsed = jsonDecode(jsonString) as Map<String, dynamic>;
  //   if (parsed["channelId"] != channelId) {
  //     debugPrint('[Debug] mismatch channel => clearing?');
  //     // return null; // or handle mismatch
  //   }
  // } catch(e) {
  //   // parse error => return null
  // }

  return jsonString; // can be null
}
