// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// このアクションはアプリ起動時(Initial Actions)で実行することを想定
Future<String?> initializeHive() async {
  // main.dart
  await Hive.initFlutter();
// ここで 'channelsBox' も open
  await Hive.openBox('channelsBox');
  await Hive.openBox('bookmarkBox');
  await Hive.openBox('cacheBox');
// 'cacheBox' は使わないなら開かないでOK
// どうしても別用途で使うなら openBox('cacheBox') は残してよい

  return null; // FlutterFlowがString?必須の場合にはnullを返す
}
