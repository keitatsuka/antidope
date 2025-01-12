import '/flutter_flow/flutter_flow_util.dart';
import 'youtube_widget.dart' show YoutubeWidget;
import 'package:flutter/material.dart';

class YoutubeModel extends FlutterFlowModel<YoutubeWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - fetchChannelsListFromHiveAsJson] action in Youtube widget.
  dynamic newList;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - performLocalSearch] action in IconButton widget.
  String? searchResult;
  // Stores action output result for [Custom Action - fetchAllBookmarks] action in ToggleIcon widget.
  dynamic allBookmarksIcon;
  // Stores action output result for [Custom Action - findIconUrlByChannelId] action in ToggleIcon widget.
  dynamic foundIconUrl;
  // State field(s) for ListView widget.
  ScrollController? listViewController1;
  // Stores action output result for [Custom Action - safeToStringValue] action in CircleImage widget.
  String? tappedChannelId;
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
