// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<bool> validateSettings() async {
  String apiKey = FFAppState().apiKey;
  String webhookURL = FFAppState().webhookURL;
  String webhookAuthValue = FFAppState().webhookAuthValue;

  // Check if all three values are not empty
  return apiKey.isNotEmpty &&
      webhookURL.isNotEmpty &&
      webhookAuthValue.isNotEmpty;
}
