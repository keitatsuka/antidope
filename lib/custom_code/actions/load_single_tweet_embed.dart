// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // 他のCustom Actionをまとめたindexファイル
import '/flutter_flow/custom_functions.dart'; // Custom Functionを利用する場合

import 'dart:convert';

/// loadSingleTweetEmbed
///
///  (1) 入力URLを "twitter.com" に置換
///  (2) URLからTweetIDを抽出
///  (3) 埋め込みHTMLを生成
///  (4) FFAppState().xSingleTweetHtml にセット
///
/// 引数:
///  - [tweetUrl] : string (ユーザーは x.com でも twitter.com でも入力可能)
/// 戻り値:
///  {
///    "status": "ok" or "error",
///    "message": "...",
///    "tweetId": "...",
///    "embeddedHtml": "..."
///  }
Future<dynamic> loadSingleTweetEmbed(String tweetUrl) async {
  debugPrint('=== loadSingleTweetEmbed START ===');
  debugPrint('original tweetUrl => $tweetUrl');

  // 1) 引数チェック
  if (tweetUrl.isEmpty) {
    FFAppState().xSingleTweetHtml = '';
    return {
      "status": "error",
      "message": "URLが空です。",
    };
  }

  // 2) x.com → twitter.com に置換
  //    例: https://x.com/username/status/12345 → https://twitter.com/username/status/12345
  final normalizedUrl = _normalizeToTwitterDomain(tweetUrl);
  debugPrint('normalizedUrl => $normalizedUrl');

  // 3) TweetIDを抽出
  final tid = _extractTweetId(normalizedUrl);
  if (tid.isEmpty) {
    FFAppState().xSingleTweetHtml = '';
    return {
      "status": "error",
      "message": "TweetIDを抽出できませんでした。URLを確認してください。",
    };
  }

  // 4) 埋め込みHTMLを生成
  final embedded = _buildSingleTweetHtml(normalizedUrl);

  // 5) FFAppState にセット
  FFAppState().xSingleTweetHtml = embedded;

  // 6) 戻り値
  debugPrint('=== loadSingleTweetEmbed END ===');
  return {
    "status": "ok",
    "message": "Tweetをロードしました",
    "tweetId": tid,
    "embeddedHtml": embedded,
  };
}

/// _normalizeToTwitterDomain
///   x.com/... を twitter.com/... に置換し、埋め込みが安定するようにする
String _normalizeToTwitterDomain(String originalUrl) {
  // 小文字に変換して検索
  final lower = originalUrl.toLowerCase();
  if (lower.contains('x.com/')) {
    // 例: https://x.com/username/status/123
    //     x.com という部分を twitter.com に置き換え
    return originalUrl.replaceFirst(
        RegExp(r'x\.com', caseSensitive: false), 'twitter.com');
  }
  // もともとtwitter.com ならそのまま返す
  return originalUrl;
}

/// _extractTweetId
///   "/status/123456789" の部分を取り出す単純実装
String _extractTweetId(String url) {
  final lower = url.toLowerCase();
  // シンプルに "/status/" の後ろを取り出す
  if (lower.contains('/status/')) {
    final splitted = url.split('/status/');
    if (splitted.length > 1) {
      final after = splitted[1].split('?')[0].split('&')[0];
      return after; // "123456789"
    }
  }
  return '';
}

/// _buildSingleTweetHtml
///   Tweet単体の埋め込み
///   twitter.com 版のURLを使って <blockquote> + <script> を生成
String _buildSingleTweetHtml(String tweetUrl) {
  return '''
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      margin: 0;
      padding: 0;
      overflow: auto;
    }
  </style>
</head>
<body>
  <blockquote class="twitter-tweet">
    <a href="$tweetUrl"></a>
  </blockquote>
  <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
</body>
</html>
''';
}
