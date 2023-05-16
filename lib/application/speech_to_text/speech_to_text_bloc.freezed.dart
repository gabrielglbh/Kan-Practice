// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speech_to_text_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpeechToTextState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() listening,
    required TResult Function() initial,
    required TResult Function() available,
    required TResult Function() error,
    required TResult Function(String recognizedWords) providedWords,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? listening,
    TResult? Function()? initial,
    TResult? Function()? available,
    TResult? Function()? error,
    TResult? Function(String recognizedWords)? providedWords,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? listening,
    TResult Function()? initial,
    TResult Function()? available,
    TResult Function()? error,
    TResult Function(String recognizedWords)? providedWords,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SpeechToTextListening value) listening,
    required TResult Function(SpeechToTextInitial value) initial,
    required TResult Function(SpeechToTextAvailable value) available,
    required TResult Function(SpeechToTextError value) error,
    required TResult Function(SpeechToTextProvidedWords value) providedWords,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SpeechToTextListening value)? listening,
    TResult? Function(SpeechToTextInitial value)? initial,
    TResult? Function(SpeechToTextAvailable value)? available,
    TResult? Function(SpeechToTextError value)? error,
    TResult? Function(SpeechToTextProvidedWords value)? providedWords,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SpeechToTextListening value)? listening,
    TResult Function(SpeechToTextInitial value)? initial,
    TResult Function(SpeechToTextAvailable value)? available,
    TResult Function(SpeechToTextError value)? error,
    TResult Function(SpeechToTextProvidedWords value)? providedWords,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpeechToTextStateCopyWith<$Res> {
  factory $SpeechToTextStateCopyWith(
          SpeechToTextState value, $Res Function(SpeechToTextState) then) =
      _$SpeechToTextStateCopyWithImpl<$Res, SpeechToTextState>;
}

/// @nodoc
class _$SpeechToTextStateCopyWithImpl<$Res, $Val extends SpeechToTextState>
    implements $SpeechToTextStateCopyWith<$Res> {
  _$SpeechToTextStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SpeechToTextListeningCopyWith<$Res> {
  factory _$$SpeechToTextListeningCopyWith(_$SpeechToTextListening value,
          $Res Function(_$SpeechToTextListening) then) =
      __$$SpeechToTextListeningCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SpeechToTextListeningCopyWithImpl<$Res>
    extends _$SpeechToTextStateCopyWithImpl<$Res, _$SpeechToTextListening>
    implements _$$SpeechToTextListeningCopyWith<$Res> {
  __$$SpeechToTextListeningCopyWithImpl(_$SpeechToTextListening _value,
      $Res Function(_$SpeechToTextListening) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SpeechToTextListening implements SpeechToTextListening {
  const _$SpeechToTextListening();

  @override
  String toString() {
    return 'SpeechToTextState.listening()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SpeechToTextListening);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() listening,
    required TResult Function() initial,
    required TResult Function() available,
    required TResult Function() error,
    required TResult Function(String recognizedWords) providedWords,
  }) {
    return listening();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? listening,
    TResult? Function()? initial,
    TResult? Function()? available,
    TResult? Function()? error,
    TResult? Function(String recognizedWords)? providedWords,
  }) {
    return listening?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? listening,
    TResult Function()? initial,
    TResult Function()? available,
    TResult Function()? error,
    TResult Function(String recognizedWords)? providedWords,
    required TResult orElse(),
  }) {
    if (listening != null) {
      return listening();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SpeechToTextListening value) listening,
    required TResult Function(SpeechToTextInitial value) initial,
    required TResult Function(SpeechToTextAvailable value) available,
    required TResult Function(SpeechToTextError value) error,
    required TResult Function(SpeechToTextProvidedWords value) providedWords,
  }) {
    return listening(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SpeechToTextListening value)? listening,
    TResult? Function(SpeechToTextInitial value)? initial,
    TResult? Function(SpeechToTextAvailable value)? available,
    TResult? Function(SpeechToTextError value)? error,
    TResult? Function(SpeechToTextProvidedWords value)? providedWords,
  }) {
    return listening?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SpeechToTextListening value)? listening,
    TResult Function(SpeechToTextInitial value)? initial,
    TResult Function(SpeechToTextAvailable value)? available,
    TResult Function(SpeechToTextError value)? error,
    TResult Function(SpeechToTextProvidedWords value)? providedWords,
    required TResult orElse(),
  }) {
    if (listening != null) {
      return listening(this);
    }
    return orElse();
  }
}

