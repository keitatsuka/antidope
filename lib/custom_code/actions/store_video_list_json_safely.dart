// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<String?> storeVideoListJsonSafely(dynamic responseBody) async {
  if (responseBody == null) {
    return null;
  }

  String rawJsonString;
  if (responseBody is String) {
    rawJsonString = responseBody;
  } else {
    rawJsonString = jsonEncode(responseBody);
  }

  if (rawJsonString.isNotEmpty) {
    // Hive への保存
    await saveVideoListJson(rawJsonString);
    // ★ ここで rawJsonString を返すようにする！
    return rawJsonString;
  }

  // 空文字列なら null を返す
  return null;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
