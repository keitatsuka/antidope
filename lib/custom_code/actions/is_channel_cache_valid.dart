// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:convert';
import 'package:hive/hive.dart';

/*
  Action: isChannelCacheValid
  Purpose: Check if the channel's lastFetch timestamp is within the expiryMs (default 24h).
*/

Future<bool> isChannelCacheValid(
  String channelId,
  String expiryMsString,
) async {
  final box = Hive.box('channelsBox');
  final timestampsJson = box.get('channelTimestamps', defaultValue: '{}');
  final Map<String, dynamic> timestampsMap = jsonDecode(timestampsJson);

  final lastFetch = timestampsMap[channelId];
  if (lastFetch == null) {
    return false; // never fetched => invalid
  }

  final expiryMs = int.tryParse(expiryMsString) ?? 86400000; // default 24h
  final now = DateTime.now().millisecondsSinceEpoch;
  final elapsed = now - (lastFetch as int);

  return (elapsed < expiryMs);
}
