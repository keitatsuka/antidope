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

Future<String?> updateChannelTimestamp(String channelId) async {
  final box = Hive.box('channelsBox');
  final timestampsJson = box.get('channelTimestamps', defaultValue: '{}');

  final Map<String, dynamic> timestampsMap = jsonDecode(timestampsJson);
  timestampsMap[channelId] = DateTime.now().millisecondsSinceEpoch;

  await box.put('channelTimestamps', jsonEncode(timestampsMap));
  return null;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
