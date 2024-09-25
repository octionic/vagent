import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  bool isRecording = false;

  bool showWaveform = false;

  String? queryText = ' ';

  bool isTranscribing = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // Stores action output result for [Custom Action - validateSettings] action in StartRecording widget.
  bool? settingsOK;
  // Stores action output result for [Custom Action - stopTextRecording] action in StopRecording widget.
  dynamic recordingError;
  // Stores action output result for [Backend Call - API (GetAgentResponse)] action in StopRecording widget.
  ApiCallResponse? getResponseAPICall;
  // Stores action output result for [Custom Action - fetchSpeechAndPlay] action in StopRecording widget.
  int? speechDuration;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 0;
  int timerMilliseconds = 0;
  String timerValue = StopWatchTimer.getDisplayTime(
    0,
    hours: false,
    minute: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  @override
  void initState(BuildContext context) {
    listViewController = ScrollController();
  }

  @override
  void dispose() {
    listViewController?.dispose();
    timerController.dispose();
  }
}
