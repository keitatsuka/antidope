// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:hive/hive.dart';

Future<String?> debugBookmarkBoxContents() async {
  final box = Hive.box('bookmarkBox');

  // 1) boxの全データを取得
  final allData = box.toMap();

  // 2) debugPrintで一括出力
  debugPrint('=== debugBookmarkBoxContents ===');
  debugPrint('bookmarkBox length => ${allData.length}');
  for (final entry in allData.entries) {
    debugPrint('Key=${entry.key}, Value=${entry.value}');
  }

  // 文字列型が必須ならnullを返す
  return null;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
