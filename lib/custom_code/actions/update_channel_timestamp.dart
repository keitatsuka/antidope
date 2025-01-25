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

import 'dart:convert';
import 'package:hive/hive.dart';

/*
  Action: updateChannelTimestamp
  Purpose: Update the 'channelTimestamps' in 'channelsBox' 
           to mark the current time for a given channelId.
*/

Future<String?> updateChannelTimestamp(String channelId) async {
  final box = Hive.box('channelsBox');
  final timestampsJson = box.get('channelTimestamps', defaultValue: '{}');

  final Map<String, dynamic> timestampsMap = jsonDecode(timestampsJson);
  timestampsMap[channelId] = DateTime.now().millisecondsSinceEpoch;

  await box.put('channelTimestamps', jsonEncode(timestampsMap));
  return null;
}
