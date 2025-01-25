// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String? extractValueFromJsonString(
  String jsonString,
  String jsonPath,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (jsonString == null ||
      jsonString.isEmpty ||
      jsonPath == null ||
      jsonPath.isEmpty) {
    return null;
  }

  try {
    final data = jsonDecode(jsonString);
    // ここでは単純に data[jsonPath] として取得
    // JSONPathの本格実装ではなく、キー1つの場合を想定
    final value = data[jsonPath];
    if (value == null) {
      return null;
    }
    return value.toString();
  } catch (e) {
    // 解析失敗ならnull
    return null;
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
