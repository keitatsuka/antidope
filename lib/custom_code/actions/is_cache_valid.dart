// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:hive_flutter/hive_flutter.dart';

String? isCacheValid(String? timestampString, String? expiryMsString) {
  if (timestampString == null || expiryMsString == null) {
    return null; // 引数がnullなら判断できないのでnull返す
  }

  int? timestamp = int.tryParse(timestampString);
  int? expiryMs = int.tryParse(expiryMsString);

  if (timestamp == null || expiryMs == null) {
    return null; // パース失敗時もnull返す
  }

  int now = DateTime.now().millisecondsSinceEpoch;
  int elapsed = now - timestamp;

  if (elapsed < expiryMs) {
    return "true";
  } else {
    return "false";
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
