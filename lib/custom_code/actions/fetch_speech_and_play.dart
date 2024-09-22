// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

//import '/flutter_flow/custom_functions.dart'; // Imports custom functions

import 'dart:async'; // Required for the Completer
import 'dart:convert';
import 'package:just_audio/just_audio.dart'; // Import for audio playback
import 'package:http/http.dart' as http;

// Add this line at the top of the file, outside of any function
GlobalAudioPlayer globalAudioPlayer = GlobalAudioPlayer();

Future<int> fetchSpeechAndPlay(
  String promptText,
  String? apiKey,
) async {
  // Reset audioplayer every time
  // fixes bug where audio would not play after locking the screen once on iOS
  await globalAudioPlayer.reinitialize();
  // Ensure the API key is provided
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('API key is required.');
  }
  // Set up the POST request headers.
  Map<String, String> headers = {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };

  // Set up the POST request body.
  String body = json.encode(
      {'model': 'tts-1', 'input': promptText, 'voice': 'nova', 'speed': '1'});

  // Make the POST request to fetch the speech audio.
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/audio/speech'),
    headers: headers,
    body: body,
  );

  // Handle the response
  if (response.statusCode == 200) {
    // Replace the local AudioPlayer with the global one
    await globalAudioPlayer.setAudioSource(
      BytesAudioSource(response.bodyBytes),
    );

    // Play the audio
    globalAudioPlayer.play();

    // Return the duration in milliseconds
    return globalAudioPlayer.duration?.inMilliseconds ?? 0;
  } else {
    // If the server did not return a "200 OK response",
    // throw an exception
    throw Exception(
        'Failed to generate speech. Status code: ${response.statusCode}');
  }
}

// Add this class at the end of the file
class GlobalAudioPlayer {
  AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<Duration?> setAudioSource(AudioSource source) {
    return _player.setAudioSource(source);
  }

  Future<void> play() {
    return _player.play();
  }

  Future<void> stop() {
    return _player.stop();
  }

  Duration? get duration => _player.duration;

  // New method to reinitialize the player
  Future<void> reinitialize() async {
    await _player.dispose();
    _player = AudioPlayer();
  }
}

class BytesAudioSource extends StreamAudioSource {
  final List<int> _bytes;
  BytesAudioSource(this._bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= _bytes.length;
    return StreamAudioResponse(
      sourceLength: _bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(_bytes.sublist(start, end)),
      contentType: 'audio/mp3',
    );
  }
}
