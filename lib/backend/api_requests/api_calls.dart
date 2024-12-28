import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class YoutubeDataAPICall {
  static Future<ApiCallResponse> call({
    String? channelIdParam = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Youtube Data API',
      apiUrl: 'https://www.googleapis.com/youtube/v3/search',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'part': "snippet",
        'channelId': channelIdParam,
        'maxResults': 10,
        'key': "AIzaSyAvGvIupXr-xr1fycm0o3el4PeqeN98OEE",
        'type': "video",
        'order': "date",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? channelID(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].id.channelId''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].snippet.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? thumbnails(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].snippet.thumbnails.default.url''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static String? channelTitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.items[:].snippet.channelTitle''',
      ));
  static List<String>? videoid(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].id.videoId''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class VideosListAPICallCall {
  static Future<ApiCallResponse> call({
    String? id = 'videoIdParam',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'VideosListAPICall',
      apiUrl: 'https://www.googleapis.com/youtube/v3/videos',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'part': "snippet",
        'id': id,
        'key': "AIzaSyAvGvIupXr-xr1fycm0o3el4PeqeN98OEE",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SearchListAPICallCall {
  static Future<ApiCallResponse> call({
    String? queryParam = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'SearchListAPICall',
      apiUrl: 'https://www.googleapis.com/youtube/v3/search',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'part': "snippet",
        'type': "channel",
        'maxResults': 1,
        'q': queryParam,
        'key': "AIzaSyAvGvIupXr-xr1fycm0o3el4PeqeN98OEE",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
