// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:hive/hive.dart';

/// savePassCode
/// - [passCode] : 4桁の文字列
/// これを 'passCodeBox' に "4digitPass" というキーで put する。
Future<String?> savePassCode(String passCode) async {
  final box = Hive.box('passCodeBox');
  await box.put('4digitPass', passCode);
  return null; // FlutterFlowでは String? を要求することがあるためnull返しOK
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
