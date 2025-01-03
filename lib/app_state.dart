import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/api_requests/api_manager.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _selectedVideoId = '';
  String get selectedVideoId => _selectedVideoId;
  set selectedVideoId(String value) {
    _selectedVideoId = value;
  }

  String _HTMLForWebView = '';
  String get HTMLForWebView => _HTMLForWebView;
  set HTMLForWebView(String value) {
    _HTMLForWebView = value;
  }

  String _videoListJson = '';
  String get videoListJson => _videoListJson;
  set videoListJson(String value) {
    _videoListJson = value;
  }

  List<dynamic> _test = [];
  List<dynamic> get test => _test;
  set test(List<dynamic> value) {
    _test = value;
  }

  void addToTest(dynamic value) {
    test.add(value);
  }

  void removeFromTest(dynamic value) {
    test.remove(value);
  }

  void removeAtIndexFromTest(int index) {
    test.removeAt(index);
  }

  void updateTestAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    test[index] = updateFn(_test[index]);
  }

  void insertAtIndexInTest(int index, dynamic value) {
    test.insert(index, value);
  }

  dynamic _selectedItem;
  dynamic get selectedItem => _selectedItem;
  set selectedItem(dynamic value) {
    _selectedItem = value;
  }

  String _ChannelId = '';
  String get ChannelId => _ChannelId;
  set ChannelId(String value) {
    _ChannelId = value;
  }

  List<dynamic> _channelsList = [];
  List<dynamic> get channelsList => _channelsList;
  set channelsList(List<dynamic> value) {
    _channelsList = value;
  }

  void addToChannelsList(dynamic value) {
    channelsList.add(value);
  }

  void removeFromChannelsList(dynamic value) {
    channelsList.remove(value);
  }

  void removeAtIndexFromChannelsList(int index) {
    channelsList.removeAt(index);
  }

  void updateChannelsListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    channelsList[index] = updateFn(_channelsList[index]);
  }

  void insertAtIndexInChannelsList(int index, dynamic value) {
    channelsList.insert(index, value);
  }

  String _lastUsedChannelId = '';
  String get lastUsedChannelId => _lastUsedChannelId;
  set lastUsedChannelId(String value) {
    _lastUsedChannelId = value;
  }

  List<dynamic> _bookmark = [];
  List<dynamic> get bookmark => _bookmark;
  set bookmark(List<dynamic> value) {
    _bookmark = value;
  }

  void addToBookmark(dynamic value) {
    bookmark.add(value);
  }

  void removeFromBookmark(dynamic value) {
    bookmark.remove(value);
  }

  void removeAtIndexFromBookmark(int index) {
    bookmark.removeAt(index);
  }

  void updateBookmarkAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    bookmark[index] = updateFn(_bookmark[index]);
  }

  void insertAtIndexInBookmark(int index, dynamic value) {
    bookmark.insert(index, value);
  }

  final _youtubequeryManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> youtubequery({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _youtubequeryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearYoutubequeryCache() => _youtubequeryManager.clear();
  void clearYoutubequeryCacheKey(String? uniqueKey) =>
      _youtubequeryManager.clearRequest(uniqueKey);
}
