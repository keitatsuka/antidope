// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart'; // Import other custom actions
import '/flutter_flow/custom_functions.dart'; // Import custom functions

import 'package:hive/hive.dart';

Future<dynamic> fetchChannelsListFromHiveAsJson() async {
  // 1) Hiveのboxを開く/再利用
  var box = Hive.box('channelsBox');

  // 2) たとえば "youtubeChannels" に保存済みとする
  //    リストがなければデフォルト [] を返す
  final rawList = box.get('youtubeChannels', defaultValue: []);

  // 3) rawList は List<dynamic> or List<Map>想定
  //    Return Type: JSON => FlutterFlow では dynamic でOK
  debugPrint('fetchChannels => rawList=$rawList');

  return rawList;
  // ★ここでは "jsonEncode" はしない。List自体をreturnし、Return Type=JSONで認識させる
}
