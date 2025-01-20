// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission_handler_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PermissionHandlerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ImageSource source) succeeded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ImageSource source)? succeeded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ImageSource source)? succeeded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PermissionHandlerInitial value) initial,
    required TResult Function(PermissionHandlerSucceeded value) succeeded,
    required TResult Function(PermissionHandlerError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermissionHandlerInitial value)? initial,
    TResult? Function(PermissionHandlerSucceeded value)? succeeded,
    TResult? Function(PermissionHandlerError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermissionHandlerInitial value)? initial,
    TResult Function(PermissionHandlerSucceeded value)? succeeded,
    TResult Function(PermissionHandlerError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionHandlerStateCopyWith<$Res> {
  factory $PermissionHandlerStateCopyWith(PermissionHandlerState value,
          $Res Function(PermissionHandlerState) then) =
      _$PermissionHandlerStateCopyWithImpl<$Res, PermissionHandlerState>;
}

/// @nodoc
class _$PermissionHandlerStateCopyWithImpl<$Res,
        $Val extends PermissionHandlerState>
    implements $PermissionHandlerStateCopyWith<$Res> {
  _$PermissionHandlerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PermissionHandlerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PermissionHandlerInitialImplCopyWith<$Res> {
  factory _$$PermissionHandlerInitialImplCopyWith(
          _$PermissionHandlerInitialImpl value,
          $Res Function(_$PermissionHandlerInitialImpl) then) =
      __$$PermissionHandlerInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PermissionHandlerInitialImplCopyWithImpl<$Res>
    extends _$PermissionHandlerStateCopyWithImpl<$Res,
        _$PermissionHandlerInitialImpl>
    implements _$$PermissionHandlerInitialImplCopyWith<$Res> {
  __$$PermissionHandlerInitialImplCopyWithImpl(
      _$PermissionHandlerInitialImpl _value,
      $Res Function(_$PermissionHandlerInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PermissionHandlerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PermissionHandlerInitialImpl implements PermissionHandlerInitial {
  const _$PermissionHandlerInitialImpl();

  @override
  String toString() {
    return 'PermissionHandlerState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionHandlerInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ImageSource source) succeeded,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ImageSource source)? succeeded,
    TResult? Function()? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ImageSource source)? succeeded,
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
    required TResult Function(PermissionHandlerInitial value) initial,
    required TResult Function(PermissionHandlerSucceeded value) succeeded,
    required TResult Function(PermissionHandlerError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermissionHandlerInitial value)? initial,
    TResult? Function(PermissionHandlerSucceeded value)? succeeded,
    TResult? Function(PermissionHandlerError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermissionHandlerInitial value)? initial,
    TResult Function(PermissionHandlerSucceeded value)? succeeded,
    TResult Function(PermissionHandlerError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PermissionHandlerInitial implements PermissionHandlerState {
  const factory PermissionHandlerInitial() = _$PermissionHandlerInitialImpl;
}

/// @nodoc
abstract class _$$PermissionHandlerSucceededImplCopyWith<$Res> {
  factory _$$PermissionHandlerSucceededImplCopyWith(
          _$PermissionHandlerSucceededImpl value,
          $Res Function(_$PermissionHandlerSucceededImpl) then) =
      __$$PermissionHandlerSucceededImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ImageSource source});
}

/// @nodoc
class __$$PermissionHandlerSucceededImplCopyWithImpl<$Res>
    extends _$PermissionHandlerStateCopyWithImpl<$Res,
        _$PermissionHandlerSucceededImpl>
    implements _$$PermissionHandlerSucceededImplCopyWith<$Res> {
  __$$PermissionHandlerSucceededImplCopyWithImpl(
      _$PermissionHandlerSucceededImpl _value,
      $Res Function(_$PermissionHandlerSucceededImpl) _then)
      : super(_value, _then);

  /// Create a copy of PermissionHandlerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
  }) {
    return _then(_$PermissionHandlerSucceededImpl(
      null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as ImageSource,
    ));
  }
}

/// @nodoc

class _$PermissionHandlerSucceededImpl implements PermissionHandlerSucceeded {
  const _$PermissionHandlerSucceededImpl(this.source);

  @override
  final ImageSource source;

  @override
  String toString() {
    return 'PermissionHandlerState.succeeded(source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionHandlerSucceededImpl &&
            (identical(other.source, source) || other.source == source));
  }

  @override
  int get hashCode => Object.hash(runtimeType, source);

  /// Create a copy of PermissionHandlerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionHandlerSucceededImplCopyWith<_$PermissionHandlerSucceededImpl>
      get copyWith => __$$PermissionHandlerSucceededImplCopyWithImpl<
          _$PermissionHandlerSucceededImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ImageSource source) succeeded,
    required TResult Function() error,
  }) {
    return succeeded(source);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ImageSource source)? succeeded,
    TResult? Function()? error,
  }) {
    return succeeded?.call(source);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ImageSource source)? succeeded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (succeeded != null) {
      return succeeded(source);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PermissionHandlerInitial value) initial,
    required TResult Function(PermissionHandlerSucceeded value) succeeded,
    required TResult Function(PermissionHandlerError value) error,
  }) {
    return succeeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermissionHandlerInitial value)? initial,
    TResult? Function(PermissionHandlerSucceeded value)? succeeded,
    TResult? Function(PermissionHandlerError value)? error,
  }) {
    return succeeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermissionHandlerInitial value)? initial,
    TResult Function(PermissionHandlerSucceeded value)? succeeded,
    TResult Function(PermissionHandlerError value)? error,
    required TResult orElse(),
  }) {
    if (succeeded != null) {
      return succeeded(this);
    }
    return orElse();
  }
}

