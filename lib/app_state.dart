import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _lastUsedChannelId =
          prefs.getString('ff_lastUsedChannelId') ?? _lastUsedChannelId;
    });
    _safeInit(() {
      _isLoading = prefs.getBool('ff_isLoading') ?? _isLoading;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

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
    prefs.setString('ff_lastUsedChannelId', value);
  }

  dynamic _selectedIconUrl;
  dynamic get selectedIconUrl => _selectedIconUrl;
  set selectedIconUrl(dynamic value) {
    _selectedIconUrl = value;
  }

  List<String> _bookmarkedVideoIds = [];
  List<String> get bookmarkedVideoIds => _bookmarkedVideoIds;
  set bookmarkedVideoIds(List<String> value) {
    _bookmarkedVideoIds = value;
  }

  void addToBookmarkedVideoIds(String value) {
    bookmarkedVideoIds.add(value);
  }

  void removeFromBookmarkedVideoIds(String value) {
    bookmarkedVideoIds.remove(value);
  }

  void removeAtIndexFromBookmarkedVideoIds(int index) {
    bookmarkedVideoIds.removeAt(index);
  }

  void updateBookmarkedVideoIdsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    bookmarkedVideoIds[index] = updateFn(_bookmarkedVideoIds[index]);
  }

  void insertAtIndexInBookmarkedVideoIds(int index, String value) {
    bookmarkedVideoIds.insert(index, value);
  }

  bool _showBookmarkMode = false;
  bool get showBookmarkMode => _showBookmarkMode;
  set showBookmarkMode(bool value) {
    _showBookmarkMode = value;
  }

  List<dynamic> _myBookmarksJsonList = [];
  List<dynamic> get myBookmarksJsonList => _myBookmarksJsonList;
  set myBookmarksJsonList(List<dynamic> value) {
    _myBookmarksJsonList = value;
  }

  void addToMyBookmarksJsonList(dynamic value) {
    myBookmarksJsonList.add(value);
  }

  void removeFromMyBookmarksJsonList(dynamic value) {
    myBookmarksJsonList.remove(value);
  }

  void removeAtIndexFromMyBookmarksJsonList(int index) {
    myBookmarksJsonList.removeAt(index);
  }

  void updateMyBookmarksJsonListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    myBookmarksJsonList[index] = updateFn(_myBookmarksJsonList[index]);
  }

  void insertAtIndexInMyBookmarksJsonList(int index, dynamic value) {
    myBookmarksJsonList.insert(index, value);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    prefs.setBool('ff_isLoading', value);
  }

  dynamic _channelsData;
  dynamic get channelsData => _channelsData;
  set channelsData(dynamic value) {
    _channelsData = value;
  }

  List<dynamic> _searchResultList = [];
  List<dynamic> get searchResultList => _searchResultList;
  set searchResultList(List<dynamic> value) {
    _searchResultList = value;
  }

  void addToSearchResultList(dynamic value) {
    searchResultList.add(value);
  }

  void removeFromSearchResultList(dynamic value) {
    searchResultList.remove(value);
  }

  void removeAtIndexFromSearchResultList(int index) {
    searchResultList.removeAt(index);
  }

  void updateSearchResultListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    searchResultList[index] = updateFn(_searchResultList[index]);
  }

  void insertAtIndexInSearchResultList(int index, dynamic value) {
    searchResultList.insert(index, value);
  }

  String _nextPageToken = '';
  String get nextPageToken => _nextPageToken;
  set nextPageToken(String value) {
    _nextPageToken = value;
  }

  String _uploadsPlaylistId = '';
  String get uploadsPlaylistId => _uploadsPlaylistId;
  set uploadsPlaylistId(String value) {
    _uploadsPlaylistId = value;
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

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
