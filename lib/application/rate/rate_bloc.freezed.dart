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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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

  /// Create a copy of RateState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RateInitialImplCopyWith<$Res> {
  factory _$$RateInitialImplCopyWith(
          _$RateInitialImpl value, $Res Function(_$RateInitialImpl) then) =
      __$$RateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RateInitialImplCopyWithImpl<$Res>
    extends _$RateStateCopyWithImpl<$Res, _$RateInitialImpl>
    implements _$$RateInitialImplCopyWith<$Res> {
  __$$RateInitialImplCopyWithImpl(
      _$RateInitialImpl _value, $Res Function(_$RateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of RateState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RateInitialImpl implements RateInitial {
  const _$RateInitialImpl();

  @override
  String toString() {
    return 'RateState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RateInitialImpl);
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
  const factory RateInitial() = _$RateInitialImpl;
}

/// @nodoc
abstract class _$$RateLoadingImplCopyWith<$Res> {
  factory _$$RateLoadingImplCopyWith(
          _$RateLoadingImpl value, $Res Function(_$RateLoadingImpl) then) =
      __$$RateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RateLoadingImplCopyWithImpl<$Res>
    extends _$RateStateCopyWithImpl<$Res, _$RateLoadingImpl>
    implements _$$RateLoadingImplCopyWith<$Res> {
  __$$RateLoadingImplCopyWithImpl(
      _$RateLoadingImpl _value, $Res Function(_$RateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RateState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RateLoadingImpl implements RateLoading {
  const _$RateLoadingImpl();

  @override
  String toString() {
    return 'RateState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RateLoadingImpl);
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
  const factory RateLoading() = _$RateLoadingImpl;
}

/// @nodoc
abstract class _$$RateSucceededImplCopyWith<$Res> {
  factory _$$RateSucceededImplCopyWith(
          _$RateSucceededImpl value, $Res Function(_$RateSucceededImpl) then) =
      __$$RateSucceededImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double rating});
}

/// @nodoc
class __$$RateSucceededImplCopyWithImpl<$Res>
    extends _$RateStateCopyWithImpl<$Res, _$RateSucceededImpl>
    implements _$$RateSucceededImplCopyWith<$Res> {
  __$$RateSucceededImplCopyWithImpl(
      _$RateSucceededImpl _value, $Res Function(_$RateSucceededImpl) _then)
      : super(_value, _then);

  /// Create a copy of RateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
  }) {
    return _then(_$RateSucceededImpl(
      null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$RateSucceededImpl implements RateSucceeded {
  const _$RateSucceededImpl(this.rating);

  @override
  final double rating;

  @override
  String toString() {
    return 'RateState.succeeded(rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateSucceededImpl &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rating);

  /// Create a copy of RateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RateSucceededImplCopyWith<_$RateSucceededImpl> get copyWith =>
      __$$RateSucceededImplCopyWithImpl<_$RateSucceededImpl>(this, _$identity);

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
  const factory RateSucceeded(final double rating) = _$RateSucceededImpl;

  double get rating;

  /// Create a copy of RateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RateSucceededImplCopyWith<_$RateSucceededImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RateErrorImplCopyWith<$Res> {
  factory _$$RateErrorImplCopyWith(
          _$RateErrorImpl value, $Res Function(_$RateErrorImpl) then) =
      __$$RateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$RateErrorImplCopyWithImpl<$Res>
    extends _$RateStateCopyWithImpl<$Res, _$RateErrorImpl>
    implements _$$RateErrorImplCopyWith<$Res> {
  __$$RateErrorImplCopyWithImpl(
      _$RateErrorImpl _value, $Res Function(_$RateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of RateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$RateErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RateErrorImpl implements RateError {
  const _$RateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'RateState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of RateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RateErrorImplCopyWith<_$RateErrorImpl> get copyWith =>
      __$$RateErrorImplCopyWithImpl<_$RateErrorImpl>(this, _$identity);

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
  const factory RateError(final String message) = _$RateErrorImpl;

  String get message;

  /// Create a copy of RateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RateErrorImplCopyWith<_$RateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
