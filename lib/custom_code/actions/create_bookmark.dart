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

import 'package:hive/hive.dart';

/// createBookmark: 保存時に「YouTube APIと似た構造」のMapをbox.put()する
Future<String?> createBookmark(
  /// 既存パラメータはご自身のプロジェクトに合わせて
  dynamic itemData, // JSON型のYouTubeレスポンス (例: "playlistItem"相当)
) async {
  final box = Hive.box('bookmarkBox');

  // itemData は JSON(例えば"playlistItem"相当)として渡される想定。
  // 例: { "kind": "...", "id": "...", "snippet": { "title": "...", "thumbnails":{...}, "resourceId": {...} } }
  // 必要なフィールドを抽出 or 丸ごと保存
  final bookmarkMap = <String, dynamic>{};

  if (itemData is Map<String, dynamic>) {
    // kind, etag, id
    bookmarkMap["kind"] = itemData["kind"] ?? "";
    bookmarkMap["etag"] = itemData["etag"] ?? "";
    bookmarkMap["id"] = itemData["id"] ?? "";

    // snippet
    if (itemData["snippet"] is Map) {
      final snippet = itemData["snippet"];

      // ★1) channelTitle or videoOwnerChannelTitle などをコピー
      //     "オリジナル"がなければ "" にする
      final channelTitle =
          snippet["channelTitle"] ?? snippet["videoOwnerChannelTitle"] ?? "";

      // ★2) サムネイル情報
      final thumbnails = snippet["thumbnails"] ?? {};

      // bookmarkMap に snippet を再構築
      bookmarkMap["snippet"] = {
        "publishedAt": snippet["publishedAt"],
        "channelId": snippet["channelId"],
        "channelTitle": channelTitle, // 追加
        "title": snippet["title"],
        "thumbnails": thumbnails,
        "resourceId": snippet["resourceId"],
      };

      // ★3) もし「サムネURL文字列」を取り出しておきたいなら:
      //     例: "default" サムネURL
      String? defaultThumbUrl;
      if (thumbnails is Map &&
          thumbnails["default"] != null &&
          thumbnails["default"]["url"] != null) {
        defaultThumbUrl = thumbnails["default"]["url"].toString();
      }

      // ★3-2) bookmarkMap直下にも "videoThumbUrl" を置く例:
      bookmarkMap["videoThumbUrl"] = defaultThumbUrl ?? "";
    }
  }

  // 独自フィールド
  bookmarkMap["addedAt"] = DateTime.now().toIso8601String();

  // Hiveへ保存するときは "id" (videoId or playlistItemId) をキーに使う
  String? itemId;
  if (bookmarkMap["snippet"] != null &&
      bookmarkMap["snippet"]["resourceId"] != null &&
      bookmarkMap["snippet"]["resourceId"]["videoId"] != null) {
    itemId = bookmarkMap["snippet"]["resourceId"]["videoId"] as String;
  } else {
    // fallback
    itemId = bookmarkMap["id"] ?? "unknown_id";
  }

  // put
  await box.put(itemId, bookmarkMap);

  return null;
}
