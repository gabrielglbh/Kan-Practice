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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$DictionaryLoadingCopyWith<$Res> {
  factory _$$DictionaryLoadingCopyWith(
          _$DictionaryLoading value, $Res Function(_$DictionaryLoading) then) =
      __$$DictionaryLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryLoadingCopyWithImpl<$Res>
    extends _$DictionaryStateCopyWithImpl<$Res, _$DictionaryLoading>
    implements _$$DictionaryLoadingCopyWith<$Res> {
  __$$DictionaryLoadingCopyWithImpl(
      _$DictionaryLoading _value, $Res Function(_$DictionaryLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryLoading implements DictionaryLoading {
  const _$DictionaryLoading();

  @override
  String toString() {
    return 'DictionaryState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DictionaryLoading);
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
  const factory DictionaryLoading() = _$DictionaryLoading;
}

/// @nodoc
abstract class _$$DictionaryLoadedCopyWith<$Res> {
  factory _$$DictionaryLoadedCopyWith(
          _$DictionaryLoaded value, $Res Function(_$DictionaryLoaded) then) =
      __$$DictionaryLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Category> predictions});
}

/// @nodoc
class __$$DictionaryLoadedCopyWithImpl<$Res>
    extends _$DictionaryStateCopyWithImpl<$Res, _$DictionaryLoaded>
    implements _$$DictionaryLoadedCopyWith<$Res> {
  __$$DictionaryLoadedCopyWithImpl(
      _$DictionaryLoaded _value, $Res Function(_$DictionaryLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? predictions = null,
  }) {
    return _then(_$DictionaryLoaded(
      null == predictions
          ? _value._predictions
          : predictions // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc

class _$DictionaryLoaded implements DictionaryLoaded {
  const _$DictionaryLoaded(final List<Category> predictions)
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictionaryLoaded &&
            const DeepCollectionEquality()
                .equals(other._predictions, _predictions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_predictions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DictionaryLoadedCopyWith<_$DictionaryLoaded> get copyWith =>
      __$$DictionaryLoadedCopyWithImpl<_$DictionaryLoaded>(this, _$identity);

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
      _$DictionaryLoaded;

  List<Category> get predictions;
  @JsonKey(ignore: true)
  _$$DictionaryLoadedCopyWith<_$DictionaryLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DictionaryInitialCopyWith<$Res> {
  factory _$$DictionaryInitialCopyWith(
          _$DictionaryInitial value, $Res Function(_$DictionaryInitial) then) =
      __$$DictionaryInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryInitialCopyWithImpl<$Res>
    extends _$DictionaryStateCopyWithImpl<$Res, _$DictionaryInitial>
    implements _$$DictionaryInitialCopyWith<$Res> {
  __$$DictionaryInitialCopyWithImpl(
      _$DictionaryInitial _value, $Res Function(_$DictionaryInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryInitial implements DictionaryInitial {
  const _$DictionaryInitial();

  @override
  String toString() {
    return 'DictionaryState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DictionaryInitial);
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
  const factory DictionaryInitial() = _$DictionaryInitial;
}

/// @nodoc
abstract class _$$DictionaryErrorCopyWith<$Res> {
  factory _$$DictionaryErrorCopyWith(
          _$DictionaryError value, $Res Function(_$DictionaryError) then) =
      __$$DictionaryErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryErrorCopyWithImpl<$Res>
    extends _$DictionaryStateCopyWithImpl<$Res, _$DictionaryError>
    implements _$$DictionaryErrorCopyWith<$Res> {
  __$$DictionaryErrorCopyWithImpl(
      _$DictionaryError _value, $Res Function(_$DictionaryError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryError implements DictionaryError {
  const _$DictionaryError();

  @override
  String toString() {
    return 'DictionaryState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DictionaryError);
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
  const factory DictionaryError() = _$DictionaryError;
}
