import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'registration_widget.dart' show RegistrationWidget;
import 'package:flutter/material.dart';

class RegistrationModel extends FlutterFlowModel<RegistrationWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - fetchChannelsListFromHiveAsJson] action in registration widget.
  dynamic channelsData;
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
  // Stores action output result for [Backend Call - API (channelsListAPICall)] action in Button widget.
  ApiCallResponse? apiResultfir;
  // Stores action output result for [Custom Action - fetchChannelsListFromHiveAsJson] action in Button widget.
  dynamic fechChannelsListVideo;
  // Stores action output result for [Backend Call - API (channelsListAPICall)] action in Button widget.
  ApiCallResponse? channelRes;
  // Stores action output result for [Custom Action - fetchChannelsListFromHiveAsJson] action in Button widget.
  dynamic channelsDataTap;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
