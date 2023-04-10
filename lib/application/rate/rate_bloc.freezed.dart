// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rate_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RateState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(double rating) succeeded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(double rating)? succeeded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(double rating)? succeeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RateInitial value) initial,
    required TResult Function(RateLoading value) loading,
    required TResult Function(RateSucceeded value) succeeded,
    required TResult Function(RateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RateInitial value)? initial,
    TResult? Function(RateLoading value)? loading,
    TResult? Function(RateSucceeded value)? succeeded,
    TResult? Function(RateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RateInitial value)? initial,
    TResult Function(RateLoading value)? loading,
    TResult Function(RateSucceeded value)? succeeded,
    TResult Function(RateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RateStateCopyWith<$Res> {
  factory $RateStateCopyWith(RateState value, $Res Function(RateState) then) =
      _$RateStateCopyWithImpl<$Res, RateState>;
}

/// @nodoc
class _$RateStateCopyWithImpl<$Res, $Val extends RateState>
    implements $RateStateCopyWith<$Res> {
  _$RateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RateInitialCopyWith<$Res> {
  factory _$$RateInitialCopyWith(
          _$RateInitial value, $Res Function(_$RateInitial) then) =
      __$$RateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RateInitialCopyWithImpl<$Res>
    extends _$RateStateCopyWithImpl<$Res, _$RateInitial>
    implements _$$RateInitialCopyWith<$Res> {
  __$$RateInitialCopyWithImpl(
      _$RateInitial _value, $Res Function(_$RateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RateInitial implements RateInitial {
  const _$RateInitial();

  @override
  String toString() {
    return 'RateState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(double rating) succeeded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(double rating)? succeeded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(double rating)? succeeded,
    TResult Function(String message)? error,
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
    required TResult Function(RateInitial value) initial,
    required TResult Function(RateLoading value) loading,
    required TResult Function(RateSucceeded value) succeeded,
    required TResult Function(RateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RateInitial value)? initial,
    TResult? Function(RateLoading value)? loading,
    TResult? Function(RateSucceeded value)? succeeded,
    TResult? Function(RateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RateInitial value)? initial,
    TResult Function(RateLoading value)? loading,
    TResult Function(RateSucceeded value)? succeeded,
    TResult Function(RateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class RateInitial implements RateState {
  const factory RateInitial() = _$RateInitial;
}

/// @nodoc
abstract class _$$RateLoadingCopyWith<$Res> {
  factory _$$RateLoadingCopyWith(
          _$RateLoading value, $Res Function(_$RateLoading) then) =
      __$$RateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RateLoadingCopyWithImpl<$Res>
    extends _$RateStateCopyWithImpl<$Res, _$RateLoading>
    implements _$$RateLoadingCopyWith<$Res> {
  __$$RateLoadingCopyWithImpl(
      _$RateLoading _value, $Res Function(_$RateLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RateLoading implements RateLoading {
  const _$RateLoading();

  @override
  String toString() {
    return 'RateState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(double rating) succeeded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(double rating)? succeeded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(double rating)? succeeded,
    TResult Function(String message)? error,
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
    required TResult Function(RateInitial value) initial,
    required TResult Function(RateLoading value) loading,
    required TResult Function(RateSucceeded value) succeeded,
    required TResult Function(RateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RateInitial value)? initial,
    TResult? Function(RateLoading value)? loading,
    TResult? Function(RateSucceeded value)? succeeded,
    TResult? Function(RateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RateInitial value)? initial,
    TResult Function(RateLoading value)? loading,
    TResult Function(RateSucceeded value)? succeeded,
    TResult Function(RateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RateLoading implements RateState {
  const factory RateLoading() = _$RateLoading;
}

/// @nodoc
abstract class _$$RateSucceededCopyWith<$Res> {
  factory _$$RateSucceededCopyWith(
          _$RateSucceeded value, $Res Function(_$RateSucceeded) then) =
      __$$RateSucceededCopyWithImpl<$Res>;
  @useResult
  $Res call({double rating});
}

/// @nodoc
class __$$RateSucceededCopyWithImpl<$Res>
    extends _$RateStateCopyWithImpl<$Res, _$RateSucceeded>
    implements _$$RateSucceededCopyWith<$Res> {
  __$$RateSucceededCopyWithImpl(
      _$RateSucceeded _value, $Res Function(_$RateSucceeded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
  }) {
    return _then(_$RateSucceeded(
      null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$RateSucceeded implements RateSucceeded {
  const _$RateSucceeded(this.rating);

  @override
  final double rating;

  @override
  String toString() {
    return 'RateState.succeeded(rating: $rating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateSucceeded &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RateSucceededCopyWith<_$RateSucceeded> get copyWith =>
      __$$RateSucceededCopyWithImpl<_$RateSucceeded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(double rating) succeeded,
    required TResult Function(String message) error,
  }) {
    return succeeded(rating);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(double rating)? succeeded,
    TResult? Function(String message)? error,
  }) {
    return succeeded?.call(rating);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(double rating)? succeeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (succeeded != null) {
      return succeeded(rating);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RateInitial value) initial,
    required TResult Function(RateLoading value) loading,
    required TResult Function(RateSucceeded value) succeeded,
    required TResult Function(RateError value) error,
  }) {
    return succeeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RateInitial value)? initial,
    TResult? Function(RateLoading value)? loading,
    TResult? Function(RateSucceeded value)? succeeded,
    TResult? Function(RateError value)? error,
  }) {
    return succeeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RateInitial value)? initial,
    TResult Function(RateLoading value)? loading,
    TResult Function(RateSucceeded value)? succeeded,
    TResult Function(RateError value)? error,
    required TResult orElse(),
  }) {
    if (succeeded != null) {
      return succeeded(this);
    }
    return orElse();
  }
}

abstract class RateSucceeded implements RateState {
  const factory RateSucceeded(final double rating) = _$RateSucceeded;

  double get rating;
  @JsonKey(ignore: true)
  _$$RateSucceededCopyWith<_$RateSucceeded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RateErrorCopyWith<$Res> {
  factory _$$RateErrorCopyWith(
          _$RateError value, $Res Function(_$RateError) then) =
      __$$RateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$RateErrorCopyWithImpl<$Res>
    extends _$RateStateCopyWithImpl<$Res, _$RateError>
    implements _$$RateErrorCopyWith<$Res> {
  __$$RateErrorCopyWithImpl(
      _$RateError _value, $Res Function(_$RateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$RateError(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RateError implements RateError {
  const _$RateError(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'RateState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RateErrorCopyWith<_$RateError> get copyWith =>
      __$$RateErrorCopyWithImpl<_$RateError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(double rating) succeeded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(double rating)? succeeded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(double rating)? succeeded,
    TResult Function(String message)? error,
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
    required TResult Function(RateInitial value) initial,
    required TResult Function(RateLoading value) loading,
    required TResult Function(RateSucceeded value) succeeded,
    required TResult Function(RateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RateInitial value)? initial,
    TResult? Function(RateLoading value)? loading,
    TResult? Function(RateSucceeded value)? succeeded,
    TResult? Function(RateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RateInitial value)? initial,
    TResult Function(RateLoading value)? loading,
    TResult Function(RateSucceeded value)? succeeded,
    TResult Function(RateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class RateError implements RateState {
  const factory RateError(final String message) = _$RateError;

  String get message;
  @JsonKey(ignore: true)
  _$$RateErrorCopyWith<_$RateError> get copyWith =>
      throw _privateConstructorUsedError;
}
