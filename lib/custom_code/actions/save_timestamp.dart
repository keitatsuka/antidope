// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:hive/hive.dart';

// Custom Action例
String? saveTimestamp(String? timestampString) {
  if (timestampString == null) {
    return null;
  }

  // Stringをintにパース
  int timestamp = int.parse(timestampString);

  var box = Hive.box('cacheBox');
  box.put('timestamp', timestamp);

  return null;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