abstract class SpeechToTextListening implements SpeechToTextState {
  const factory SpeechToTextListening() = _$SpeechToTextListening;
}

/// @nodoc
abstract class _$$SpeechToTextInitialCopyWith<$Res> {
  factory _$$SpeechToTextInitialCopyWith(_$SpeechToTextInitial value,
          $Res Function(_$SpeechToTextInitial) then) =
      __$$SpeechToTextInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SpeechToTextInitialCopyWithImpl<$Res>
    extends _$SpeechToTextStateCopyWithImpl<$Res, _$SpeechToTextInitial>
    implements _$$SpeechToTextInitialCopyWith<$Res> {
  __$$SpeechToTextInitialCopyWithImpl(
      _$SpeechToTextInitial _value, $Res Function(_$SpeechToTextInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SpeechToTextInitial implements SpeechToTextInitial {
  const _$SpeechToTextInitial();

  @override
  String toString() {
    return 'SpeechToTextState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SpeechToTextInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() listening,
    required TResult Function() initial,
    required TResult Function() available,
    required TResult Function() error,
    required TResult Function(String recognizedWords) providedWords,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? listening,
    TResult? Function()? initial,
    TResult? Function()? available,
    TResult? Function()? error,
    TResult? Function(String recognizedWords)? providedWords,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? listening,
    TResult Function()? initial,
    TResult Function()? available,
    TResult Function()? error,
    TResult Function(String recognizedWords)? providedWords,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SpeechToTextListening value) listening,
    required TResult Function(SpeechToTextInitial value) initial,
    required TResult Function(SpeechToTextAvailable value) available,
    required TResult Function(SpeechToTextError value) error,
    required TResult Function(SpeechToTextProvidedWords value) providedWords,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SpeechToTextListening value)? listening,
    TResult? Function(SpeechToTextInitial value)? initial,
    TResult? Function(SpeechToTextAvailable value)? available,
    TResult? Function(SpeechToTextError value)? error,
    TResult? Function(SpeechToTextProvidedWords value)? providedWords,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SpeechToTextListening value)? listening,
    TResult Function(SpeechToTextInitial value)? initial,
    TResult Function(SpeechToTextAvailable value)? available,
    TResult Function(SpeechToTextError value)? error,
    TResult Function(SpeechToTextProvidedWords value)? providedWords,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SpeechToTextInitial implements SpeechToTextState {
  const factory SpeechToTextInitial() = _$SpeechToTextInitial;
}

/// @nodoc
abstract class _$$SpeechToTextAvailableCopyWith<$Res> {
  factory _$$SpeechToTextAvailableCopyWith(_$SpeechToTextAvailable value,
          $Res Function(_$SpeechToTextAvailable) then) =
      __$$SpeechToTextAvailableCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SpeechToTextAvailableCopyWithImpl<$Res>
    extends _$SpeechToTextStateCopyWithImpl<$Res, _$SpeechToTextAvailable>
    implements _$$SpeechToTextAvailableCopyWith<$Res> {
  __$$SpeechToTextAvailableCopyWithImpl(_$SpeechToTextAvailable _value,
      $Res Function(_$SpeechToTextAvailable) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SpeechToTextAvailable implements SpeechToTextAvailable {
  const _$SpeechToTextAvailable();

  @override
  String toString() {
    return 'SpeechToTextState.available()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SpeechToTextAvailable);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() listening,
    required TResult Function() initial,
    required TResult Function() available,
    required TResult Function() error,
    required TResult Function(String recognizedWords) providedWords,
  }) {
    return available();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? listening,
    TResult? Function()? initial,
    TResult? Function()? available,
    TResult? Function()? error,
    TResult? Function(String recognizedWords)? providedWords,
  }) {
    return available?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? listening,
    TResult Function()? initial,
    TResult Function()? available,
    TResult Function()? error,
    TResult Function(String recognizedWords)? providedWords,
    required TResult orElse(),
  }) {
    if (available != null) {
      return available();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SpeechToTextListening value) listening,
    required TResult Function(SpeechToTextInitial value) initial,
    required TResult Function(SpeechToTextAvailable value) available,
    required TResult Function(SpeechToTextError value) error,
    required TResult Function(SpeechToTextProvidedWords value) providedWords,
  }) {
    return available(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SpeechToTextListening value)? listening,
    TResult? Function(SpeechToTextInitial value)? initial,
    TResult? Function(SpeechToTextAvailable value)? available,
    TResult? Function(SpeechToTextError value)? error,
    TResult? Function(SpeechToTextProvidedWords value)? providedWords,
  }) {
    return available?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SpeechToTextListening value)? listening,
    TResult Function(SpeechToTextInitial value)? initial,
    TResult Function(SpeechToTextAvailable value)? available,
    TResult Function(SpeechToTextError value)? error,
    TResult Function(SpeechToTextProvidedWords value)? providedWords,
    required TResult orElse(),
  }) {
    if (available != null) {
      return available(this);
    }
    return orElse();
  }
}

