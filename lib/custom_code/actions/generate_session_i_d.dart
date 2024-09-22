// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:uuid/uuid.dart'; // Import UUID package

Future generateSessionID() async {
  // Generate a new UUID
  var uuid = Uuid();
  String newSessionID = uuid.v4(); // Generates a new UUID (v4)

  // Store the generated session ID in the App State
  FFAppState().sessionID = newSessionID;
}
