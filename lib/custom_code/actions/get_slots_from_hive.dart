// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<String?> getSlotsFromHive() async {
  var box = Hive.box('channelsBox');
  var raw = box.get('youtubeSlots', defaultValue: []);
  // rawがList<Map>等だとしてjsonEncodeで返す
  return jsonEncode(raw);
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
