// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String? getCurrentTimestampString() {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // 現在時刻をミリ秒単位で取得し、文字列化
  String currentMs = DateTime.now().millisecondsSinceEpoch.toString();

  return currentMs;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
