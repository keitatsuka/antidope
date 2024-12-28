// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<String?> debugAfterExtract() async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // 1) Dartのprint or debugPrintで出力
  debugPrint('=== debugAfterExtract ===');
  debugPrint('videoListJson => ${FFAppState().videoListJson}');
  // たとえば _model.videoItemsListCached をグローバルに持たず FFAppStateに持っているなら:
  debugPrint('FFAppState().test => ${FFAppState().test}');
  if (FFAppState().test is List) {
    debugPrint('FFAppState().test length => ${FFAppState().test.length}');
  }

  // 2) selectedVideoId なども一緒に出せる
  debugPrint('selectedVideoId => ${FFAppState().selectedVideoId}');

  return null;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
