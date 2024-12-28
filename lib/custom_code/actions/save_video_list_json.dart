// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:hive/hive.dart';

/// saveVideoListJson
///
/// 【説明】
/// 「APIレスポンス文字列」（既にダブルクォート付きJSON）をそのまま
/// "videoList" キーで Hive に保存する。
///
/// 【注意点】
/// - 引数が null なら何もしません。
/// - 既に "cacheBox" は開いてある前提です。
/// - 呼び出し側は、(apiResultsvm?.jsonBody ?? '') などのStringを渡す想定です。
///
Future<String?> saveVideoListJson(String? responseBody) async {
  /// MODIFY CODE ONLY BELOW THIS LINE
  if (responseBody == null) {
    return null; // 引数がnullなら何もしない
  }

  // 'cacheBox' は既にオープンしてある前提
  var box = Hive.box('cacheBox');

  // 文字列をそのまま保存（jsonEncodeは呼ばない）
  await box.put('videoList', responseBody);

  return null; // FlutterFlowがString?型を要求するためnullを返す
  /// MODIFY CODE ONLY ABOVE THIS LINE
}
