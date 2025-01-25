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

Future<String?> parseChannelsJsonToAppState(String jsonString) async {
  if (jsonString.isEmpty) {
    // 文字列が空なら何もしない
    return null;
  }

  try {
    final List<dynamic> parsedList = jsonDecode(jsonString);
    // 例: [ { "channelId":"UCxxx", "channelName":"...", "iconUrl":"..." }, ... ]

    // FlutterFlow の AppState() はグローバルクラスとして定義されている想定
    FFAppState().channelsList = parsedList;
    // これで FFAppState().channelsList に JSON配列が丸ごと入る

    return null;
  } catch (e) {
    // パース失敗時
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
