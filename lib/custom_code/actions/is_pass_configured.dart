// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart';
import '/flutter_flow/custom_functions.dart';

import 'package:hive/hive.dart';

/// isPassConfigured
///   - 戻り値: bool
///   - Hiveに '4digitPass' が存在するなら true, 無ければ false
Future<bool> isPassConfigured() async {
  final box = Hive.box('passCodeBox');
  final saved = box.get('4digitPass', defaultValue: null);

  return (saved != null);
}
