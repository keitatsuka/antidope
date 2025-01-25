// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // 他の custom actions
import '/flutter_flow/custom_functions.dart'; // custom functions

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// disablePassCode
/// - Hiveの"4digitPass"キーを削除し、パスワードを未設定状態に戻す
/// - 成功したらtrueを返す
Future<bool> disablePassCode() async {
  try {
    final box = Hive.box('passCodeBox');
    // キーごと削除
    await box.delete('4digitPass');
    return true;
  } catch (e) {
    debugPrint('[disablePassCode] Error => $e');
    return false;
  }
}
