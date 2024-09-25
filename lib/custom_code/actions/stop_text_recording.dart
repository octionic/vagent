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
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

final _audioRecorder = Record();

Future<dynamic> stopTextRecording() async {
  if (FFAppState().isRecording) {
    try {
      // Stop the recording
      await _audioRecorder.stop();
      print('Stopped audio recording');

      if (FFAppState().audioRecorderPath.isNotEmpty) {
        final file = File(FFAppState().audioRecorderPath);
        final bytes = await file.readAsBytes();

        final apiKey = FFAppState().apiKey;
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('https://api.openai.com/v1/audio/transcriptions'),
        );
        request.headers['Authorization'] = 'Bearer $apiKey';
        request.fields['model'] = 'whisper-1';
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: 'audio.m4a',
        ));

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        try {
          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            final transcription =
                utf8.decode(latin1.encode(jsonResponse['text']));
            FFAppState().speechToTextResponse = transcription;
            print('Transcription: $transcription');
            return {'success': true, 'message': ''};
          } else {
            final errorJSON = json.decode(response.body);
            String errorMsg = 'Unknown error occurred';
            if (errorJSON is Map && errorJSON.containsKey('error')) {
              errorMsg = errorJSON['error']['message'] ?? errorMsg;
            }
            print('Error: ${response.statusCode} - ${errorMsg}');
            FFAppState().speechToTextResponse = "";
            return {
              'success': false,
              'message': 'Transcription failed: ${errorMsg}'
            };
          }
        } finally {
          await file.delete();
        }
      } else {
        FFAppState().speechToTextResponse = "";
        return {'success': false, 'message': 'Temporary file path is empty'};
      }
    } catch (e) {
      print('Error stopping recording: $e');
      FFAppState().speechToTextResponse = "";
      return {'success': false, 'message': 'Error stopping recording: $e'};
    } finally {
      FFAppState().audioRecorderPath = '';
      FFAppState().isRecording = false;
    }
  }
  return {'success': false, 'message': 'Not recording'};
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
