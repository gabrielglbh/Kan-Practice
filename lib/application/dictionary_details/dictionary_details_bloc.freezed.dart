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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$DictionaryDetailsLoadingCopyWith<$Res> {
  factory _$$DictionaryDetailsLoadingCopyWith(_$DictionaryDetailsLoading value,
          $Res Function(_$DictionaryDetailsLoading) then) =
      __$$DictionaryDetailsLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryDetailsLoadingCopyWithImpl<$Res>
    extends _$DictionaryDetailsStateCopyWithImpl<$Res,
        _$DictionaryDetailsLoading>
    implements _$$DictionaryDetailsLoadingCopyWith<$Res> {
  __$$DictionaryDetailsLoadingCopyWithImpl(_$DictionaryDetailsLoading _value,
      $Res Function(_$DictionaryDetailsLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryDetailsLoading implements DictionaryDetailsLoading {
  const _$DictionaryDetailsLoading();

  @override
  String toString() {
    return 'DictionaryDetailsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictionaryDetailsLoading);
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
  const factory DictionaryDetailsLoading() = _$DictionaryDetailsLoading;
}

/// @nodoc
abstract class _$$DictionaryDetailsLoadedCopyWith<$Res> {
  factory _$$DictionaryDetailsLoadedCopyWith(_$DictionaryDetailsLoaded value,
          $Res Function(_$DictionaryDetailsLoaded) then) =
      __$$DictionaryDetailsLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({WordData data});
}

/// @nodoc
class __$$DictionaryDetailsLoadedCopyWithImpl<$Res>
    extends _$DictionaryDetailsStateCopyWithImpl<$Res,
        _$DictionaryDetailsLoaded>
    implements _$$DictionaryDetailsLoadedCopyWith<$Res> {
  __$$DictionaryDetailsLoadedCopyWithImpl(_$DictionaryDetailsLoaded _value,
      $Res Function(_$DictionaryDetailsLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$DictionaryDetailsLoaded(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as WordData,
    ));
  }
}

/// @nodoc

class _$DictionaryDetailsLoaded implements DictionaryDetailsLoaded {
  const _$DictionaryDetailsLoaded(this.data);

  @override
  final WordData data;

  @override
  String toString() {
    return 'DictionaryDetailsState.loaded(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictionaryDetailsLoaded &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DictionaryDetailsLoadedCopyWith<_$DictionaryDetailsLoaded> get copyWith =>
      __$$DictionaryDetailsLoadedCopyWithImpl<_$DictionaryDetailsLoaded>(
          this, _$identity);

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
      _$DictionaryDetailsLoaded;

  WordData get data;
  @JsonKey(ignore: true)
  _$$DictionaryDetailsLoadedCopyWith<_$DictionaryDetailsLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DictionaryDetailsInitialCopyWith<$Res> {
  factory _$$DictionaryDetailsInitialCopyWith(_$DictionaryDetailsInitial value,
          $Res Function(_$DictionaryDetailsInitial) then) =
      __$$DictionaryDetailsInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryDetailsInitialCopyWithImpl<$Res>
    extends _$DictionaryDetailsStateCopyWithImpl<$Res,
        _$DictionaryDetailsInitial>
    implements _$$DictionaryDetailsInitialCopyWith<$Res> {
  __$$DictionaryDetailsInitialCopyWithImpl(_$DictionaryDetailsInitial _value,
      $Res Function(_$DictionaryDetailsInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryDetailsInitial implements DictionaryDetailsInitial {
  const _$DictionaryDetailsInitial();

  @override
  String toString() {
    return 'DictionaryDetailsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictionaryDetailsInitial);
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
  const factory DictionaryDetailsInitial() = _$DictionaryDetailsInitial;
}

/// @nodoc
abstract class _$$DictionaryDetailsErrorCopyWith<$Res> {
  factory _$$DictionaryDetailsErrorCopyWith(_$DictionaryDetailsError value,
          $Res Function(_$DictionaryDetailsError) then) =
      __$$DictionaryDetailsErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DictionaryDetailsErrorCopyWithImpl<$Res>
    extends _$DictionaryDetailsStateCopyWithImpl<$Res, _$DictionaryDetailsError>
    implements _$$DictionaryDetailsErrorCopyWith<$Res> {
  __$$DictionaryDetailsErrorCopyWithImpl(_$DictionaryDetailsError _value,
      $Res Function(_$DictionaryDetailsError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DictionaryDetailsError implements DictionaryDetailsError {
  const _$DictionaryDetailsError();

  @override
  String toString() {
    return 'DictionaryDetailsState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DictionaryDetailsError);
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
  const factory DictionaryDetailsError() = _$DictionaryDetailsError;
}
