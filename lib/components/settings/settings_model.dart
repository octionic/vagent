import '/flutter_flow/flutter_flow_util.dart';
import 'settings_widget.dart' show SettingsWidget;
import 'package:flutter/material.dart';

class SettingsModel extends FlutterFlowModel<SettingsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for apiKey widget.
  FocusNode? apiKeyFocusNode;
  TextEditingController? apiKeyTextController;
  String? Function(BuildContext, String?)? apiKeyTextControllerValidator;
  // State field(s) for webhookURL widget.
  FocusNode? webhookURLFocusNode;
  TextEditingController? webhookURLTextController;
  String? Function(BuildContext, String?)? webhookURLTextControllerValidator;
  // State field(s) for webhookAuthValue widget.
  FocusNode? webhookAuthValueFocusNode;
  TextEditingController? webhookAuthValueTextController;
  String? Function(BuildContext, String?)?
      webhookAuthValueTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    apiKeyFocusNode?.dispose();
    apiKeyTextController?.dispose();

    webhookURLFocusNode?.dispose();
    webhookURLTextController?.dispose();

    webhookAuthValueFocusNode?.dispose();
    webhookAuthValueTextController?.dispose();
  }
}
