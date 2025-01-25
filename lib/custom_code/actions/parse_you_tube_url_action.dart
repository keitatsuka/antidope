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

import 'dart:convert';

/// parseYouTubeUrlAction
/// [url]: YouTubeリンク
///
/// 戻り値: JSON文字列 {"videoId": "...", "channelId":"...", "customName":"..."}
///
///  - videoId: 取得成功なら動画ID
///  - channelId: URLにUCxxxxがあれば
///  - customName: /@handle, /c/name, /user/name の場合
///
/// ここではHTTPリクエストは行わず、あくまで文字列解析だけ。
String? parseYouTubeUrlAction(String? url) {
  if (url == null || url.isEmpty) {
    // 空入力なら {"videoId":null, "channelId":null, "customName":null}
    return jsonEncode({
      "videoId": null,
      "channelId": null,
      "customName": null,
    });
  }

  final lower = url.toLowerCase();
  // 1) 動画URL (watch?v=... or youtu.be/...)
  if (lower.contains("watch?v=") || lower.contains("youtu.be/")) {
    final vid = _extractVideoId(url);
    return jsonEncode({
      "videoId": vid,
      "channelId": null,
      "customName": null,
    });
  }

  // 2) /channel/UCxxxx
  if (lower.contains("/channel/uc")) {
    final cid = _extractChannelId(url);
    return jsonEncode({
      "videoId": null,
      "channelId": cid,
      "customName": null,
    });
  }

  // 3) fallback => /@handle, /c/Name, /user/Name ...
  final name = _extractCustomName(url);
  return jsonEncode({
    "videoId": null,
    "channelId": null,
    "customName": name,
  });
}

// 以下、private的なヘルパー
String? _extractVideoId(String url) {
  // watch?v=xxx
  final uri = Uri.parse(url);
  if (uri.queryParameters.containsKey('v')) {
    return uri.queryParameters['v'];
  }
  // youtu.be/xxx
  if (url.contains("youtu.be/")) {
    final splitted = url.split("youtu.be/");
    if (splitted.length > 1) {
      return splitted[1].split("?")[0].split("&")[0];
    }
  }
  // shorts/xxx (任意)
  if (url.contains("/shorts/")) {
    final arr = url.split("/shorts/");
    if (arr.length > 1) {
      return arr[1].split("?")[0].split("&")[0];
    }
  }
  return null;
}

String? _extractChannelId(String url) {
  // /channel/UCxxxx
  if (!url.contains("/channel/")) return null;
  final splitted = url.split("/channel/");
  if (splitted.length < 2) return null;
  final after = splitted[1].split("?")[0].split("&")[0];
  if (after.startsWith("UC")) {
    return after;
  }
  return null;
}

String? _extractCustomName(String url) {
  // 例: /@SomeHandle, /c/Name, /user/Name
  final splitted = url.split("/");
  if (splitted.isEmpty) return null;
  var lastPart = splitted.last;
  // remove query
  lastPart = lastPart.split("?")[0].split("&")[0];
  // remove leading '@'
  if (lastPart.startsWith("@")) {
    lastPart = lastPart.substring(1);
  }
  if (lastPart.isEmpty) return null;
  return lastPart;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
