// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ListDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) loaded,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? loaded,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? loaded,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ListDetailsLoaded value) loaded,
    required TResult Function(ListDetailsInitial value) initial,
    required TResult Function(ListDetailsLoading value) loading,
    required TResult Function(ListDetailsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListDetailsLoaded value)? loaded,
    TResult? Function(ListDetailsInitial value)? initial,
    TResult? Function(ListDetailsLoading value)? loading,
    TResult? Function(ListDetailsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListDetailsLoaded value)? loaded,
    TResult Function(ListDetailsInitial value)? initial,
    TResult Function(ListDetailsLoading value)? loading,
    TResult Function(ListDetailsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListDetailsStateCopyWith<$Res> {
  factory $ListDetailsStateCopyWith(
          ListDetailsState value, $Res Function(ListDetailsState) then) =
      _$ListDetailsStateCopyWithImpl<$Res, ListDetailsState>;
}

/// @nodoc
class _$ListDetailsStateCopyWithImpl<$Res, $Val extends ListDetailsState>
    implements $ListDetailsStateCopyWith<$Res> {
  _$ListDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ListDetailsLoadedImplCopyWith<$Res> {
  factory _$$ListDetailsLoadedImplCopyWith(_$ListDetailsLoadedImpl value,
          $Res Function(_$ListDetailsLoadedImpl) then) =
      __$$ListDetailsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$ListDetailsLoadedImplCopyWithImpl<$Res>
    extends _$ListDetailsStateCopyWithImpl<$Res, _$ListDetailsLoadedImpl>
    implements _$$ListDetailsLoadedImplCopyWith<$Res> {
  __$$ListDetailsLoadedImplCopyWithImpl(_$ListDetailsLoadedImpl _value,
      $Res Function(_$ListDetailsLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$ListDetailsLoadedImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ListDetailsLoadedImpl implements ListDetailsLoaded {
  const _$ListDetailsLoadedImpl(this.name);

  @override
  final String name;

  @override
  String toString() {
    return 'ListDetailsState.loaded(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListDetailsLoadedImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListDetailsLoadedImplCopyWith<_$ListDetailsLoadedImpl> get copyWith =>
      __$$ListDetailsLoadedImplCopyWithImpl<_$ListDetailsLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) loaded,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return loaded(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? loaded,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return loaded?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? loaded,
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ListDetailsLoaded value) loaded,
    required TResult Function(ListDetailsInitial value) initial,
    required TResult Function(ListDetailsLoading value) loading,
    required TResult Function(ListDetailsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListDetailsLoaded value)? loaded,
    TResult? Function(ListDetailsInitial value)? initial,
    TResult? Function(ListDetailsLoading value)? loading,
    TResult? Function(ListDetailsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListDetailsLoaded value)? loaded,
    TResult Function(ListDetailsInitial value)? initial,
    TResult Function(ListDetailsLoading value)? loading,
    TResult Function(ListDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ListDetailsLoaded implements ListDetailsState {
  const factory ListDetailsLoaded(final String name) = _$ListDetailsLoadedImpl;

  String get name;
  @JsonKey(ignore: true)
  _$$ListDetailsLoadedImplCopyWith<_$ListDetailsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListDetailsInitialImplCopyWith<$Res> {
  factory _$$ListDetailsInitialImplCopyWith(_$ListDetailsInitialImpl value,
          $Res Function(_$ListDetailsInitialImpl) then) =
      __$$ListDetailsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListDetailsInitialImplCopyWithImpl<$Res>
    extends _$ListDetailsStateCopyWithImpl<$Res, _$ListDetailsInitialImpl>
    implements _$$ListDetailsInitialImplCopyWith<$Res> {
  __$$ListDetailsInitialImplCopyWithImpl(_$ListDetailsInitialImpl _value,
      $Res Function(_$ListDetailsInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListDetailsInitialImpl implements ListDetailsInitial {
  const _$ListDetailsInitialImpl();

  @override
  String toString() {
    return 'ListDetailsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListDetailsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) loaded,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? loaded,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? loaded,
    TResult Function()? initial,
    TResult Function()? loading,
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
    required TResult Function(ListDetailsLoaded value) loaded,
    required TResult Function(ListDetailsInitial value) initial,
    required TResult Function(ListDetailsLoading value) loading,
    required TResult Function(ListDetailsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListDetailsLoaded value)? loaded,
    TResult? Function(ListDetailsInitial value)? initial,
    TResult? Function(ListDetailsLoading value)? loading,
    TResult? Function(ListDetailsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListDetailsLoaded value)? loaded,
    TResult Function(ListDetailsInitial value)? initial,
    TResult Function(ListDetailsLoading value)? loading,
    TResult Function(ListDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ListDetailsInitial implements ListDetailsState {
  const factory ListDetailsInitial() = _$ListDetailsInitialImpl;
}

/// @nodoc
abstract class _$$ListDetailsLoadingImplCopyWith<$Res> {
  factory _$$ListDetailsLoadingImplCopyWith(_$ListDetailsLoadingImpl value,
          $Res Function(_$ListDetailsLoadingImpl) then) =
      __$$ListDetailsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListDetailsLoadingImplCopyWithImpl<$Res>
    extends _$ListDetailsStateCopyWithImpl<$Res, _$ListDetailsLoadingImpl>
    implements _$$ListDetailsLoadingImplCopyWith<$Res> {
  __$$ListDetailsLoadingImplCopyWithImpl(_$ListDetailsLoadingImpl _value,
      $Res Function(_$ListDetailsLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListDetailsLoadingImpl implements ListDetailsLoading {
  const _$ListDetailsLoadingImpl();

  @override
  String toString() {
    return 'ListDetailsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListDetailsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) loaded,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? loaded,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? loaded,
    TResult Function()? initial,
    TResult Function()? loading,
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
    required TResult Function(ListDetailsLoaded value) loaded,
    required TResult Function(ListDetailsInitial value) initial,
    required TResult Function(ListDetailsLoading value) loading,
    required TResult Function(ListDetailsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListDetailsLoaded value)? loaded,
    TResult? Function(ListDetailsInitial value)? initial,
    TResult? Function(ListDetailsLoading value)? loading,
    TResult? Function(ListDetailsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListDetailsLoaded value)? loaded,
    TResult Function(ListDetailsInitial value)? initial,
    TResult Function(ListDetailsLoading value)? loading,
    TResult Function(ListDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ListDetailsLoading implements ListDetailsState {
  const factory ListDetailsLoading() = _$ListDetailsLoadingImpl;
}

/// @nodoc
abstract class _$$ListDetailsErrorImplCopyWith<$Res> {
  factory _$$ListDetailsErrorImplCopyWith(_$ListDetailsErrorImpl value,
          $Res Function(_$ListDetailsErrorImpl) then) =
      __$$ListDetailsErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListDetailsErrorImplCopyWithImpl<$Res>
    extends _$ListDetailsStateCopyWithImpl<$Res, _$ListDetailsErrorImpl>
    implements _$$ListDetailsErrorImplCopyWith<$Res> {
  __$$ListDetailsErrorImplCopyWithImpl(_$ListDetailsErrorImpl _value,
      $Res Function(_$ListDetailsErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListDetailsErrorImpl implements ListDetailsError {
  const _$ListDetailsErrorImpl();

  @override
  String toString() {
    return 'ListDetailsState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListDetailsErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) loaded,
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? loaded,
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? loaded,
    TResult Function()? initial,
    TResult Function()? loading,
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
    required TResult Function(ListDetailsLoaded value) loaded,
    required TResult Function(ListDetailsInitial value) initial,
    required TResult Function(ListDetailsLoading value) loading,
    required TResult Function(ListDetailsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListDetailsLoaded value)? loaded,
    TResult? Function(ListDetailsInitial value)? initial,
    TResult? Function(ListDetailsLoading value)? loading,
    TResult? Function(ListDetailsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListDetailsLoaded value)? loaded,
    TResult Function(ListDetailsInitial value)? initial,
    TResult Function(ListDetailsLoading value)? loading,
    TResult Function(ListDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ListDetailsError implements ListDetailsState {
  const factory ListDetailsError() = _$ListDetailsErrorImpl;
}
