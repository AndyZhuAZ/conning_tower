// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'raw_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RawData _$RawDataFromJson(Map<String, dynamic> json) {
  return _RawData.fromJson(json);
}

/// @nodoc
mixin _$RawData {
  String get source => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RawDataCopyWith<RawData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RawDataCopyWith<$Res> {
  factory $RawDataCopyWith(RawData value, $Res Function(RawData) then) =
      _$RawDataCopyWithImpl<$Res, RawData>;
  @useResult
  $Res call({String source, String data, int timestamp});
}

/// @nodoc
class _$RawDataCopyWithImpl<$Res, $Val extends RawData>
    implements $RawDataCopyWith<$Res> {
  _$RawDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? data = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RawDataCopyWith<$Res> implements $RawDataCopyWith<$Res> {
  factory _$$_RawDataCopyWith(
          _$_RawData value, $Res Function(_$_RawData) then) =
      __$$_RawDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String source, String data, int timestamp});
}

/// @nodoc
class __$$_RawDataCopyWithImpl<$Res>
    extends _$RawDataCopyWithImpl<$Res, _$_RawData>
    implements _$$_RawDataCopyWith<$Res> {
  __$$_RawDataCopyWithImpl(_$_RawData _value, $Res Function(_$_RawData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? data = null,
    Object? timestamp = null,
  }) {
    return _then(_$_RawData(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RawData with DiagnosticableTreeMixin implements _RawData {
  const _$_RawData(
      {required this.source, required this.data, required this.timestamp});

  factory _$_RawData.fromJson(Map<String, dynamic> json) =>
      _$$_RawDataFromJson(json);

  @override
  final String source;
  @override
  final String data;
  @override
  final int timestamp;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RawData(source: $source, data: $data, timestamp: $timestamp)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RawData'))
      ..add(DiagnosticsProperty('source', source))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('timestamp', timestamp));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RawData &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, source, data, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RawDataCopyWith<_$_RawData> get copyWith =>
      __$$_RawDataCopyWithImpl<_$_RawData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RawDataToJson(
      this,
    );
  }
}

abstract class _RawData implements RawData {
  const factory _RawData(
      {required final String source,
      required final String data,
      required final int timestamp}) = _$_RawData;

  factory _RawData.fromJson(Map<String, dynamic> json) = _$_RawData.fromJson;

  @override
  String get source;
  @override
  String get data;
  @override
  int get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_RawDataCopyWith<_$_RawData> get copyWith =>
      throw _privateConstructorUsedError;
}

RawDataLog _$RawDataLogFromJson(Map<String, dynamic> json) {
  return _RawDataLog.fromJson(json);
}

/// @nodoc
mixin _$RawDataLog {
  int get time => throw _privateConstructorUsedError;
  List<RawData> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RawDataLogCopyWith<RawDataLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RawDataLogCopyWith<$Res> {
  factory $RawDataLogCopyWith(
          RawDataLog value, $Res Function(RawDataLog) then) =
      _$RawDataLogCopyWithImpl<$Res, RawDataLog>;
  @useResult
  $Res call({int time, List<RawData> data});
}

/// @nodoc
class _$RawDataLogCopyWithImpl<$Res, $Val extends RawDataLog>
    implements $RawDataLogCopyWith<$Res> {
  _$RawDataLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<RawData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RawDataLogCopyWith<$Res>
    implements $RawDataLogCopyWith<$Res> {
  factory _$$_RawDataLogCopyWith(
          _$_RawDataLog value, $Res Function(_$_RawDataLog) then) =
      __$$_RawDataLogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int time, List<RawData> data});
}

/// @nodoc
class __$$_RawDataLogCopyWithImpl<$Res>
    extends _$RawDataLogCopyWithImpl<$Res, _$_RawDataLog>
    implements _$$_RawDataLogCopyWith<$Res> {
  __$$_RawDataLogCopyWithImpl(
      _$_RawDataLog _value, $Res Function(_$_RawDataLog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? data = null,
  }) {
    return _then(_$_RawDataLog(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<RawData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RawDataLog with DiagnosticableTreeMixin implements _RawDataLog {
  const _$_RawDataLog({required this.time, required final List<RawData> data})
      : _data = data;

  factory _$_RawDataLog.fromJson(Map<String, dynamic> json) =>
      _$$_RawDataLogFromJson(json);

  @override
  final int time;
  final List<RawData> _data;
  @override
  List<RawData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RawDataLog(time: $time, data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RawDataLog'))
      ..add(DiagnosticsProperty('time', time))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RawDataLog &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, time, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RawDataLogCopyWith<_$_RawDataLog> get copyWith =>
      __$$_RawDataLogCopyWithImpl<_$_RawDataLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RawDataLogToJson(
      this,
    );
  }
}

abstract class _RawDataLog implements RawDataLog {
  const factory _RawDataLog(
      {required final int time,
      required final List<RawData> data}) = _$_RawDataLog;

  factory _RawDataLog.fromJson(Map<String, dynamic> json) =
      _$_RawDataLog.fromJson;

  @override
  int get time;
  @override
  List<RawData> get data;
  @override
  @JsonKey(ignore: true)
  _$$_RawDataLogCopyWith<_$_RawDataLog> get copyWith =>
      throw _privateConstructorUsedError;
}