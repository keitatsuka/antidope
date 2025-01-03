// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

String? extractVideoIdFromJson(String? jsonString) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (jsonString == null) {
    return null; // 引数がnullなら何もしない
  }

  // JSON文字列をMapにデコード
  final data = jsonDecode(jsonString);

  // 'items' が存在し、最低1件あるか
  if (data['items'] == null || data['items'].isEmpty) {
    return null;
  }

  final firstItem = data['items'][0];
  if (firstItem == null) {
    return null;
  }

  // パターン1: snippet.resourceId.videoId が入っている
  if (firstItem['snippet'] != null &&
      firstItem['snippet']['resourceId'] != null &&
      firstItem['snippet']['resourceId']['videoId'] != null) {
    return firstItem['snippet']['resourceId']['videoId'].toString();
  }

  // パターン2: id.videoId が入っている
  if (firstItem['id'] != null && firstItem['id']['videoId'] != null) {
    return firstItem['id']['videoId'] as String;
  }

  // どちらも無ければ null
  return null;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

/// MODIFY CODE ONLY ABOVE THIS LINE

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
