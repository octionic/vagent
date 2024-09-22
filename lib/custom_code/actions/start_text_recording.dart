// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions

import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

final _audioRecorder = Record();

Future<void> startTextRecording() async {
  if (await _audioRecorder.hasPermission()) {
    // Get the temporary directory
    final tempDir = await getTemporaryDirectory();
    final tempFilePath =
        '${tempDir.path}/temp_audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

    // Start recording
    await _audioRecorder.start(path: tempFilePath);
    print('Starting audio recording to $tempFilePath');

    // Update FlutterFlow app state
    FFAppState().audioRecorderPath = tempFilePath;
    FFAppState().isRecording = true;
  } else {
    print('Audio recording permission not granted');
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
