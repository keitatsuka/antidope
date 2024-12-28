// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String? extractVideoIdFromJson(String? jsonString) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (jsonString == null) {
    return null; // 引数がnullなら何もしない
  }

  // JSON文字列をMap形式にパース
  final data = jsonDecode(jsonString);

  // dataはMap型。itemsはList
  // itemsが存在し、0番目の要素があることを確認
  if (data['items'] == null || data['items'].isEmpty) {
    return null; // itemsがない場合null
  }

  final firstItem = data['items'][0];
  if (firstItem == null) {
    return null;
  }

  // firstItem['id']['videoId']が存在する場合それを返す
  if (firstItem['id'] != null && firstItem['id']['videoId'] != null) {
    return firstItem['id']['videoId'] as String;
  }

  return null;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
