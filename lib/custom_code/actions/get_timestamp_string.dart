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

String? getTimestampString() {
  var box = Hive.box('cacheBox');
  int? timestamp = box.get('timestamp', defaultValue: null);
  if (timestamp == null) {
    return null;
  }
  return timestamp.toString();
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
