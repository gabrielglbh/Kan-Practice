// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sentence_generator_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SentenceGeneratorState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String sentence, List<String> words) succeeded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String sentence, List<String> words)? succeeded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String sentence, List<String> words)? succeeded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SentenceGeneratorInitial value) initial,
    required TResult Function(SentenceGeneratorLoading value) loading,
    required TResult Function(SentenceGeneratorSucceeded value) succeeded,
    required TResult Function(SentenceGeneratorError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SentenceGeneratorInitial value)? initial,
    TResult? Function(SentenceGeneratorLoading value)? loading,
    TResult? Function(SentenceGeneratorSucceeded value)? succeeded,
    TResult? Function(SentenceGeneratorError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SentenceGeneratorInitial value)? initial,
    TResult Function(SentenceGeneratorLoading value)? loading,
    TResult Function(SentenceGeneratorSucceeded value)? succeeded,
    TResult Function(SentenceGeneratorError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentenceGeneratorStateCopyWith<$Res> {
  factory $SentenceGeneratorStateCopyWith(SentenceGeneratorState value,
          $Res Function(SentenceGeneratorState) then) =
      _$SentenceGeneratorStateCopyWithImpl<$Res, SentenceGeneratorState>;
}

/// @nodoc
class _$SentenceGeneratorStateCopyWithImpl<$Res,
        $Val extends SentenceGeneratorState>
    implements $SentenceGeneratorStateCopyWith<$Res> {
  _$SentenceGeneratorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SentenceGeneratorInitialCopyWith<$Res> {
  factory _$$SentenceGeneratorInitialCopyWith(_$SentenceGeneratorInitial value,
          $Res Function(_$SentenceGeneratorInitial) then) =
      __$$SentenceGeneratorInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SentenceGeneratorInitialCopyWithImpl<$Res>
    extends _$SentenceGeneratorStateCopyWithImpl<$Res,
        _$SentenceGeneratorInitial>
    implements _$$SentenceGeneratorInitialCopyWith<$Res> {
  __$$SentenceGeneratorInitialCopyWithImpl(_$SentenceGeneratorInitial _value,
      $Res Function(_$SentenceGeneratorInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SentenceGeneratorInitial implements SentenceGeneratorInitial {
  const _$SentenceGeneratorInitial();

  @override
  String toString() {
    return 'SentenceGeneratorState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceGeneratorInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String sentence, List<String> words) succeeded,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String sentence, List<String> words)? succeeded,
    TResult? Function()? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String sentence, List<String> words)? succeeded,
    TResult Function()? error,
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
    required TResult Function(SentenceGeneratorInitial value) initial,
    required TResult Function(SentenceGeneratorLoading value) loading,
    required TResult Function(SentenceGeneratorSucceeded value) succeeded,
    required TResult Function(SentenceGeneratorError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SentenceGeneratorInitial value)? initial,
    TResult? Function(SentenceGeneratorLoading value)? loading,
    TResult? Function(SentenceGeneratorSucceeded value)? succeeded,
    TResult? Function(SentenceGeneratorError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SentenceGeneratorInitial value)? initial,
    TResult Function(SentenceGeneratorLoading value)? loading,
    TResult Function(SentenceGeneratorSucceeded value)? succeeded,
    TResult Function(SentenceGeneratorError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SentenceGeneratorInitial implements SentenceGeneratorState {
  const factory SentenceGeneratorInitial() = _$SentenceGeneratorInitial;
}

/// @nodoc
abstract class _$$SentenceGeneratorLoadingCopyWith<$Res> {
  factory _$$SentenceGeneratorLoadingCopyWith(_$SentenceGeneratorLoading value,
          $Res Function(_$SentenceGeneratorLoading) then) =
      __$$SentenceGeneratorLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SentenceGeneratorLoadingCopyWithImpl<$Res>
    extends _$SentenceGeneratorStateCopyWithImpl<$Res,
        _$SentenceGeneratorLoading>
    implements _$$SentenceGeneratorLoadingCopyWith<$Res> {
  __$$SentenceGeneratorLoadingCopyWithImpl(_$SentenceGeneratorLoading _value,
      $Res Function(_$SentenceGeneratorLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SentenceGeneratorLoading implements SentenceGeneratorLoading {
  const _$SentenceGeneratorLoading();

  @override
  String toString() {
    return 'SentenceGeneratorState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceGeneratorLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String sentence, List<String> words) succeeded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String sentence, List<String> words)? succeeded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String sentence, List<String> words)? succeeded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SentenceGeneratorInitial value) initial,
    required TResult Function(SentenceGeneratorLoading value) loading,
    required TResult Function(SentenceGeneratorSucceeded value) succeeded,
    required TResult Function(SentenceGeneratorError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SentenceGeneratorInitial value)? initial,
    TResult? Function(SentenceGeneratorLoading value)? loading,
    TResult? Function(SentenceGeneratorSucceeded value)? succeeded,
    TResult? Function(SentenceGeneratorError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SentenceGeneratorInitial value)? initial,
    TResult Function(SentenceGeneratorLoading value)? loading,
    TResult Function(SentenceGeneratorSucceeded value)? succeeded,
    TResult Function(SentenceGeneratorError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SentenceGeneratorLoading implements SentenceGeneratorState {
  const factory SentenceGeneratorLoading() = _$SentenceGeneratorLoading;
}

/// @nodoc
abstract class _$$SentenceGeneratorSucceededCopyWith<$Res> {
  factory _$$SentenceGeneratorSucceededCopyWith(
          _$SentenceGeneratorSucceeded value,
          $Res Function(_$SentenceGeneratorSucceeded) then) =
      __$$SentenceGeneratorSucceededCopyWithImpl<$Res>;
  @useResult
  $Res call({String sentence, List<String> words});
}

/// @nodoc
class __$$SentenceGeneratorSucceededCopyWithImpl<$Res>
    extends _$SentenceGeneratorStateCopyWithImpl<$Res,
        _$SentenceGeneratorSucceeded>
    implements _$$SentenceGeneratorSucceededCopyWith<$Res> {
  __$$SentenceGeneratorSucceededCopyWithImpl(
      _$SentenceGeneratorSucceeded _value,
      $Res Function(_$SentenceGeneratorSucceeded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sentence = null,
    Object? words = null,
  }) {
    return _then(_$SentenceGeneratorSucceeded(
      null == sentence
          ? _value.sentence
          : sentence // ignore: cast_nullable_to_non_nullable
              as String,
      null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$SentenceGeneratorSucceeded implements SentenceGeneratorSucceeded {
  const _$SentenceGeneratorSucceeded(this.sentence, final List<String> words)
      : _words = words;

  @override
  final String sentence;
  final List<String> _words;
  @override
  List<String> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  String toString() {
    return 'SentenceGeneratorState.succeeded(sentence: $sentence, words: $words)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceGeneratorSucceeded &&
            (identical(other.sentence, sentence) ||
                other.sentence == sentence) &&
            const DeepCollectionEquality().equals(other._words, _words));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, sentence, const DeepCollectionEquality().hash(_words));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SentenceGeneratorSucceededCopyWith<_$SentenceGeneratorSucceeded>
      get copyWith => __$$SentenceGeneratorSucceededCopyWithImpl<
          _$SentenceGeneratorSucceeded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String sentence, List<String> words) succeeded,
    required TResult Function() error,
  }) {
    return succeeded(sentence, words);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String sentence, List<String> words)? succeeded,
    TResult? Function()? error,
  }) {
    return succeeded?.call(sentence, words);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String sentence, List<String> words)? succeeded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (succeeded != null) {
      return succeeded(sentence, words);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SentenceGeneratorInitial value) initial,
    required TResult Function(SentenceGeneratorLoading value) loading,
    required TResult Function(SentenceGeneratorSucceeded value) succeeded,
    required TResult Function(SentenceGeneratorError value) error,
  }) {
    return succeeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SentenceGeneratorInitial value)? initial,
    TResult? Function(SentenceGeneratorLoading value)? loading,
    TResult? Function(SentenceGeneratorSucceeded value)? succeeded,
    TResult? Function(SentenceGeneratorError value)? error,
  }) {
    return succeeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SentenceGeneratorInitial value)? initial,
    TResult Function(SentenceGeneratorLoading value)? loading,
    TResult Function(SentenceGeneratorSucceeded value)? succeeded,
    TResult Function(SentenceGeneratorError value)? error,
    required TResult orElse(),
  }) {
    if (succeeded != null) {
      return succeeded(this);
    }
    return orElse();
  }
}

abstract class SentenceGeneratorSucceeded implements SentenceGeneratorState {
  const factory SentenceGeneratorSucceeded(
          final String sentence, final List<String> words) =
      _$SentenceGeneratorSucceeded;

  String get sentence;
  List<String> get words;
  @JsonKey(ignore: true)
  _$$SentenceGeneratorSucceededCopyWith<_$SentenceGeneratorSucceeded>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SentenceGeneratorErrorCopyWith<$Res> {
  factory _$$SentenceGeneratorErrorCopyWith(_$SentenceGeneratorError value,
          $Res Function(_$SentenceGeneratorError) then) =
      __$$SentenceGeneratorErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SentenceGeneratorErrorCopyWithImpl<$Res>
    extends _$SentenceGeneratorStateCopyWithImpl<$Res, _$SentenceGeneratorError>
    implements _$$SentenceGeneratorErrorCopyWith<$Res> {
  __$$SentenceGeneratorErrorCopyWithImpl(_$SentenceGeneratorError _value,
      $Res Function(_$SentenceGeneratorError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SentenceGeneratorError implements SentenceGeneratorError {
  const _$SentenceGeneratorError();

  @override
  String toString() {
    return 'SentenceGeneratorState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SentenceGeneratorError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String sentence, List<String> words) succeeded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String sentence, List<String> words)? succeeded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String sentence, List<String> words)? succeeded,
    TResult Function()? error,
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
    required TResult Function(SentenceGeneratorInitial value) initial,
    required TResult Function(SentenceGeneratorLoading value) loading,
    required TResult Function(SentenceGeneratorSucceeded value) succeeded,
    required TResult Function(SentenceGeneratorError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SentenceGeneratorInitial value)? initial,
    TResult? Function(SentenceGeneratorLoading value)? loading,
    TResult? Function(SentenceGeneratorSucceeded value)? succeeded,
    TResult? Function(SentenceGeneratorError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SentenceGeneratorInitial value)? initial,
    TResult Function(SentenceGeneratorLoading value)? loading,
    TResult Function(SentenceGeneratorSucceeded value)? succeeded,
    TResult Function(SentenceGeneratorError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SentenceGeneratorError implements SentenceGeneratorState {
  const factory SentenceGeneratorError() = _$SentenceGeneratorError;
}
