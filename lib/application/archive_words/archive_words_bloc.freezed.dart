// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'archive_words_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ArchiveWordsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Word> list) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Word> list)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Word> list)? loaded,
    TResult Function()? initial,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArchiveWordsLoading value) loading,
    required TResult Function(ArchiveWordsLoaded value) loaded,
    required TResult Function(ArchiveWordsInitial value) initial,
    required TResult Function(ArchiveWordsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArchiveWordsLoading value)? loading,
    TResult? Function(ArchiveWordsLoaded value)? loaded,
    TResult? Function(ArchiveWordsInitial value)? initial,
    TResult? Function(ArchiveWordsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArchiveWordsLoading value)? loading,
    TResult Function(ArchiveWordsLoaded value)? loaded,
    TResult Function(ArchiveWordsInitial value)? initial,
    TResult Function(ArchiveWordsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArchiveWordsStateCopyWith<$Res> {
  factory $ArchiveWordsStateCopyWith(
          ArchiveWordsState value, $Res Function(ArchiveWordsState) then) =
      _$ArchiveWordsStateCopyWithImpl<$Res, ArchiveWordsState>;
}

/// @nodoc
class _$ArchiveWordsStateCopyWithImpl<$Res, $Val extends ArchiveWordsState>
    implements $ArchiveWordsStateCopyWith<$Res> {
  _$ArchiveWordsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ArchiveWordsLoadingCopyWith<$Res> {
  factory _$$ArchiveWordsLoadingCopyWith(_$ArchiveWordsLoading value,
          $Res Function(_$ArchiveWordsLoading) then) =
      __$$ArchiveWordsLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ArchiveWordsLoadingCopyWithImpl<$Res>
    extends _$ArchiveWordsStateCopyWithImpl<$Res, _$ArchiveWordsLoading>
    implements _$$ArchiveWordsLoadingCopyWith<$Res> {
  __$$ArchiveWordsLoadingCopyWithImpl(
      _$ArchiveWordsLoading _value, $Res Function(_$ArchiveWordsLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ArchiveWordsLoading implements ArchiveWordsLoading {
  const _$ArchiveWordsLoading();

  @override
  String toString() {
    return 'ArchiveWordsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ArchiveWordsLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Word> list) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Word> list)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Word> list)? loaded,
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
    required TResult Function(ArchiveWordsLoading value) loading,
    required TResult Function(ArchiveWordsLoaded value) loaded,
    required TResult Function(ArchiveWordsInitial value) initial,
    required TResult Function(ArchiveWordsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArchiveWordsLoading value)? loading,
    TResult? Function(ArchiveWordsLoaded value)? loaded,
    TResult? Function(ArchiveWordsInitial value)? initial,
    TResult? Function(ArchiveWordsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArchiveWordsLoading value)? loading,
    TResult Function(ArchiveWordsLoaded value)? loaded,
    TResult Function(ArchiveWordsInitial value)? initial,
    TResult Function(ArchiveWordsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ArchiveWordsLoading implements ArchiveWordsState {
  const factory ArchiveWordsLoading() = _$ArchiveWordsLoading;
}

/// @nodoc
abstract class _$$ArchiveWordsLoadedCopyWith<$Res> {
  factory _$$ArchiveWordsLoadedCopyWith(_$ArchiveWordsLoaded value,
          $Res Function(_$ArchiveWordsLoaded) then) =
      __$$ArchiveWordsLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Word> list});
}

/// @nodoc
class __$$ArchiveWordsLoadedCopyWithImpl<$Res>
    extends _$ArchiveWordsStateCopyWithImpl<$Res, _$ArchiveWordsLoaded>
    implements _$$ArchiveWordsLoadedCopyWith<$Res> {
  __$$ArchiveWordsLoadedCopyWithImpl(
      _$ArchiveWordsLoaded _value, $Res Function(_$ArchiveWordsLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$ArchiveWordsLoaded(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Word>,
    ));
  }
}

/// @nodoc

class _$ArchiveWordsLoaded implements ArchiveWordsLoaded {
  const _$ArchiveWordsLoaded(final List<Word> list) : _list = list;

  final List<Word> _list;
  @override
  List<Word> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'ArchiveWordsState.loaded(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArchiveWordsLoaded &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArchiveWordsLoadedCopyWith<_$ArchiveWordsLoaded> get copyWith =>
      __$$ArchiveWordsLoadedCopyWithImpl<_$ArchiveWordsLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Word> list) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return loaded(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Word> list)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return loaded?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Word> list)? loaded,
    TResult Function()? initial,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(list);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ArchiveWordsLoading value) loading,
    required TResult Function(ArchiveWordsLoaded value) loaded,
    required TResult Function(ArchiveWordsInitial value) initial,
    required TResult Function(ArchiveWordsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArchiveWordsLoading value)? loading,
    TResult? Function(ArchiveWordsLoaded value)? loaded,
    TResult? Function(ArchiveWordsInitial value)? initial,
    TResult? Function(ArchiveWordsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArchiveWordsLoading value)? loading,
    TResult Function(ArchiveWordsLoaded value)? loaded,
    TResult Function(ArchiveWordsInitial value)? initial,
    TResult Function(ArchiveWordsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ArchiveWordsLoaded implements ArchiveWordsState {
  const factory ArchiveWordsLoaded(final List<Word> list) =
      _$ArchiveWordsLoaded;

  List<Word> get list;
  @JsonKey(ignore: true)
  _$$ArchiveWordsLoadedCopyWith<_$ArchiveWordsLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ArchiveWordsInitialCopyWith<$Res> {
  factory _$$ArchiveWordsInitialCopyWith(_$ArchiveWordsInitial value,
          $Res Function(_$ArchiveWordsInitial) then) =
      __$$ArchiveWordsInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ArchiveWordsInitialCopyWithImpl<$Res>
    extends _$ArchiveWordsStateCopyWithImpl<$Res, _$ArchiveWordsInitial>
    implements _$$ArchiveWordsInitialCopyWith<$Res> {
  __$$ArchiveWordsInitialCopyWithImpl(
      _$ArchiveWordsInitial _value, $Res Function(_$ArchiveWordsInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ArchiveWordsInitial implements ArchiveWordsInitial {
  const _$ArchiveWordsInitial();

  @override
  String toString() {
    return 'ArchiveWordsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ArchiveWordsInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Word> list) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Word> list)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Word> list)? loaded,
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
    required TResult Function(ArchiveWordsLoading value) loading,
    required TResult Function(ArchiveWordsLoaded value) loaded,
    required TResult Function(ArchiveWordsInitial value) initial,
    required TResult Function(ArchiveWordsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArchiveWordsLoading value)? loading,
    TResult? Function(ArchiveWordsLoaded value)? loaded,
    TResult? Function(ArchiveWordsInitial value)? initial,
    TResult? Function(ArchiveWordsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArchiveWordsLoading value)? loading,
    TResult Function(ArchiveWordsLoaded value)? loaded,
    TResult Function(ArchiveWordsInitial value)? initial,
    TResult Function(ArchiveWordsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ArchiveWordsInitial implements ArchiveWordsState {
  const factory ArchiveWordsInitial() = _$ArchiveWordsInitial;
}

/// @nodoc
abstract class _$$ArchiveWordsErrorCopyWith<$Res> {
  factory _$$ArchiveWordsErrorCopyWith(
          _$ArchiveWordsError value, $Res Function(_$ArchiveWordsError) then) =
      __$$ArchiveWordsErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ArchiveWordsErrorCopyWithImpl<$Res>
    extends _$ArchiveWordsStateCopyWithImpl<$Res, _$ArchiveWordsError>
    implements _$$ArchiveWordsErrorCopyWith<$Res> {
  __$$ArchiveWordsErrorCopyWithImpl(
      _$ArchiveWordsError _value, $Res Function(_$ArchiveWordsError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ArchiveWordsError implements ArchiveWordsError {
  const _$ArchiveWordsError();

  @override
  String toString() {
    return 'ArchiveWordsState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ArchiveWordsError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Word> list) loaded,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Word> list)? loaded,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Word> list)? loaded,
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
    required TResult Function(ArchiveWordsLoading value) loading,
    required TResult Function(ArchiveWordsLoaded value) loaded,
    required TResult Function(ArchiveWordsInitial value) initial,
    required TResult Function(ArchiveWordsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ArchiveWordsLoading value)? loading,
    TResult? Function(ArchiveWordsLoaded value)? loaded,
    TResult? Function(ArchiveWordsInitial value)? initial,
    TResult? Function(ArchiveWordsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ArchiveWordsLoading value)? loading,
    TResult Function(ArchiveWordsLoaded value)? loaded,
    TResult Function(ArchiveWordsInitial value)? initial,
    TResult Function(ArchiveWordsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ArchiveWordsError implements ArchiveWordsState {
  const factory ArchiveWordsError() = _$ArchiveWordsError;
}