abstract class PermissionHandlerSucceeded implements PermissionHandlerState {
  const factory PermissionHandlerSucceeded(final ImageSource source) =
      _$PermissionHandlerSucceededImpl;

  ImageSource get source;

  /// Create a copy of PermissionHandlerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionHandlerSucceededImplCopyWith<_$PermissionHandlerSucceededImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PermissionHandlerErrorImplCopyWith<$Res> {
  factory _$$PermissionHandlerErrorImplCopyWith(
          _$PermissionHandlerErrorImpl value,
          $Res Function(_$PermissionHandlerErrorImpl) then) =
      __$$PermissionHandlerErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PermissionHandlerErrorImplCopyWithImpl<$Res>
    extends _$PermissionHandlerStateCopyWithImpl<$Res,
        _$PermissionHandlerErrorImpl>
    implements _$$PermissionHandlerErrorImplCopyWith<$Res> {
  __$$PermissionHandlerErrorImplCopyWithImpl(
      _$PermissionHandlerErrorImpl _value,
      $Res Function(_$PermissionHandlerErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PermissionHandlerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PermissionHandlerErrorImpl implements PermissionHandlerError {
  const _$PermissionHandlerErrorImpl();

  @override
  String toString() {
    return 'PermissionHandlerState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionHandlerErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(ImageSource source) succeeded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(ImageSource source)? succeeded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(ImageSource source)? succeeded,
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
    required TResult Function(PermissionHandlerInitial value) initial,
    required TResult Function(PermissionHandlerSucceeded value) succeeded,
    required TResult Function(PermissionHandlerError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermissionHandlerInitial value)? initial,
    TResult? Function(PermissionHandlerSucceeded value)? succeeded,
    TResult? Function(PermissionHandlerError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermissionHandlerInitial value)? initial,
    TResult Function(PermissionHandlerSucceeded value)? succeeded,
    TResult Function(PermissionHandlerError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PermissionHandlerError implements PermissionHandlerState {
  const factory PermissionHandlerError() = _$PermissionHandlerErrorImpl;
}
