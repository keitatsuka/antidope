// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Action Name: fetchAllBookmarks
/// Return Type: JSON (FlutterFlow側で設定)
/// 概要:
///   bookmarkBox からすべてのデータを取り出し、
///   動画IDやタイトル、サムネURLなどをまとめた List<Map<String,dynamic>> を返す。
Future<dynamic> fetchAllBookmarks() async {
  final box = Hive.box('bookmarkBox');
  final rawMap = box.toMap();

  final List<dynamic> resultList = [];
  rawMap.forEach((key, value) {
    if (value is Map<String, dynamic>) {
      // すでにvalueが "kind, etag, snippet{...}" の形
      resultList.add(value);
    }
  });

  return resultList; // Return Type=JSON
}
