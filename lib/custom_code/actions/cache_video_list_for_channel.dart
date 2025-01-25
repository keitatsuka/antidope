// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart'; // Import other custom actions
import '/flutter_flow/custom_functions.dart'; // Import custom functions

import 'package:hive/hive.dart';

Future<String?> cacheVideoListForChannel(
    String channelId, String responseBody) async {
  final box = Hive.box('channelsBox');
  await box.put('videoList_$channelId', responseBody);
  return null;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
