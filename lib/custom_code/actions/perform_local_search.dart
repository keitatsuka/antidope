// Automatic FlutterFlow imports
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

Future<String?> performLocalSearch(String query) async {
  final trimmed = query.trim();
  if (trimmed.isEmpty) {
    // 検索文字列が空の場合は適宜リセット処理
    return null;
  }

  final lower = trimmed.toLowerCase();
  final isUrlSearch = lower.contains("watch?v=") ||
      lower.contains("youtu.be/") ||
      lower.contains("/shorts/");

  if (isUrlSearch) {
    // ▼ URL検索モード
    final vid = _extractVideoId(trimmed);
    if (vid == null || vid.isEmpty) {
      return null; // videoIdが無効なら何もしない
    }
    // 下リストを消去
    FFAppState().test = [];
    FFAppState().videoListJson = '';
    // 単体動画表示
    FFAppState().selectedVideoId = vid;
    FFAppState().HTMLForWebView = _buildIframeHtml(vid);

    // 「iconUrl」は空文字をJSON形式でセット (一段)
    FFAppState().selectedIconUrl = {"iconUrl": ""};

    // selectedItem も不要ならnull
    FFAppState().selectedItem = null;
    return null;
  }

  // ▼ キーワード検索モード
  if (FFAppState().videoListJson.isEmpty) {
    // もともとチャンネル動画JSONが無いなら検索不可
    return null;
  }
  final items = await extractItemsListFromJson(FFAppState().videoListJson);
  if (items == null || items.isEmpty) {
    return null;
  }

  final matched = <dynamic>[];
  final lowerQuery = trimmed.toLowerCase();

  for (final item in items) {
    if (item is Map && item["snippet"] is Map) {
      final title = (item["snippet"]["title"] ?? "").toString().toLowerCase();
      if (title.contains(lowerQuery)) {
        matched.add(item);
      }
    }
  }

  // 新しいリストで更新
  FFAppState().test = matched;

  if (matched.isEmpty) {
    // ヒットが0件なら上部もクリア
    FFAppState().selectedVideoId = '';
    FFAppState().HTMLForWebView = '';
    FFAppState().selectedItem = null;
    // iconUrl空 (一段)
    FFAppState().selectedIconUrl = {"iconUrl": ""};
    return null;
  }

  // 先頭アイテム
  final first = matched.first;
  final vid = _extractVideoIdFromItem(first);
  if (vid == null || vid.isEmpty) {
    return null;
  }
  FFAppState().selectedVideoId = vid;
  FFAppState().HTMLForWebView = _buildIframeHtml(vid);
  FFAppState().selectedItem = first;

  // snippet.channelId からアイコンURLを取得
  final snippet = first["snippet"];
  if (snippet is Map) {
    final chId = snippet["channelId"]?.toString() ?? "";
    if (chId.isNotEmpty) {
      // ここでアクションを呼んで「一段構造のオブジェクト」に整形
      final channelIconObj = await _findChannelIconObj(chId);
      FFAppState().selectedIconUrl = channelIconObj;
    } else {
      FFAppState().selectedIconUrl = {"iconUrl": ""};
    }
  } else {
    FFAppState().selectedIconUrl = {"iconUrl": ""};
  }

  return null;
}

/// 動画URLからvideoId抽出
String? _extractVideoId(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return null;
  if (uri.queryParameters.containsKey("v")) {
    return uri.queryParameters["v"];
  }
  if (url.contains("youtu.be/")) {
    final splitted = url.split("youtu.be/");
    if (splitted.length > 1) {
      return splitted[1].split("?")[0].split("&")[0];
    }
  }
  if (url.contains("/shorts/")) {
    final splitted = url.split("/shorts/");
    if (splitted.length > 1) {
      return splitted[1].split("?")[0].split("&")[0];
    }
  }
  return null;
}

/// 既存item(playlistItem)からvideoIdを抜き出す
String? _extractVideoIdFromItem(dynamic item) {
  if (item is Map) {
    final snippet = item["snippet"];
    if (snippet is Map) {
      final resId = snippet["resourceId"];
      if (resId is Map && resId["videoId"] is String) {
        return resId["videoId"];
      }
    }
  }
  return null;
}

/// iframe生成
String _buildIframeHtml(String videoId) {
  return '''
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    .video-container {
      position: relative;
      width: 100%;
      padding-top: 65%;
      overflow: hidden;
    }
    .video-container iframe {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      border: 0;
    }
  </style>
</head>
<body style="margin:0;padding:0;overflow:hidden;">
  <div class="video-container">
    <iframe
      src="https://www.youtube.com/embed/$videoId?autoplay=0"
      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
      allowfullscreen>
    </iframe>
  </div>
</body>
</html>
''';
}

/// チャンネルアイコンをJSONオブジェクト { "iconUrl": "<url>" } 形式で返す
Future<Map<String, dynamic>> _findChannelIconObj(String channelId) async {
  // 既存の findIconUrlByChannelId() が どの型を返すかで整形が変わる

  final dynamic iconAny = await findIconUrlByChannelId(channelId);
  // たとえば iconAny が下記いずれかの場合を想定:
  //   1) "https://..." (String)
  //   2) { "iconUrl": "https://..." } (Map)
  //   3) null

  if (iconAny == null) {
    // 見つからない → 空URL
    return {"iconUrl": ""};
  }

  if (iconAny is String) {
    // 文字列なら { "iconUrl": "<文字列>" } として一段化
    return {"iconUrl": iconAny};
  }

  // もしiconAnyが Map 形式の場合:
  if (iconAny is Map) {
    // 1段なら { "iconUrl":"https://..." }
    final inner = iconAny["iconUrl"];
    if (inner is String) {
      // "iconUrl"キーが文字列 = 既にOK
      return {"iconUrl": inner};
    }
    // さらに2段など別の構造の場合はここで再帰的に処理 or "" を返す
    // 例: {"iconUrl": {"iconUrl": "https://..."} } をフラットにする
    if (inner is Map && inner["iconUrl"] is String) {
      return {"iconUrl": inner["iconUrl"]};
    }
  }

  // その他の場合は空を返す
  return {"iconUrl": ""};
}
