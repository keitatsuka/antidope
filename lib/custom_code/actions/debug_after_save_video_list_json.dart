// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:hive/hive.dart';

Future<String?> debugAfterSaveVideoListJson(String? savedJson) async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  debugPrint('=== debugAfterSaveVideoListJson ===');

  // savedJsonがnullもしくは空なら、その旨をデバッグ表示
  if (savedJson == null || savedJson.isEmpty) {
    debugPrint('No JSON to display (null or empty).');
  } else {
    debugPrint('Will save the following JSON to Hive =>');
    debugPrint(savedJson);
  }

  // 以下は任意：
  // Hiveに実際保存された内容を確認したい場合はコメントアウト解除
  // var box = Hive.box('cacheBox');
  // var current = box.get('videoList');
  // debugPrint('Current content in "videoList" => $current');

  return null;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
