import '/flutter_flow/flutter_flow_util.dart';
import 'chechk_passcode_widget.dart' show ChechkPasscodeWidget;
import 'package:flutter/material.dart';

class ChechkPasscodeModel extends FlutterFlowModel<ChechkPasscodeWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode;
  TextEditingController? yourNameTextController;
  String? Function(BuildContext, String?)? yourNameTextControllerValidator;
  // Stores action output result for [Custom Action - checkPassCode] action in Button widget.
  bool? checkedPassCode;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    yourNameFocusNode?.dispose();
    yourNameTextController?.dispose();
  }
}
