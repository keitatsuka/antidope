// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/// MODIFY CODE ONLY BELOW THIS LINE
import 'package:hive/hive.dart'; // この行をDO NOT REMOVE...の下、かつMODIFY CODE ONLY BELOW THIS LINEより上に書かないように注意
import 'package:hive_flutter/hive_flutter.dart';

String? getVideoListJson() {
  var box = Hive.box('cacheBox');
  String? jsonString = box.get('videoList', defaultValue: null);
  return jsonString;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
