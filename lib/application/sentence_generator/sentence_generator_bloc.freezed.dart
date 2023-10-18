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
    required TResult Function(
            String sentence, String translation, List<String> words)
        succeeded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String sentence, String translation, List<String> words)?
        succeeded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String sentence, String translation, List<String> words)?
        succeeded,
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
abstract class _$$SentenceGeneratorInitialImplCopyWith<$Res> {
  factory _$$SentenceGeneratorInitialImplCopyWith(
          _$SentenceGeneratorInitialImpl value,
          $Res Function(_$SentenceGeneratorInitialImpl) then) =
      __$$SentenceGeneratorInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SentenceGeneratorInitialImplCopyWithImpl<$Res>
    extends _$SentenceGeneratorStateCopyWithImpl<$Res,
        _$SentenceGeneratorInitialImpl>
    implements _$$SentenceGeneratorInitialImplCopyWith<$Res> {
  __$$SentenceGeneratorInitialImplCopyWithImpl(
      _$SentenceGeneratorInitialImpl _value,
      $Res Function(_$SentenceGeneratorInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SentenceGeneratorInitialImpl implements SentenceGeneratorInitial {
  const _$SentenceGeneratorInitialImpl();

  @override
  String toString() {
    return 'SentenceGeneratorState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceGeneratorInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            String sentence, String translation, List<String> words)
        succeeded,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String sentence, String translation, List<String> words)?
        succeeded,
    TResult? Function()? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String sentence, String translation, List<String> words)?
        succeeded,
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
  const factory SentenceGeneratorInitial() = _$SentenceGeneratorInitialImpl;
}

/// @nodoc
abstract class _$$SentenceGeneratorLoadingImplCopyWith<$Res> {
  factory _$$SentenceGeneratorLoadingImplCopyWith(
          _$SentenceGeneratorLoadingImpl value,
          $Res Function(_$SentenceGeneratorLoadingImpl) then) =
      __$$SentenceGeneratorLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SentenceGeneratorLoadingImplCopyWithImpl<$Res>
    extends _$SentenceGeneratorStateCopyWithImpl<$Res,
        _$SentenceGeneratorLoadingImpl>
    implements _$$SentenceGeneratorLoadingImplCopyWith<$Res> {
  __$$SentenceGeneratorLoadingImplCopyWithImpl(
      _$SentenceGeneratorLoadingImpl _value,
      $Res Function(_$SentenceGeneratorLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SentenceGeneratorLoadingImpl implements SentenceGeneratorLoading {
  const _$SentenceGeneratorLoadingImpl();

  @override
  String toString() {
    return 'SentenceGeneratorState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceGeneratorLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            String sentence, String translation, List<String> words)
        succeeded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String sentence, String translation, List<String> words)?
        succeeded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String sentence, String translation, List<String> words)?
        succeeded,
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
  const factory SentenceGeneratorLoading() = _$SentenceGeneratorLoadingImpl;
}

/// @nodoc
abstract class _$$SentenceGeneratorSucceededImplCopyWith<$Res> {
  factory _$$SentenceGeneratorSucceededImplCopyWith(
          _$SentenceGeneratorSucceededImpl value,
          $Res Function(_$SentenceGeneratorSucceededImpl) then) =
      __$$SentenceGeneratorSucceededImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sentence, String translation, List<String> words});
}

/// @nodoc
class __$$SentenceGeneratorSucceededImplCopyWithImpl<$Res>
    extends _$SentenceGeneratorStateCopyWithImpl<$Res,
        _$SentenceGeneratorSucceededImpl>
    implements _$$SentenceGeneratorSucceededImplCopyWith<$Res> {
  __$$SentenceGeneratorSucceededImplCopyWithImpl(
      _$SentenceGeneratorSucceededImpl _value,
      $Res Function(_$SentenceGeneratorSucceededImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sentence = null,
    Object? translation = null,
    Object? words = null,
  }) {
    return _then(_$SentenceGeneratorSucceededImpl(
      null == sentence
          ? _value.sentence
          : sentence // ignore: cast_nullable_to_non_nullable
              as String,
      null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$SentenceGeneratorSucceededImpl implements SentenceGeneratorSucceeded {
  const _$SentenceGeneratorSucceededImpl(
      this.sentence, this.translation, final List<String> words)
      : _words = words;

  @override
  final String sentence;
  @override
  final String translation;
  final List<String> _words;
  @override
  List<String> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  String toString() {
    return 'SentenceGeneratorState.succeeded(sentence: $sentence, translation: $translation, words: $words)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceGeneratorSucceededImpl &&
            (identical(other.sentence, sentence) ||
                other.sentence == sentence) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            const DeepCollectionEquality().equals(other._words, _words));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sentence, translation,
      const DeepCollectionEquality().hash(_words));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SentenceGeneratorSucceededImplCopyWith<_$SentenceGeneratorSucceededImpl>
      get copyWith => __$$SentenceGeneratorSucceededImplCopyWithImpl<
          _$SentenceGeneratorSucceededImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            String sentence, String translation, List<String> words)
        succeeded,
    required TResult Function() error,
  }) {
    return succeeded(sentence, translation, words);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String sentence, String translation, List<String> words)?
        succeeded,
    TResult? Function()? error,
  }) {
    return succeeded?.call(sentence, translation, words);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String sentence, String translation, List<String> words)?
        succeeded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (succeeded != null) {
      return succeeded(sentence, translation, words);
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
      final String sentence,
      final String translation,
      final List<String> words) = _$SentenceGeneratorSucceededImpl;

  String get sentence;
  String get translation;
  List<String> get words;
  @JsonKey(ignore: true)
  _$$SentenceGeneratorSucceededImplCopyWith<_$SentenceGeneratorSucceededImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SentenceGeneratorErrorImplCopyWith<$Res> {
  factory _$$SentenceGeneratorErrorImplCopyWith(
          _$SentenceGeneratorErrorImpl value,
          $Res Function(_$SentenceGeneratorErrorImpl) then) =
      __$$SentenceGeneratorErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SentenceGeneratorErrorImplCopyWithImpl<$Res>
    extends _$SentenceGeneratorStateCopyWithImpl<$Res,
        _$SentenceGeneratorErrorImpl>
    implements _$$SentenceGeneratorErrorImplCopyWith<$Res> {
  __$$SentenceGeneratorErrorImplCopyWithImpl(
      _$SentenceGeneratorErrorImpl _value,
      $Res Function(_$SentenceGeneratorErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SentenceGeneratorErrorImpl implements SentenceGeneratorError {
  const _$SentenceGeneratorErrorImpl();

  @override
  String toString() {
    return 'SentenceGeneratorState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceGeneratorErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            String sentence, String translation, List<String> words)
        succeeded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String sentence, String translation, List<String> words)?
        succeeded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String sentence, String translation, List<String> words)?
        succeeded,
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
  const factory SentenceGeneratorError() = _$SentenceGeneratorErrorImpl;
}
