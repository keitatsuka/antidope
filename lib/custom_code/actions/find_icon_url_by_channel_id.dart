// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/// findIconUrlByChannelIdNoArg
///  - [channelId]: string
///  - AppState の channelsList を直接参照して探す
///  - 戻り値: JSON(Map)として { "iconUrl": "..." } を返す
///    見つからなければ {}
Future<dynamic> findIconUrlByChannelId(String? channelId) async {
  // channelId が null/空 なら空Mapを返す
  if (channelId == null || channelId.isEmpty) {
    return {};
  }

  // FFAppState().channelsList が格納されている想定
  final channels = FFAppState().channelsList; // JSON配列

  // channels が List かチェック
  if (channels is! List) {
    return {}; // リストじゃなければ空Map返す
  }

  // ループで channelId を探す
  for (final item in channels) {
    if (item is Map &&
        item['channelId'] == channelId &&
        item['iconUrl'] != null) {
      // 見つかった場合 { "iconUrl": "..." } を返却
      return {
        "iconUrl": item["iconUrl"],
        // 必要なら "channelName" や他の情報を返すことも可
      };
    }
  }

  // 見つからなければ空Map
  return {};
}
// DO NOT REMOVE OR MODIFY THE CODE BELOW!
