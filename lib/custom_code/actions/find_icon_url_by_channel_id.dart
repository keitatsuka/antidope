// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<String?> findIconUrlByChannelId(
  dynamic channelsList, // Parameter1: Type = JSON
  String? channelId, // Parameter2: Type = String
) async {
  if (channelsList == null || channelId == null) {
    return null;
  }
  if (channelsList is List) {
    for (final item in channelsList) {
      if (item is Map &&
          item['channelId'] == channelId &&
          item['iconUrl'] != null) {
        return item['iconUrl'] as String;
      }
    }
  }
  return null;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
