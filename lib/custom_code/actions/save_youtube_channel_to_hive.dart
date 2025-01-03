// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<String?> saveYoutubeChannelToHive(
  String channelId,
  String channelName,
  String iconUrl,
) async {
  // 1) boxを開く
  var box = Hive.box('channelsBox');

  // 2) existing list 取得
  final currentList = box.get('youtubeChannels', defaultValue: []);

  // 3) 新たな要素を追加
  final newSlot = {
    "channelId": channelId,
    "channelName": channelName,
    "iconUrl": iconUrl,
  };
  currentList.add(newSlot);

  // 4) boxに put()
  await box.put('youtubeChannels', currentList);

  return null; // Actionのreturn
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
