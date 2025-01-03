// Automatic FlutterFlow imports
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

Future<bool> isChannelCacheValid(
    String channelId, String expiryMsString) async {
  final box = Hive.box('channelsBox');
  final timestampsJson = box.get('channelTimestamps', defaultValue: '{}');
  final Map<String, dynamic> timestampsMap = jsonDecode(timestampsJson);

  final lastFetch = timestampsMap[channelId];
  if (lastFetch == null) {
    return false;
  }

  final expiryMs = int.tryParse(expiryMsString) ?? 86400000;
  final now = DateTime.now().millisecondsSinceEpoch;
  final elapsed = now - (lastFetch as int);

  return elapsed < expiryMs;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
