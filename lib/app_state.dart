import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = const FlutterSecureStorage();
    await _safeInitAsync(() async {
      _apiKey = await secureStorage.getString('ff_apiKey') ?? _apiKey;
    });
    await _safeInitAsync(() async {
      _webhookURL =
          await secureStorage.getString('ff_webhookURL') ?? _webhookURL;
    });
    await _safeInitAsync(() async {
      _webhookAuthValue =
          await secureStorage.getString('ff_webhookAuthValue') ??
              _webhookAuthValue;
    });
    await _safeInitAsync(() async {
      _sessionID = await secureStorage.getString('ff_sessionID') ?? _sessionID;
    });
    await _safeInitAsync(() async {
      _messageHistory = (await secureStorage.getStringList('ff_messageHistory'))
              ?.map((x) {
                try {
                  return MessageStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _messageHistory;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  String _apiKey = '';
  String get apiKey => _apiKey;
  set apiKey(String value) {
    _apiKey = value;
    secureStorage.setString('ff_apiKey', value);
  }

  void deleteApiKey() {
    secureStorage.delete(key: 'ff_apiKey');
  }

  String _speechToTextResponse = '';
  String get speechToTextResponse => _speechToTextResponse;
  set speechToTextResponse(String value) {
    _speechToTextResponse = value;
  }

  int _timerValue = 0;
  int get timerValue => _timerValue;
  set timerValue(int value) {
    _timerValue = value;
  }

  String _audioRecorderPath = '';
  String get audioRecorderPath => _audioRecorderPath;
  set audioRecorderPath(String value) {
    _audioRecorderPath = value;
  }

  bool _isRecording = false;
  bool get isRecording => _isRecording;
  set isRecording(bool value) {
    _isRecording = value;
  }

  String _webhookURL = '';
  String get webhookURL => _webhookURL;
  set webhookURL(String value) {
    _webhookURL = value;
    secureStorage.setString('ff_webhookURL', value);
  }

  void deleteWebhookURL() {
    secureStorage.delete(key: 'ff_webhookURL');
  }

  String _webhookAuthValue = '';
  String get webhookAuthValue => _webhookAuthValue;
  set webhookAuthValue(String value) {
    _webhookAuthValue = value;
    secureStorage.setString('ff_webhookAuthValue', value);
  }

  void deleteWebhookAuthValue() {
    secureStorage.delete(key: 'ff_webhookAuthValue');
  }

  String _sessionID = '';
  String get sessionID => _sessionID;
  set sessionID(String value) {
    _sessionID = value;
    secureStorage.setString('ff_sessionID', value);
  }

  void deleteSessionID() {
    secureStorage.delete(key: 'ff_sessionID');
  }

  List<MessageStruct> _messageHistory = [];
  List<MessageStruct> get messageHistory => _messageHistory;
  set messageHistory(List<MessageStruct> value) {
    _messageHistory = value;
    secureStorage.setStringList(
        'ff_messageHistory', value.map((x) => x.serialize()).toList());
  }

  void deleteMessageHistory() {
    secureStorage.delete(key: 'ff_messageHistory');
  }

  void addToMessageHistory(MessageStruct value) {
    messageHistory.add(value);
    secureStorage.setStringList('ff_messageHistory',
        _messageHistory.map((x) => x.serialize()).toList());
  }

  void removeFromMessageHistory(MessageStruct value) {
    messageHistory.remove(value);
    secureStorage.setStringList('ff_messageHistory',
        _messageHistory.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMessageHistory(int index) {
    messageHistory.removeAt(index);
    secureStorage.setStringList('ff_messageHistory',
        _messageHistory.map((x) => x.serialize()).toList());
  }

  void updateMessageHistoryAtIndex(
    int index,
    MessageStruct Function(MessageStruct) updateFn,
  ) {
    messageHistory[index] = updateFn(_messageHistory[index]);
    secureStorage.setStringList('ff_messageHistory',
        _messageHistory.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMessageHistory(int index, MessageStruct value) {
    messageHistory.insert(index, value);
    secureStorage.setStringList('ff_messageHistory',
        _messageHistory.map((x) => x.serialize()).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return const CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: const ListToCsvConverter().convert([value]));
}
