import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'youtube_widget.dart' show YoutubeWidget;
import 'package:flutter/material.dart';

class YoutubeModel extends FlutterFlowModel<YoutubeWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - isChannelCacheValid] action in Youtube widget.
  bool? cacheValidResult;
  // Stores action output result for [Custom Action - getCachedVideoListForChannel] action in Youtube widget.
  String? cachedJson;
  // Stores action output result for [Backend Call - API (channelsListAPICall)] action in Youtube widget.
  ApiCallResponse? uploadsPlaylistId;
  // Stores action output result for [Backend Call - API (playlistItemsListAPICall)] action in Youtube widget.
  ApiCallResponse? playlistItemsResponse;
  // Stores action output result for [Custom Action - storeVideoListJsonSafely] action in Youtube widget.
  String? storedJson;
  // Stores action output result for [Custom Action - extractItemsListFromJson] action in Youtube widget.
  List<dynamic>? itemsList;
  // Stores action output result for [Custom Action - extractVideoIdFromJson] action in Youtube widget.
  String? firstVideoId;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for ListView widget.
  ScrollController? listViewController1;
  // Stores action output result for [Custom Action - isChannelCacheValid] action in CircleImage widget.
  bool? cacheValid;
  // Stores action output result for [Custom Action - getCachedVideoListForChannel] action in CircleImage widget.
  String? cachedVideoListForChannel;
  // Stores action output result for [Custom Action - extractItemsListFromJson] action in CircleImage widget.
  List<dynamic>? itemsListCachedVideoList;
  // Stores action output result for [Custom Action - extractVideoIdFromJson] action in CircleImage widget.
  String? extractedVideoIdIcon;
  // Stores action output result for [Backend Call - API (channelsListAPICall)] action in CircleImage widget.
  ApiCallResponse? channelApiResult;
  // Stores action output result for [Backend Call - API (playlistItemsListAPICall)] action in CircleImage widget.
  ApiCallResponse? itemsApiResult;
  // Stores action output result for [Custom Action - storeVideoListJsonSafely] action in CircleImage widget.
  String? videoListJsonSafelyIcon;
  // Stores action output result for [Custom Action - extractItemsListFromJson] action in CircleImage widget.
  List<dynamic>? itemsListicon;
  // Stores action output result for [Custom Action - extractVideoIdFromJson] action in CircleImage widget.
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
    textFieldFocusNode?.dispose();
    textController?.dispose();

    listViewController1?.dispose();
    listViewController2?.dispose();
  }
}
