// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<bool> checkChannelExists(String lastUsedChId) async {
  // 1) channelsListを取得（JSON配列想定）
  final channels = FFAppState().channelsList;

  // 2) 正しい型かをチェック
  if (channels is! List) {
    // リストとして扱えない場合はfalseを返す
    return false;
  }

  // 3) ループで channelId を比較
  for (final item in channels) {
    final chId = getJsonField(item, r"$.channelId")?.toString() ?? "";
    if (chId == lastUsedChId) {
      return true; // 見つかった場合にtrueを返す
    }
  }

  // 見つからなければfalse
  return false;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
