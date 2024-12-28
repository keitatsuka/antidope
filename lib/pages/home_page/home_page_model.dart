import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - parseYouTubeUrlAction] action in Button widget.
  String? parseResult;
  // Stores action output result for [Custom Action - extractValueFromJsonString] action in Button widget.
  String? videoIdValue;
  // Stores action output result for [Custom Action - extractValueFromJsonString] action in Button widget.
  String? channelIdValue;
  // Stores action output result for [Custom Action - extractValueFromJsonString] action in Button widget.
  String? customNameValue;
  // Stores action output result for [Backend Call - API (VideosListAPICall)] action in Button widget.
  ApiCallResponse? videoRes;
  // Stores action output result for [Backend Call - API (SearchListAPICall)] action in Button widget.
  ApiCallResponse? searchRes;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
