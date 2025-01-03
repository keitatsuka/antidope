import '/flutter_flow/flutter_flow_util.dart';
import 'layout_youtube_widget.dart' show LayoutYoutubeWidget;
import 'package:flutter/material.dart';

class LayoutYoutubeModel extends FlutterFlowModel<LayoutYoutubeWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
