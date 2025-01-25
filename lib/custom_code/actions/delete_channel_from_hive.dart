// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:hive/hive.dart';

/// Action Name: deleteChannelFromHive
/// Return Type: String  (FlutterFlowの仕様で String? を返すことが多い)
/// Description: 指定されたindexのチャンネルを 'youtubeChannels' リストから削除し、Hiveに保存し直す
Future<String?> deleteChannelFromHive(int index) async {
  // 1) boxを取得
  final box = Hive.box('channelsBox');

  // 2) 現状のリストを取得
  //    例: [ { "channelId":"UCxxxx", "channelName":"MyChannel", "iconUrl":"..."} , ... ]
  final currentList = box.get('youtubeChannels', defaultValue: []);

  // 3) インデックスが範囲内ならremove
  if (index >= 0 && index < currentList.length) {
    currentList.removeAt(index);
  }

  // 4) 再保存
  await box.put('youtubeChannels', currentList);

  // 5) return null
  return null;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
