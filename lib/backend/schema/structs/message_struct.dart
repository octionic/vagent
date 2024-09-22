// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessageStruct extends BaseStruct {
  MessageStruct({
    String? text,
    bool? blueBubble,
  })  : _text = text,
        _blueBubble = blueBubble;

  // "text" field.
  String? _text;
  String get text => _text ?? ' ';
  set text(String? val) => _text = val;

  bool hasText() => _text != null;

  // "blueBubble" field.
  bool? _blueBubble;
  bool get blueBubble => _blueBubble ?? false;
  set blueBubble(bool? val) => _blueBubble = val;

  bool hasBlueBubble() => _blueBubble != null;

  static MessageStruct fromMap(Map<String, dynamic> data) => MessageStruct(
        text: data['text'] as String?,
        blueBubble: data['blueBubble'] as bool?,
      );

  static MessageStruct? maybeFromMap(dynamic data) =>
      data is Map ? MessageStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'text': _text,
        'blueBubble': _blueBubble,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'text': serializeParam(
          _text,
          ParamType.String,
        ),
        'blueBubble': serializeParam(
          _blueBubble,
          ParamType.bool,
        ),
      }.withoutNulls;

  static MessageStruct fromSerializableMap(Map<String, dynamic> data) =>
      MessageStruct(
        text: deserializeParam(
          data['text'],
          ParamType.String,
          false,
        ),
        blueBubble: deserializeParam(
          data['blueBubble'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'MessageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MessageStruct &&
        text == other.text &&
        blueBubble == other.blueBubble;
  }

  @override
  int get hashCode => const ListEquality().hash([text, blueBubble]);
}

MessageStruct createMessageStruct({
  String? text,
  bool? blueBubble,
}) =>
    MessageStruct(
      text: text,
      blueBubble: blueBubble,
    );
