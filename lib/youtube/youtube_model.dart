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
  // Stores action output result for [Backend Call - API (Youtube Data API)] action in Youtube widget.
  ApiCallResponse? apiResultsvm;
  // Stores action output result for [Custom Action - storeVideoListJsonSafely] action in Youtube widget.
  String? videoListJsonSafely;
  // Stores action output result for [Custom Action - extractItemsListFromJson] action in Youtube widget.
  List<dynamic>? videoItemsListApi;
  // Stores action output result for [Custom Action - extractVideoIdFromJson] action in Youtube widget.
  String? newVideoId;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for ListView widget.
  ScrollController? listViewController;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    listViewController = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
    listViewController?.dispose();
  }
}
