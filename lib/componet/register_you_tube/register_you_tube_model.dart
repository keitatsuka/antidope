import '/flutter_flow/flutter_flow_util.dart';
import 'register_you_tube_widget.dart' show RegisterYouTubeWidget;
import 'package:flutter/material.dart';

class RegisterYouTubeModel extends FlutterFlowModel<RegisterYouTubeWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode;
  TextEditingController? yourNameTextController;
  String? Function(BuildContext, String?)? yourNameTextControllerValidator;
  // Stores action output result for [Custom Action - registerYouTubeChannel] action in IconButton widget.
  dynamic registerResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    yourNameFocusNode?.dispose();
    yourNameTextController?.dispose();
  }
}
