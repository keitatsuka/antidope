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

Future<dynamic> findChannelIconUrl(String lastUsedChId) async {
  // FFAppState().channelsList がListである前提
  final channels = FFAppState().channelsList;

  // 念のためチェック
  if (channels is! List) {
    // channelsListがList型でないなら空のMapを返す
    return {};
  }

  // ループしてchannelIdを比較
  for (final item in channels) {
    final chId = getJsonField(item, r"$.channelId")?.toString() ?? "";
    if (chId == lastUsedChId) {
      // iconUrlを取得
      final iconUrl = getJsonField(item, r"$.iconUrl")?.toString() ?? "";

      // JSONオブジェクトとして返却したい場合
      // 例えば {"url": "https://...", "someKey": "..."} のように自由に構造を定義できる
      final result = {
        "iconUrl": iconUrl, // アイコンURL
        // 必要なら "title" や "width" など追加
      };

      return result; // Return Type=JSON
    }
  }

  // 該当チャンネルIDが見つからなかった場合、空のMapを返す
  return {};
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
