// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // 他のcustom actionsをまとめたファイル
import '/flutter_flow/custom_functions.dart'; // custom functions

import 'package:hive/hive.dart';

/// checkPassCode
///   - [inputCode]: 画面から入力された4桁パスワード
///   - 戻り値: bool (true=一致, false=不一致または未設定)
Future<bool> checkPassCode(String inputCode) async {
  final box = Hive.box('passCodeBox');
  final saved = box.get('4digitPass', defaultValue: null);

  // パスワードが未設定の場合、falseを返す
  if (saved == null) {
    return false;
  }

  // 入力値と一致するか
  if (saved == inputCode) {
    return true;
  } else {
    return false;
  }
}
