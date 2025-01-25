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

Future<String?> performLocalSearch(String query) async {
  final trimmed = query.trim();

  // ─────────────────────────────────────────
  // (1) 検索文字列が空なら => 検索解除 (searchActive=false)
  // ─────────────────────────────────────────
  if (trimmed.isEmpty) {
    FFAppState().searchActive = false;
    return null;
  }

  // ─────────────────────────────────────────
  // (2) URL検索モードを判定
  // ─────────────────────────────────────────
  final lower = trimmed.toLowerCase();
  final isUrlSearch = lower.contains("watch?v=") ||
      lower.contains("youtu.be/") ||
      lower.contains("/shorts/");

  if (isUrlSearch) {
    // ▼ URL検索モード
    final vid = _extractVideoId(trimmed);
    if (vid == null || vid.isEmpty) {
      FFAppState().searchActive = false; // URL解析できない → 検索解除
      return null;
    }

    // URL検索で単一表示する場合 → 検索結果一覧ではなく"単体表示"とみなす
    // よって searchActive はオフにしてしまう
    FFAppState().searchActive = true;

    // 下リストを消去
    FFAppState().test = [];
    FFAppState().videoListJson = '';

    // 単体動画表示
    FFAppState().selectedVideoId = vid;
    FFAppState().HTMLForWebView = _buildIframeHtml(vid);

    // 「iconUrl」は空文字をJSON形式でセット (例: {"iconUrl": ""})
    FFAppState().selectedIconUrl = {"iconUrl": ""};

    // selectedItem も不要ならnull
    FFAppState().selectedItem = null;

    return null;
  }

  // ─────────────────────────────────────────
  // (3) 通常のキーワード検索 → searchActive = true
  // ─────────────────────────────────────────
  FFAppState().searchActive = true;

  if (FFAppState().videoListJson.isEmpty) {
    // そもそもチャンネル動画が無い状態 → 検索不可
    return null;
  }

  final items = await extractItemsListFromJson(FFAppState().videoListJson);
  if (items == null || items.isEmpty) {
    return null;
  }

  // ローカル検索(タイトルに query が含まれるか)
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

  // FFAppState().test を更新
  FFAppState().test = matched;

  if (matched.isEmpty) {
    // 0件ヒット → 上部もクリア
    FFAppState().selectedVideoId = '';
    FFAppState().HTMLForWebView = '';
    FFAppState().selectedItem = null;
    FFAppState().selectedIconUrl = {"iconUrl": ""};
    return null;
  }

  // 先頭アイテムを選択して表示
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

// ─────────────────────────────────────
// 以下、URL解析や動画ID取得のヘルパー群
// ─────────────────────────────────────

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

/// チャンネルアイコンを { "iconUrl": "..." } 形式に整形
Future<Map<String, dynamic>> _findChannelIconObj(String channelId) async {
  final dynamic iconAny = await findIconUrlByChannelId(channelId);
  if (iconAny == null) {
    return {"iconUrl": ""};
  }
  if (iconAny is String) {
    return {"iconUrl": iconAny};
  }
  if (iconAny is Map) {
    final inner = iconAny["iconUrl"];
    if (inner is String) {
      return {"iconUrl": inner};
    }
    if (inner is Map && inner["iconUrl"] is String) {
      return {"iconUrl": inner["iconUrl"]};
    }
  }
  return {"iconUrl": ""};
}
