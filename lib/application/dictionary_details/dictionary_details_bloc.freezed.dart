// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dictionary_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DictionaryDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(WordData data) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(WordData data)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(WordData data)? loaded,
    TResult Function()? initial,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DictionaryDetailsLoading value) loading,
    required TResult Function(DictionaryDetailsLoaded value) loaded,
    required TResult Function(DictionaryDetailsInitial value) initial,
    required TResult Function(DictionaryDetailsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DictionaryDetailsLoading value)? loading,
    TResult? Function(DictionaryDetailsLoaded value)? loaded,
    TResult? Function(DictionaryDetailsInitial value)? initial,
    TResult? Function(DictionaryDetailsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DictionaryDetailsLoading value)? loading,
    TResult Function(DictionaryDetailsLoaded value)? loaded,
    TResult Function(DictionaryDetailsInitial value)? initial,
    TResult Function(DictionaryDetailsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DictionaryDetailsStateCopyWith<$Res> {
  factory $DictionaryDetailsStateCopyWith(DictionaryDetailsState value,
          $Res Function(DictionaryDetailsState) then) =
      _$DictionaryDetailsStateCopyWithImpl<$Res, DictionaryDetailsState>;
}

/// @nodoc
class _$DictionaryDetailsStateCopyWithImpl<$Res,
        $Val extends DictionaryDetailsState>
    implements $DictionaryDetailsStateCopyWith<$Res> {
  _$DictionaryDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$DictionaryDetailsLoadingImplCopyWith<$Res> {
  factory _$$DictionaryDetailsLoadingImplCopyWith(
          _$DictionaryDetailsLoadingImpl value,
          $Res Function(_$DictionaryDetailsLoadingImpl) then) =
      __$$DictionaryDetailsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryDetailsLoadingImplCopyWithImpl<$Res>
    extends _$DictionaryDetailsStateCopyWithImpl<$Res,
        _$DictionaryDetailsLoadingImpl>
    implements _$$DictionaryDetailsLoadingImplCopyWith<$Res> {
  __$$DictionaryDetailsLoadingImplCopyWithImpl(
      _$DictionaryDetailsLoadingImpl _value,
      $Res Function(_$DictionaryDetailsLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryDetailsLoadingImpl implements DictionaryDetailsLoading {
  const _$DictionaryDetailsLoadingImpl();

  @override
  String toString() {
    return 'DictionaryDetailsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictionaryDetailsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(WordData data) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(WordData data)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(WordData data)? loaded,
    TResult Function()? initial,
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
    required TResult Function(DictionaryDetailsLoading value) loading,
    required TResult Function(DictionaryDetailsLoaded value) loaded,
    required TResult Function(DictionaryDetailsInitial value) initial,
    required TResult Function(DictionaryDetailsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DictionaryDetailsLoading value)? loading,
    TResult? Function(DictionaryDetailsLoaded value)? loaded,
    TResult? Function(DictionaryDetailsInitial value)? initial,
    TResult? Function(DictionaryDetailsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DictionaryDetailsLoading value)? loading,
    TResult Function(DictionaryDetailsLoaded value)? loaded,
    TResult Function(DictionaryDetailsInitial value)? initial,
    TResult Function(DictionaryDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class DictionaryDetailsLoading implements DictionaryDetailsState {
  const factory DictionaryDetailsLoading() = _$DictionaryDetailsLoadingImpl;
}

/// @nodoc
abstract class _$$DictionaryDetailsLoadedImplCopyWith<$Res> {
  factory _$$DictionaryDetailsLoadedImplCopyWith(
          _$DictionaryDetailsLoadedImpl value,
          $Res Function(_$DictionaryDetailsLoadedImpl) then) =
      __$$DictionaryDetailsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WordData data});
}

/// @nodoc
class __$$DictionaryDetailsLoadedImplCopyWithImpl<$Res>
    extends _$DictionaryDetailsStateCopyWithImpl<$Res,
        _$DictionaryDetailsLoadedImpl>
    implements _$$DictionaryDetailsLoadedImplCopyWith<$Res> {
  __$$DictionaryDetailsLoadedImplCopyWithImpl(
      _$DictionaryDetailsLoadedImpl _value,
      $Res Function(_$DictionaryDetailsLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$DictionaryDetailsLoadedImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as WordData,
    ));
  }
}

/// @nodoc

class _$DictionaryDetailsLoadedImpl implements DictionaryDetailsLoaded {
  const _$DictionaryDetailsLoadedImpl(this.data);

  @override
  final WordData data;

  @override
  String toString() {
    return 'DictionaryDetailsState.loaded(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictionaryDetailsLoadedImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DictionaryDetailsLoadedImplCopyWith<_$DictionaryDetailsLoadedImpl>
      get copyWith => __$$DictionaryDetailsLoadedImplCopyWithImpl<
          _$DictionaryDetailsLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(WordData data) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(WordData data)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(WordData data)? loaded,
    TResult Function()? initial,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DictionaryDetailsLoading value) loading,
    required TResult Function(DictionaryDetailsLoaded value) loaded,
    required TResult Function(DictionaryDetailsInitial value) initial,
    required TResult Function(DictionaryDetailsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DictionaryDetailsLoading value)? loading,
    TResult? Function(DictionaryDetailsLoaded value)? loaded,
    TResult? Function(DictionaryDetailsInitial value)? initial,
    TResult? Function(DictionaryDetailsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DictionaryDetailsLoading value)? loading,
    TResult Function(DictionaryDetailsLoaded value)? loaded,
    TResult Function(DictionaryDetailsInitial value)? initial,
    TResult Function(DictionaryDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class DictionaryDetailsLoaded implements DictionaryDetailsState {
  const factory DictionaryDetailsLoaded(final WordData data) =
      _$DictionaryDetailsLoadedImpl;

  WordData get data;
  @JsonKey(ignore: true)
  _$$DictionaryDetailsLoadedImplCopyWith<_$DictionaryDetailsLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DictionaryDetailsInitialImplCopyWith<$Res> {
  factory _$$DictionaryDetailsInitialImplCopyWith(
          _$DictionaryDetailsInitialImpl value,
          $Res Function(_$DictionaryDetailsInitialImpl) then) =
      __$$DictionaryDetailsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryDetailsInitialImplCopyWithImpl<$Res>
    extends _$DictionaryDetailsStateCopyWithImpl<$Res,
        _$DictionaryDetailsInitialImpl>
    implements _$$DictionaryDetailsInitialImplCopyWith<$Res> {
  __$$DictionaryDetailsInitialImplCopyWithImpl(
      _$DictionaryDetailsInitialImpl _value,
      $Res Function(_$DictionaryDetailsInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryDetailsInitialImpl implements DictionaryDetailsInitial {
  const _$DictionaryDetailsInitialImpl();

  @override
  String toString() {
    return 'DictionaryDetailsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictionaryDetailsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(WordData data) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(WordData data)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(WordData data)? loaded,
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
    required TResult Function(DictionaryDetailsLoading value) loading,
    required TResult Function(DictionaryDetailsLoaded value) loaded,
    required TResult Function(DictionaryDetailsInitial value) initial,
    required TResult Function(DictionaryDetailsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DictionaryDetailsLoading value)? loading,
    TResult? Function(DictionaryDetailsLoaded value)? loaded,
    TResult? Function(DictionaryDetailsInitial value)? initial,
    TResult? Function(DictionaryDetailsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DictionaryDetailsLoading value)? loading,
    TResult Function(DictionaryDetailsLoaded value)? loaded,
    TResult Function(DictionaryDetailsInitial value)? initial,
    TResult Function(DictionaryDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class DictionaryDetailsInitial implements DictionaryDetailsState {
  const factory DictionaryDetailsInitial() = _$DictionaryDetailsInitialImpl;
}

/// @nodoc
abstract class _$$DictionaryDetailsErrorImplCopyWith<$Res> {
  factory _$$DictionaryDetailsErrorImplCopyWith(
          _$DictionaryDetailsErrorImpl value,
          $Res Function(_$DictionaryDetailsErrorImpl) then) =
      __$$DictionaryDetailsErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryDetailsErrorImplCopyWithImpl<$Res>
    extends _$DictionaryDetailsStateCopyWithImpl<$Res,
        _$DictionaryDetailsErrorImpl>
    implements _$$DictionaryDetailsErrorImplCopyWith<$Res> {
  __$$DictionaryDetailsErrorImplCopyWithImpl(
      _$DictionaryDetailsErrorImpl _value,
      $Res Function(_$DictionaryDetailsErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryDetailsErrorImpl implements DictionaryDetailsError {
  const _$DictionaryDetailsErrorImpl();

  @override
  String toString() {
    return 'DictionaryDetailsState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictionaryDetailsErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(WordData data) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(WordData data)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(WordData data)? loaded,
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
    required TResult Function(DictionaryDetailsLoading value) loading,
    required TResult Function(DictionaryDetailsLoaded value) loaded,
    required TResult Function(DictionaryDetailsInitial value) initial,
    required TResult Function(DictionaryDetailsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DictionaryDetailsLoading value)? loading,
    TResult? Function(DictionaryDetailsLoaded value)? loaded,
    TResult? Function(DictionaryDetailsInitial value)? initial,
    TResult? Function(DictionaryDetailsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DictionaryDetailsLoading value)? loading,
    TResult Function(DictionaryDetailsLoaded value)? loaded,
    TResult Function(DictionaryDetailsInitial value)? initial,
    TResult Function(DictionaryDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class DictionaryDetailsError implements DictionaryDetailsState {
  const factory DictionaryDetailsError() = _$DictionaryDetailsErrorImpl;
}
