// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'example_data_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ExampleDataState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? initial,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExampleDataLoaded value) loaded,
    required TResult Function(ExampleDataInitial value) initial,
    required TResult Function(ExampleDataError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExampleDataLoaded value)? loaded,
    TResult? Function(ExampleDataInitial value)? initial,
    TResult? Function(ExampleDataError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExampleDataLoaded value)? loaded,
    TResult Function(ExampleDataInitial value)? initial,
    TResult Function(ExampleDataError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExampleDataStateCopyWith<$Res> {
  factory $ExampleDataStateCopyWith(
          ExampleDataState value, $Res Function(ExampleDataState) then) =
      _$ExampleDataStateCopyWithImpl<$Res, ExampleDataState>;
}

/// @nodoc
class _$ExampleDataStateCopyWithImpl<$Res, $Val extends ExampleDataState>
    implements $ExampleDataStateCopyWith<$Res> {
  _$ExampleDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ExampleDataLoadedImplCopyWith<$Res> {
  factory _$$ExampleDataLoadedImplCopyWith(_$ExampleDataLoadedImpl value,
          $Res Function(_$ExampleDataLoadedImpl) then) =
      __$$ExampleDataLoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExampleDataLoadedImplCopyWithImpl<$Res>
    extends _$ExampleDataStateCopyWithImpl<$Res, _$ExampleDataLoadedImpl>
    implements _$$ExampleDataLoadedImplCopyWith<$Res> {
  __$$ExampleDataLoadedImplCopyWithImpl(_$ExampleDataLoadedImpl _value,
      $Res Function(_$ExampleDataLoadedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ExampleDataLoadedImpl implements ExampleDataLoaded {
  const _$ExampleDataLoadedImpl();

  @override
  String toString() {
    return 'ExampleDataState.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExampleDataLoadedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? initial,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExampleDataLoaded value) loaded,
    required TResult Function(ExampleDataInitial value) initial,
    required TResult Function(ExampleDataError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExampleDataLoaded value)? loaded,
    TResult? Function(ExampleDataInitial value)? initial,
    TResult? Function(ExampleDataError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExampleDataLoaded value)? loaded,
    TResult Function(ExampleDataInitial value)? initial,
    TResult Function(ExampleDataError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ExampleDataLoaded implements ExampleDataState {
  const factory ExampleDataLoaded() = _$ExampleDataLoadedImpl;
}

/// @nodoc
abstract class _$$ExampleDataInitialImplCopyWith<$Res> {
  factory _$$ExampleDataInitialImplCopyWith(_$ExampleDataInitialImpl value,
          $Res Function(_$ExampleDataInitialImpl) then) =
      __$$ExampleDataInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExampleDataInitialImplCopyWithImpl<$Res>
    extends _$ExampleDataStateCopyWithImpl<$Res, _$ExampleDataInitialImpl>
    implements _$$ExampleDataInitialImplCopyWith<$Res> {
  __$$ExampleDataInitialImplCopyWithImpl(_$ExampleDataInitialImpl _value,
      $Res Function(_$ExampleDataInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ExampleDataInitialImpl implements ExampleDataInitial {
  const _$ExampleDataInitialImpl();

  @override
  String toString() {
    return 'ExampleDataState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExampleDataInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? initial,
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
    required TResult Function(ExampleDataLoaded value) loaded,
    required TResult Function(ExampleDataInitial value) initial,
    required TResult Function(ExampleDataError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExampleDataLoaded value)? loaded,
    TResult? Function(ExampleDataInitial value)? initial,
    TResult? Function(ExampleDataError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExampleDataLoaded value)? loaded,
    TResult Function(ExampleDataInitial value)? initial,
    TResult Function(ExampleDataError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ExampleDataInitial implements ExampleDataState {
  const factory ExampleDataInitial() = _$ExampleDataInitialImpl;
}

/// @nodoc
abstract class _$$ExampleDataErrorImplCopyWith<$Res> {
  factory _$$ExampleDataErrorImplCopyWith(_$ExampleDataErrorImpl value,
          $Res Function(_$ExampleDataErrorImpl) then) =
      __$$ExampleDataErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExampleDataErrorImplCopyWithImpl<$Res>
    extends _$ExampleDataStateCopyWithImpl<$Res, _$ExampleDataErrorImpl>
    implements _$$ExampleDataErrorImplCopyWith<$Res> {
  __$$ExampleDataErrorImplCopyWithImpl(_$ExampleDataErrorImpl _value,
      $Res Function(_$ExampleDataErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ExampleDataErrorImpl implements ExampleDataError {
  const _$ExampleDataErrorImpl();

  @override
  String toString() {
    return 'ExampleDataState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExampleDataErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loaded,
    TResult Function()? initial,
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
    required TResult Function(ExampleDataLoaded value) loaded,
    required TResult Function(ExampleDataInitial value) initial,
    required TResult Function(ExampleDataError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExampleDataLoaded value)? loaded,
    TResult? Function(ExampleDataInitial value)? initial,
    TResult? Function(ExampleDataError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExampleDataLoaded value)? loaded,
    TResult Function(ExampleDataInitial value)? initial,
    TResult Function(ExampleDataError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ExampleDataError implements ExampleDataState {
  const factory ExampleDataError() = _$ExampleDataErrorImpl;
}
