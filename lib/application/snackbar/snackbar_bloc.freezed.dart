// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snackbar_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SnackbarState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) show,
    required TResult Function() hide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? show,
    TResult? Function()? hide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? show,
    TResult Function()? hide,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SnackbarShown value) show,
    required TResult Function(SnackbarHidden value) hide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SnackbarShown value)? show,
    TResult? Function(SnackbarHidden value)? hide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SnackbarShown value)? show,
    TResult Function(SnackbarHidden value)? hide,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnackbarStateCopyWith<$Res> {
  factory $SnackbarStateCopyWith(
          SnackbarState value, $Res Function(SnackbarState) then) =
      _$SnackbarStateCopyWithImpl<$Res, SnackbarState>;
}

/// @nodoc
class _$SnackbarStateCopyWithImpl<$Res, $Val extends SnackbarState>
    implements $SnackbarStateCopyWith<$Res> {
  _$SnackbarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnackbarState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SnackbarShownImplCopyWith<$Res> {
  factory _$$SnackbarShownImplCopyWith(
          _$SnackbarShownImpl value, $Res Function(_$SnackbarShownImpl) then) =
      __$$SnackbarShownImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SnackbarShownImplCopyWithImpl<$Res>
    extends _$SnackbarStateCopyWithImpl<$Res, _$SnackbarShownImpl>
    implements _$$SnackbarShownImplCopyWith<$Res> {
  __$$SnackbarShownImplCopyWithImpl(
      _$SnackbarShownImpl _value, $Res Function(_$SnackbarShownImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnackbarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SnackbarShownImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SnackbarShownImpl implements SnackbarShown {
  const _$SnackbarShownImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SnackbarState.show(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnackbarShownImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SnackbarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnackbarShownImplCopyWith<_$SnackbarShownImpl> get copyWith =>
      __$$SnackbarShownImplCopyWithImpl<_$SnackbarShownImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) show,
    required TResult Function() hide,
  }) {
    return show(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? show,
    TResult? Function()? hide,
  }) {
    return show?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? show,
    TResult Function()? hide,
    required TResult orElse(),
  }) {
    if (show != null) {
      return show(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SnackbarShown value) show,
    required TResult Function(SnackbarHidden value) hide,
  }) {
    return show(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SnackbarShown value)? show,
    TResult? Function(SnackbarHidden value)? hide,
  }) {
    return show?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SnackbarShown value)? show,
    TResult Function(SnackbarHidden value)? hide,
    required TResult orElse(),
  }) {
    if (show != null) {
      return show(this);
    }
    return orElse();
  }
}

abstract class SnackbarShown implements SnackbarState {
  const factory SnackbarShown(final String message) = _$SnackbarShownImpl;

  String get message;

  /// Create a copy of SnackbarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnackbarShownImplCopyWith<_$SnackbarShownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SnackbarHiddenImplCopyWith<$Res> {
  factory _$$SnackbarHiddenImplCopyWith(_$SnackbarHiddenImpl value,
          $Res Function(_$SnackbarHiddenImpl) then) =
      __$$SnackbarHiddenImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SnackbarHiddenImplCopyWithImpl<$Res>
    extends _$SnackbarStateCopyWithImpl<$Res, _$SnackbarHiddenImpl>
    implements _$$SnackbarHiddenImplCopyWith<$Res> {
  __$$SnackbarHiddenImplCopyWithImpl(
      _$SnackbarHiddenImpl _value, $Res Function(_$SnackbarHiddenImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnackbarState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SnackbarHiddenImpl implements SnackbarHidden {
  const _$SnackbarHiddenImpl();

  @override
  String toString() {
    return 'SnackbarState.hide()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SnackbarHiddenImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) show,
    required TResult Function() hide,
  }) {
    return hide();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? show,
    TResult? Function()? hide,
  }) {
    return hide?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? show,
    TResult Function()? hide,
    required TResult orElse(),
  }) {
    if (hide != null) {
      return hide();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SnackbarShown value) show,
    required TResult Function(SnackbarHidden value) hide,
  }) {
    return hide(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SnackbarShown value)? show,
    TResult? Function(SnackbarHidden value)? hide,
  }) {
    return hide?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SnackbarShown value)? show,
    TResult Function(SnackbarHidden value)? hide,
    required TResult orElse(),
  }) {
    if (hide != null) {
      return hide(this);
    }
    return orElse();
  }
}

abstract class SnackbarHidden implements SnackbarState {
  const factory SnackbarHidden() = _$SnackbarHiddenImpl;
}
