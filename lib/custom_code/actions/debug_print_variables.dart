// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<String?> debugPrintVariables(String? extraInfo) async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // もし引数が不要なら、引数を削除してもOK
  // 例: debugPrintVariables() に引数無しにする
  debugPrint('=== Debug Print Action ===');

  // 任意の追加引数を表示 (無ければ不要)
  if (extraInfo != null && extraInfo.isNotEmpty) {
    debugPrint('extraInfo => $extraInfo');
  }

  // App Stateの変数を表示
  debugPrint('selectedVideoId => ${FFAppState().selectedVideoId}');
  debugPrint('HTMLForWebView => ${FFAppState().HTMLForWebView}');
  debugPrint('videoListJson => ${FFAppState().videoListJson}');

  // もし他の変数（extractedVideoId, newVideoIdなど）を出したければ
  // 画面の変数かモデル変数にアクセスできるように実装し、
  // 同様に debugPrint() で表示します。

  // 戻り値はnullでOK。FlutterFlowでReturn TypeをString?に設定しておけばエラーになりません
  return null;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
