// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dictionary_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DictionaryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Category> predictions) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Category> predictions)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Category> predictions)? loaded,
    TResult Function()? initial,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DictionaryLoading value) loading,
    required TResult Function(DictionaryLoaded value) loaded,
    required TResult Function(DictionaryInitial value) initial,
    required TResult Function(DictionaryError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DictionaryLoading value)? loading,
    TResult? Function(DictionaryLoaded value)? loaded,
    TResult? Function(DictionaryInitial value)? initial,
    TResult? Function(DictionaryError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DictionaryLoading value)? loading,
    TResult Function(DictionaryLoaded value)? loaded,
    TResult Function(DictionaryInitial value)? initial,
    TResult Function(DictionaryError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DictionaryStateCopyWith<$Res> {
  factory $DictionaryStateCopyWith(
          DictionaryState value, $Res Function(DictionaryState) then) =
      _$DictionaryStateCopyWithImpl<$Res, DictionaryState>;
}

/// @nodoc
class _$DictionaryStateCopyWithImpl<$Res, $Val extends DictionaryState>
    implements $DictionaryStateCopyWith<$Res> {
  _$DictionaryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$DictionaryLoadingImplCopyWith<$Res> {
  factory _$$DictionaryLoadingImplCopyWith(_$DictionaryLoadingImpl value,
          $Res Function(_$DictionaryLoadingImpl) then) =
      __$$DictionaryLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryLoadingImplCopyWithImpl<$Res>
    extends _$DictionaryStateCopyWithImpl<$Res, _$DictionaryLoadingImpl>
    implements _$$DictionaryLoadingImplCopyWith<$Res> {
  __$$DictionaryLoadingImplCopyWithImpl(_$DictionaryLoadingImpl _value,
      $Res Function(_$DictionaryLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryLoadingImpl implements DictionaryLoading {
  const _$DictionaryLoadingImpl();

  @override
  String toString() {
    return 'DictionaryState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DictionaryLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Category> predictions) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Category> predictions)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Category> predictions)? loaded,
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
    required TResult Function(DictionaryLoading value) loading,
    required TResult Function(DictionaryLoaded value) loaded,
    required TResult Function(DictionaryInitial value) initial,
    required TResult Function(DictionaryError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DictionaryLoading value)? loading,
    TResult? Function(DictionaryLoaded value)? loaded,
    TResult? Function(DictionaryInitial value)? initial,
    TResult? Function(DictionaryError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DictionaryLoading value)? loading,
    TResult Function(DictionaryLoaded value)? loaded,
    TResult Function(DictionaryInitial value)? initial,
    TResult Function(DictionaryError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class DictionaryLoading implements DictionaryState {
  const factory DictionaryLoading() = _$DictionaryLoadingImpl;
}

/// @nodoc
abstract class _$$DictionaryLoadedImplCopyWith<$Res> {
  factory _$$DictionaryLoadedImplCopyWith(_$DictionaryLoadedImpl value,
          $Res Function(_$DictionaryLoadedImpl) then) =
      __$$DictionaryLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Category> predictions});
}

/// @nodoc
class __$$DictionaryLoadedImplCopyWithImpl<$Res>
    extends _$DictionaryStateCopyWithImpl<$Res, _$DictionaryLoadedImpl>
    implements _$$DictionaryLoadedImplCopyWith<$Res> {
  __$$DictionaryLoadedImplCopyWithImpl(_$DictionaryLoadedImpl _value,
      $Res Function(_$DictionaryLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictions = null,
  }) {
    return _then(_$DictionaryLoadedImpl(
      null == predictions
          ? _value._predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc

class _$DictionaryLoadedImpl implements DictionaryLoaded {
  const _$DictionaryLoadedImpl(final List<Category> predictions)
      : _predictions = predictions;

  final List<Category> _predictions;
  @override
  List<Category> get predictions {
    if (_predictions is EqualUnmodifiableListView) return _predictions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_predictions);
  }

  @override
  String toString() {
    return 'DictionaryState.loaded(predictions: $predictions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictionaryLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._predictions, _predictions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_predictions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DictionaryLoadedImplCopyWith<_$DictionaryLoadedImpl> get copyWith =>
      __$$DictionaryLoadedImplCopyWithImpl<_$DictionaryLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Category> predictions) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return loaded(predictions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Category> predictions)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return loaded?.call(predictions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Category> predictions)? loaded,
    TResult Function()? initial,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(predictions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DictionaryLoading value) loading,
    required TResult Function(DictionaryLoaded value) loaded,
    required TResult Function(DictionaryInitial value) initial,
    required TResult Function(DictionaryError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DictionaryLoading value)? loading,
    TResult? Function(DictionaryLoaded value)? loaded,
    TResult? Function(DictionaryInitial value)? initial,
    TResult? Function(DictionaryError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DictionaryLoading value)? loading,
    TResult Function(DictionaryLoaded value)? loaded,
    TResult Function(DictionaryInitial value)? initial,
    TResult Function(DictionaryError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class DictionaryLoaded implements DictionaryState {
  const factory DictionaryLoaded(final List<Category> predictions) =
      _$DictionaryLoadedImpl;

  List<Category> get predictions;
  @JsonKey(ignore: true)
  _$$DictionaryLoadedImplCopyWith<_$DictionaryLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DictionaryInitialImplCopyWith<$Res> {
  factory _$$DictionaryInitialImplCopyWith(_$DictionaryInitialImpl value,
          $Res Function(_$DictionaryInitialImpl) then) =
      __$$DictionaryInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryInitialImplCopyWithImpl<$Res>
    extends _$DictionaryStateCopyWithImpl<$Res, _$DictionaryInitialImpl>
    implements _$$DictionaryInitialImplCopyWith<$Res> {
  __$$DictionaryInitialImplCopyWithImpl(_$DictionaryInitialImpl _value,
      $Res Function(_$DictionaryInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryInitialImpl implements DictionaryInitial {
  const _$DictionaryInitialImpl();

  @override
  String toString() {
    return 'DictionaryState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DictionaryInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Category> predictions) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Category> predictions)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Category> predictions)? loaded,
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
    required TResult Function(DictionaryLoading value) loading,
    required TResult Function(DictionaryLoaded value) loaded,
    required TResult Function(DictionaryInitial value) initial,
    required TResult Function(DictionaryError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DictionaryLoading value)? loading,
    TResult? Function(DictionaryLoaded value)? loaded,
    TResult? Function(DictionaryInitial value)? initial,
    TResult? Function(DictionaryError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DictionaryLoading value)? loading,
    TResult Function(DictionaryLoaded value)? loaded,
    TResult Function(DictionaryInitial value)? initial,
    TResult Function(DictionaryError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class DictionaryInitial implements DictionaryState {
  const factory DictionaryInitial() = _$DictionaryInitialImpl;
}

/// @nodoc
abstract class _$$DictionaryErrorImplCopyWith<$Res> {
  factory _$$DictionaryErrorImplCopyWith(_$DictionaryErrorImpl value,
          $Res Function(_$DictionaryErrorImpl) then) =
      __$$DictionaryErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryErrorImplCopyWithImpl<$Res>
    extends _$DictionaryStateCopyWithImpl<$Res, _$DictionaryErrorImpl>
    implements _$$DictionaryErrorImplCopyWith<$Res> {
  __$$DictionaryErrorImplCopyWithImpl(
      _$DictionaryErrorImpl _value, $Res Function(_$DictionaryErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryErrorImpl implements DictionaryError {
  const _$DictionaryErrorImpl();

  @override
  String toString() {
    return 'DictionaryState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DictionaryErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Category> predictions) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Category> predictions)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Category> predictions)? loaded,
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
    required TResult Function(DictionaryLoading value) loading,
    required TResult Function(DictionaryLoaded value) loaded,
    required TResult Function(DictionaryInitial value) initial,
    required TResult Function(DictionaryError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DictionaryLoading value)? loading,
    TResult? Function(DictionaryLoaded value)? loaded,
    TResult? Function(DictionaryInitial value)? initial,
    TResult? Function(DictionaryError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DictionaryLoading value)? loading,
    TResult Function(DictionaryLoaded value)? loaded,
    TResult Function(DictionaryInitial value)? initial,
    TResult Function(DictionaryError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class DictionaryError implements DictionaryState {
  const factory DictionaryError() = _$DictionaryErrorImpl;
}
