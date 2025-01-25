import '/flutter_flow/flutter_flow_util.dart';
import 'register_password_widget.dart' show RegisterPasswordWidget;
import 'package:flutter/material.dart';

class RegisterPasswordModel extends FlutterFlowModel<RegisterPasswordWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode1;
  TextEditingController? yourNameTextController1;
  String? Function(BuildContext, String?)? yourNameTextController1Validator;
  String? _yourNameTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '設定したい４桁の数字を入力してください is required';
    }

    if (val.length < 4) {
      return '4桁の数字を入力してください';
    }
    if (val.length > 4) {
      return '4桁の半角数字を入力してください';
    }
    if (!RegExp('^[0-9]{4}\$').hasMatch(val)) {
      return '4桁の半角数字を入力してください';
    }
    return null;
  }

  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode2;
  TextEditingController? yourNameTextController2;
  String? Function(BuildContext, String?)? yourNameTextController2Validator;
  String? _yourNameTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '上と同じものを入力してください is required';
    }

    if (val.length < 4) {
      return '4桁の半角数字を入力してください';
    }
    if (val.length > 4) {
      return '4桁の半角数字を入力してください';
    }
    if (!RegExp('^[0-9]{4}\$').hasMatch(val)) {
      return '4桁の半角数字を入力してください';
    }
    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? validated;
  // Stores action output result for [Custom Action - savePassCode] action in Button widget.
  String? savedpasscode;

  @override
  void initState(BuildContext context) {
    yourNameTextController1Validator = _yourNameTextController1Validator;
    yourNameTextController2Validator = _yourNameTextController2Validator;
  }

  @override
  void dispose() {
    yourNameFocusNode1?.dispose();
    yourNameTextController1?.dispose();

    yourNameFocusNode2?.dispose();
    yourNameTextController2?.dispose();
  }
}
