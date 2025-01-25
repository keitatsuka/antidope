// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:hive/hive.dart';

// Action name: getSlotsFromHive
// Return Type: String

Future<String?> getChannelsFromHive() async {
  var box = Hive.box('channelsBox');
  var rawList = box.get('youtubeChannels', defaultValue: []);
  // ここで JSON文字列に変換して返す
  // 例: "[{\"channelId\":\"UCxxx\",\"channelName\":\"...\",\"iconUrl\":\"...\"},...]"
  return jsonEncode(rawList);
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
