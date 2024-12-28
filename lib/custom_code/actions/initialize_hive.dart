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
  // Hive初期化処理: FlutterFlowの環境で実行
  // 通常awaitを使いますが、Custom Actionではawait可。もし不可ならthen()で対応
  await Hive.initFlutter();

  // キャッシュ用Boxを開く。既に開いていれば再利用。
  // "cacheBox"という名前でBoxを用意
  await Hive.openBox('cacheBox');

  return null; // FlutterFlowがString?必須の場合にはnullを返す
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