abstract class SpeechToTextAvailable implements SpeechToTextState {
  const factory SpeechToTextAvailable() = _$SpeechToTextAvailable;
}

/// @nodoc
abstract class _$$SpeechToTextErrorCopyWith<$Res> {
  factory _$$SpeechToTextErrorCopyWith(
          _$SpeechToTextError value, $Res Function(_$SpeechToTextError) then) =
      __$$SpeechToTextErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SpeechToTextErrorCopyWithImpl<$Res>
    extends _$SpeechToTextStateCopyWithImpl<$Res, _$SpeechToTextError>
    implements _$$SpeechToTextErrorCopyWith<$Res> {
  __$$SpeechToTextErrorCopyWithImpl(
      _$SpeechToTextError _value, $Res Function(_$SpeechToTextError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SpeechToTextError implements SpeechToTextError {
  const _$SpeechToTextError();

  @override
  String toString() {
    return 'SpeechToTextState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SpeechToTextError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() listening,
    required TResult Function() initial,
    required TResult Function() available,
    required TResult Function() error,
    required TResult Function(String recognizedWords) providedWords,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? listening,
    TResult? Function()? initial,
    TResult? Function()? available,
    TResult? Function()? error,
    TResult? Function(String recognizedWords)? providedWords,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? listening,
    TResult Function()? initial,
    TResult Function()? available,
    TResult Function()? error,
    TResult Function(String recognizedWords)? providedWords,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SpeechToTextListening value) listening,
    required TResult Function(SpeechToTextInitial value) initial,
    required TResult Function(SpeechToTextAvailable value) available,
    required TResult Function(SpeechToTextError value) error,
    required TResult Function(SpeechToTextProvidedWords value) providedWords,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SpeechToTextListening value)? listening,
    TResult? Function(SpeechToTextInitial value)? initial,
    TResult? Function(SpeechToTextAvailable value)? available,
    TResult? Function(SpeechToTextError value)? error,
    TResult? Function(SpeechToTextProvidedWords value)? providedWords,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SpeechToTextListening value)? listening,
    TResult Function(SpeechToTextInitial value)? initial,
    TResult Function(SpeechToTextAvailable value)? available,
    TResult Function(SpeechToTextError value)? error,
    TResult Function(SpeechToTextProvidedWords value)? providedWords,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SpeechToTextError implements SpeechToTextState {
  const factory SpeechToTextError() = _$SpeechToTextError;
}

/// @nodoc
abstract class _$$SpeechToTextProvidedWordsCopyWith<$Res> {
  factory _$$SpeechToTextProvidedWordsCopyWith(
          _$SpeechToTextProvidedWords value,
          $Res Function(_$SpeechToTextProvidedWords) then) =
      __$$SpeechToTextProvidedWordsCopyWithImpl<$Res>;
  @useResult
  $Res call({String recognizedWords});
}

/// @nodoc
class __$$SpeechToTextProvidedWordsCopyWithImpl<$Res>
    extends _$SpeechToTextStateCopyWithImpl<$Res, _$SpeechToTextProvidedWords>
    implements _$$SpeechToTextProvidedWordsCopyWith<$Res> {
  __$$SpeechToTextProvidedWordsCopyWithImpl(_$SpeechToTextProvidedWords _value,
      $Res Function(_$SpeechToTextProvidedWords) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recognizedWords = null,
  }) {
    return _then(_$SpeechToTextProvidedWords(
      null == recognizedWords
          ? _value.recognizedWords
          : recognizedWords // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SpeechToTextProvidedWords implements SpeechToTextProvidedWords {
  const _$SpeechToTextProvidedWords(this.recognizedWords);

  @override
  final String recognizedWords;

  @override
  String toString() {
    return 'SpeechToTextState.providedWords(recognizedWords: $recognizedWords)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpeechToTextProvidedWords &&
            (identical(other.recognizedWords, recognizedWords) ||
                other.recognizedWords == recognizedWords));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recognizedWords);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpeechToTextProvidedWordsCopyWith<_$SpeechToTextProvidedWords>
      get copyWith => __$$SpeechToTextProvidedWordsCopyWithImpl<
          _$SpeechToTextProvidedWords>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() listening,
    required TResult Function() initial,
    required TResult Function() available,
    required TResult Function() error,
    required TResult Function(String recognizedWords) providedWords,
  }) {
    return providedWords(recognizedWords);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? listening,
    TResult? Function()? initial,
    TResult? Function()? available,
    TResult? Function()? error,
    TResult? Function(String recognizedWords)? providedWords,
  }) {
    return providedWords?.call(recognizedWords);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? listening,
    TResult Function()? initial,
    TResult Function()? available,
    TResult Function()? error,
    TResult Function(String recognizedWords)? providedWords,
    required TResult orElse(),
  }) {
    if (providedWords != null) {
      return providedWords(recognizedWords);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SpeechToTextListening value) listening,
    required TResult Function(SpeechToTextInitial value) initial,
    required TResult Function(SpeechToTextAvailable value) available,
    required TResult Function(SpeechToTextError value) error,
    required TResult Function(SpeechToTextProvidedWords value) providedWords,
  }) {
    return providedWords(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SpeechToTextListening value)? listening,
    TResult? Function(SpeechToTextInitial value)? initial,
    TResult? Function(SpeechToTextAvailable value)? available,
    TResult? Function(SpeechToTextError value)? error,
    TResult? Function(SpeechToTextProvidedWords value)? providedWords,
  }) {
    return providedWords?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SpeechToTextListening value)? listening,
    TResult Function(SpeechToTextInitial value)? initial,
    TResult Function(SpeechToTextAvailable value)? available,
    TResult Function(SpeechToTextError value)? error,
    TResult Function(SpeechToTextProvidedWords value)? providedWords,
    required TResult orElse(),
  }) {
    if (providedWords != null) {
      return providedWords(this);
    }
    return orElse();
  }
}

abstract class SpeechToTextProvidedWords implements SpeechToTextState {
  const factory SpeechToTextProvidedWords(final String recognizedWords) =
      _$SpeechToTextProvidedWords;

  String get recognizedWords;
  @JsonKey(ignore: true)
  _$$SpeechToTextProvidedWordsCopyWith<_$SpeechToTextProvidedWords>
      get copyWith => throw _privateConstructorUsedError;
}
