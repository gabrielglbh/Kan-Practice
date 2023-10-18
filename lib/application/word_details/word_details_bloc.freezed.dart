// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WordDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() removed,
    required TResult Function(Word word) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? removed,
    TResult? Function(Word word)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? removed,
    TResult Function(Word word)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WordDetailsError value) error,
    required TResult Function(WordDetailsInitial value) initial,
    required TResult Function(WordDetailsLoading value) loading,
    required TResult Function(WordDetailsRemoved value) removed,
    required TResult Function(WordDetailsLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WordDetailsError value)? error,
    TResult? Function(WordDetailsInitial value)? initial,
    TResult? Function(WordDetailsLoading value)? loading,
    TResult? Function(WordDetailsRemoved value)? removed,
    TResult? Function(WordDetailsLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WordDetailsError value)? error,
    TResult Function(WordDetailsInitial value)? initial,
    TResult Function(WordDetailsLoading value)? loading,
    TResult Function(WordDetailsRemoved value)? removed,
    TResult Function(WordDetailsLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordDetailsStateCopyWith<$Res> {
  factory $WordDetailsStateCopyWith(
          WordDetailsState value, $Res Function(WordDetailsState) then) =
      _$WordDetailsStateCopyWithImpl<$Res, WordDetailsState>;
}

/// @nodoc
class _$WordDetailsStateCopyWithImpl<$Res, $Val extends WordDetailsState>
    implements $WordDetailsStateCopyWith<$Res> {
  _$WordDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$WordDetailsErrorImplCopyWith<$Res> {
  factory _$$WordDetailsErrorImplCopyWith(_$WordDetailsErrorImpl value,
          $Res Function(_$WordDetailsErrorImpl) then) =
      __$$WordDetailsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$WordDetailsErrorImplCopyWithImpl<$Res>
    extends _$WordDetailsStateCopyWithImpl<$Res, _$WordDetailsErrorImpl>
    implements _$$WordDetailsErrorImplCopyWith<$Res> {
  __$$WordDetailsErrorImplCopyWithImpl(_$WordDetailsErrorImpl _value,
      $Res Function(_$WordDetailsErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$WordDetailsErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WordDetailsErrorImpl implements WordDetailsError {
  const _$WordDetailsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'WordDetailsState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordDetailsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WordDetailsErrorImplCopyWith<_$WordDetailsErrorImpl> get copyWith =>
      __$$WordDetailsErrorImplCopyWithImpl<_$WordDetailsErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() removed,
    required TResult Function(Word word) loaded,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? removed,
    TResult? Function(Word word)? loaded,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? removed,
    TResult Function(Word word)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WordDetailsError value) error,
    required TResult Function(WordDetailsInitial value) initial,
    required TResult Function(WordDetailsLoading value) loading,
    required TResult Function(WordDetailsRemoved value) removed,
    required TResult Function(WordDetailsLoaded value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WordDetailsError value)? error,
    TResult? Function(WordDetailsInitial value)? initial,
    TResult? Function(WordDetailsLoading value)? loading,
    TResult? Function(WordDetailsRemoved value)? removed,
    TResult? Function(WordDetailsLoaded value)? loaded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WordDetailsError value)? error,
    TResult Function(WordDetailsInitial value)? initial,
    TResult Function(WordDetailsLoading value)? loading,
    TResult Function(WordDetailsRemoved value)? removed,
    TResult Function(WordDetailsLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class WordDetailsError implements WordDetailsState {
  const factory WordDetailsError(final String message) = _$WordDetailsErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$WordDetailsErrorImplCopyWith<_$WordDetailsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WordDetailsInitialImplCopyWith<$Res> {
  factory _$$WordDetailsInitialImplCopyWith(_$WordDetailsInitialImpl value,
          $Res Function(_$WordDetailsInitialImpl) then) =
      __$$WordDetailsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WordDetailsInitialImplCopyWithImpl<$Res>
    extends _$WordDetailsStateCopyWithImpl<$Res, _$WordDetailsInitialImpl>
    implements _$$WordDetailsInitialImplCopyWith<$Res> {
  __$$WordDetailsInitialImplCopyWithImpl(_$WordDetailsInitialImpl _value,
      $Res Function(_$WordDetailsInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WordDetailsInitialImpl implements WordDetailsInitial {
  const _$WordDetailsInitialImpl();

  @override
  String toString() {
    return 'WordDetailsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WordDetailsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() removed,
    required TResult Function(Word word) loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? removed,
    TResult? Function(Word word)? loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? removed,
    TResult Function(Word word)? loaded,
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
    required TResult Function(WordDetailsError value) error,
    required TResult Function(WordDetailsInitial value) initial,
    required TResult Function(WordDetailsLoading value) loading,
    required TResult Function(WordDetailsRemoved value) removed,
    required TResult Function(WordDetailsLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WordDetailsError value)? error,
    TResult? Function(WordDetailsInitial value)? initial,
    TResult? Function(WordDetailsLoading value)? loading,
    TResult? Function(WordDetailsRemoved value)? removed,
    TResult? Function(WordDetailsLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WordDetailsError value)? error,
    TResult Function(WordDetailsInitial value)? initial,
    TResult Function(WordDetailsLoading value)? loading,
    TResult Function(WordDetailsRemoved value)? removed,
    TResult Function(WordDetailsLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class WordDetailsInitial implements WordDetailsState {
  const factory WordDetailsInitial() = _$WordDetailsInitialImpl;
}

/// @nodoc
abstract class _$$WordDetailsLoadingImplCopyWith<$Res> {
  factory _$$WordDetailsLoadingImplCopyWith(_$WordDetailsLoadingImpl value,
          $Res Function(_$WordDetailsLoadingImpl) then) =
      __$$WordDetailsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WordDetailsLoadingImplCopyWithImpl<$Res>
    extends _$WordDetailsStateCopyWithImpl<$Res, _$WordDetailsLoadingImpl>
    implements _$$WordDetailsLoadingImplCopyWith<$Res> {
  __$$WordDetailsLoadingImplCopyWithImpl(_$WordDetailsLoadingImpl _value,
      $Res Function(_$WordDetailsLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WordDetailsLoadingImpl implements WordDetailsLoading {
  const _$WordDetailsLoadingImpl();

  @override
  String toString() {
    return 'WordDetailsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WordDetailsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() removed,
    required TResult Function(Word word) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? removed,
    TResult? Function(Word word)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? removed,
    TResult Function(Word word)? loaded,
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
    required TResult Function(WordDetailsError value) error,
    required TResult Function(WordDetailsInitial value) initial,
    required TResult Function(WordDetailsLoading value) loading,
    required TResult Function(WordDetailsRemoved value) removed,
    required TResult Function(WordDetailsLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WordDetailsError value)? error,
    TResult? Function(WordDetailsInitial value)? initial,
    TResult? Function(WordDetailsLoading value)? loading,
    TResult? Function(WordDetailsRemoved value)? removed,
    TResult? Function(WordDetailsLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WordDetailsError value)? error,
    TResult Function(WordDetailsInitial value)? initial,
    TResult Function(WordDetailsLoading value)? loading,
    TResult Function(WordDetailsRemoved value)? removed,
    TResult Function(WordDetailsLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class WordDetailsLoading implements WordDetailsState {
  const factory WordDetailsLoading() = _$WordDetailsLoadingImpl;
}

/// @nodoc
abstract class _$$WordDetailsRemovedImplCopyWith<$Res> {
  factory _$$WordDetailsRemovedImplCopyWith(_$WordDetailsRemovedImpl value,
          $Res Function(_$WordDetailsRemovedImpl) then) =
      __$$WordDetailsRemovedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WordDetailsRemovedImplCopyWithImpl<$Res>
    extends _$WordDetailsStateCopyWithImpl<$Res, _$WordDetailsRemovedImpl>
    implements _$$WordDetailsRemovedImplCopyWith<$Res> {
  __$$WordDetailsRemovedImplCopyWithImpl(_$WordDetailsRemovedImpl _value,
      $Res Function(_$WordDetailsRemovedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WordDetailsRemovedImpl implements WordDetailsRemoved {
  const _$WordDetailsRemovedImpl();

  @override
  String toString() {
    return 'WordDetailsState.removed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WordDetailsRemovedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() removed,
    required TResult Function(Word word) loaded,
  }) {
    return removed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? removed,
    TResult? Function(Word word)? loaded,
  }) {
    return removed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? removed,
    TResult Function(Word word)? loaded,
    required TResult orElse(),
  }) {
    if (removed != null) {
      return removed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WordDetailsError value) error,
    required TResult Function(WordDetailsInitial value) initial,
    required TResult Function(WordDetailsLoading value) loading,
    required TResult Function(WordDetailsRemoved value) removed,
    required TResult Function(WordDetailsLoaded value) loaded,
  }) {
    return removed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WordDetailsError value)? error,
    TResult? Function(WordDetailsInitial value)? initial,
    TResult? Function(WordDetailsLoading value)? loading,
    TResult? Function(WordDetailsRemoved value)? removed,
    TResult? Function(WordDetailsLoaded value)? loaded,
  }) {
    return removed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WordDetailsError value)? error,
    TResult Function(WordDetailsInitial value)? initial,
    TResult Function(WordDetailsLoading value)? loading,
    TResult Function(WordDetailsRemoved value)? removed,
    TResult Function(WordDetailsLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (removed != null) {
      return removed(this);
    }
    return orElse();
  }
}

abstract class WordDetailsRemoved implements WordDetailsState {
  const factory WordDetailsRemoved() = _$WordDetailsRemovedImpl;
}

/// @nodoc
abstract class _$$WordDetailsLoadedImplCopyWith<$Res> {
  factory _$$WordDetailsLoadedImplCopyWith(_$WordDetailsLoadedImpl value,
          $Res Function(_$WordDetailsLoadedImpl) then) =
      __$$WordDetailsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Word word});
}

/// @nodoc
class __$$WordDetailsLoadedImplCopyWithImpl<$Res>
    extends _$WordDetailsStateCopyWithImpl<$Res, _$WordDetailsLoadedImpl>
    implements _$$WordDetailsLoadedImplCopyWith<$Res> {
  __$$WordDetailsLoadedImplCopyWithImpl(_$WordDetailsLoadedImpl _value,
      $Res Function(_$WordDetailsLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
  }) {
    return _then(_$WordDetailsLoadedImpl(
      null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as Word,
    ));
  }
}

/// @nodoc

class _$WordDetailsLoadedImpl implements WordDetailsLoaded {
  const _$WordDetailsLoadedImpl(this.word);

  @override
  final Word word;

  @override
  String toString() {
    return 'WordDetailsState.loaded(word: $word)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordDetailsLoadedImpl &&
            (identical(other.word, word) || other.word == word));
  }

  @override
  int get hashCode => Object.hash(runtimeType, word);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WordDetailsLoadedImplCopyWith<_$WordDetailsLoadedImpl> get copyWith =>
      __$$WordDetailsLoadedImplCopyWithImpl<_$WordDetailsLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() removed,
    required TResult Function(Word word) loaded,
  }) {
    return loaded(word);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? removed,
    TResult? Function(Word word)? loaded,
  }) {
    return loaded?.call(word);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? removed,
    TResult Function(Word word)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(word);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WordDetailsError value) error,
    required TResult Function(WordDetailsInitial value) initial,
    required TResult Function(WordDetailsLoading value) loading,
    required TResult Function(WordDetailsRemoved value) removed,
    required TResult Function(WordDetailsLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WordDetailsError value)? error,
    TResult? Function(WordDetailsInitial value)? initial,
    TResult? Function(WordDetailsLoading value)? loading,
    TResult? Function(WordDetailsRemoved value)? removed,
    TResult? Function(WordDetailsLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WordDetailsError value)? error,
    TResult Function(WordDetailsInitial value)? initial,
    TResult Function(WordDetailsLoading value)? loading,
    TResult Function(WordDetailsRemoved value)? removed,
    TResult Function(WordDetailsLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class WordDetailsLoaded implements WordDetailsState {
  const factory WordDetailsLoaded(final Word word) = _$WordDetailsLoadedImpl;

  Word get word;
  @JsonKey(ignore: true)
  _$$WordDetailsLoadedImplCopyWith<_$WordDetailsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
