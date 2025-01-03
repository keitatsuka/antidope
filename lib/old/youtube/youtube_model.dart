import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'youtube_widget.dart' show YoutubeWidget;
import 'package:flutter/material.dart';

class YoutubeModel extends FlutterFlowModel<YoutubeWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getTimestampString] action in Youtube widget.
  String? cachedTimestamp;
  // Stores action output result for [Custom Action - getCurrentTimestampString] action in Youtube widget.
  String? currentTimestamp;
  // Stores action output result for [Custom Action - isCacheValid] action in Youtube widget.
  String? cacheValidResult;
  // Stores action output result for [Custom Action - getVideoListJson] action in Youtube widget.
  String? cachedJson;
  // Stores action output result for [Custom Action - extractItemsListFromJson] action in Youtube widget.
  List<dynamic>? videoItemsListCached;
  // Stores action output result for [Custom Action - extractVideoIdFromJson] action in Youtube widget.
  String? extractedVideoId;
  // Stores action output result for [Backend Call - API (channelsListAPICall)] action in Youtube widget.
  ApiCallResponse? uploadsPlaylistId;
  // Stores action output result for [Backend Call - API (playlistItemsListAPICall)] action in Youtube widget.
  ApiCallResponse? playlistItemsResponse;
  // Stores action output result for [Custom Action - storeVideoListJsonSafely] action in Youtube widget.
  String? videoListJsonSafely;
  // Stores action output result for [Custom Action - extractItemsListFromJson] action in Youtube widget.
  List<dynamic>? videoItemsListApi;
  // Stores action output result for [Custom Action - extractVideoIdFromJson] action in Youtube widget.
  String? newVideoId;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for ListView widget.
  ScrollController? listViewController1;
  // Stores action output result for [Custom Action - isChannelCacheValid] action in Image widget.
  bool? cacheValid;
  // Stores action output result for [Custom Action - getCachedVideoListForChannel] action in Image widget.
  String? cachedVideoListForChannel;
  // Stores action output result for [Custom Action - extractItemsListFromJson] action in Image widget.
  List<dynamic>? itemsListCachedVideoList;
  // Stores action output result for [Custom Action - extractVideoIdFromJson] action in Image widget.
  String? extractedVideoIdIcon;
  // Stores action output result for [Backend Call - API (channelsListAPICall)] action in Image widget.
  ApiCallResponse? channelApiResult;
  // Stores action output result for [Backend Call - API (playlistItemsListAPICall)] action in Image widget.
  ApiCallResponse? itemsApiResult;
  // Stores action output result for [Custom Action - storeVideoListJsonSafely] action in Image widget.
  String? videoListJsonSafelyIcon;
  // Stores action output result for [Custom Action - extractItemsListFromJson] action in Image widget.
  List<dynamic>? itemsListicon;
  // Stores action output result for [Custom Action - extractVideoIdFromJson] action in Image widget.
  String? newVideoIdIcon;
  // State field(s) for ListView widget.
  ScrollController? listViewController2;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    listViewController1 = ScrollController();
    listViewController2 = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
    listViewController1?.dispose();
    listViewController2?.dispose();
  }
}
