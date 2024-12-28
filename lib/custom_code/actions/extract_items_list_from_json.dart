// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

Future<List?> extractItemsListFromJson(String? jsonString) async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (jsonString == null || jsonString.isEmpty) {
    // nullや空文字なら空のListを返す
    return [];
  }

  // 文字列をJSONとしてデコード
  final data = jsonDecode(jsonString);

  // 'items'が存在し、配列ならそれを返す。そうでなければ空リスト
  if (data is Map && data['items'] != null && data['items'] is List) {
    return data['items'];
  } else {
    return [];
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
