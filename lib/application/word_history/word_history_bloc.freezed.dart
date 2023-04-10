// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_history_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WordHistoryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
    required TResult Function(List<WordHistory> list) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? error,
    TResult? Function(List<WordHistory> list)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<WordHistory> list)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WordHistoryInitial value) initial,
    required TResult Function(WordHistoryLoading value) loading,
    required TResult Function(WordHistoryError value) error,
    required TResult Function(WordHistoryLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WordHistoryInitial value)? initial,
    TResult? Function(WordHistoryLoading value)? loading,
    TResult? Function(WordHistoryError value)? error,
    TResult? Function(WordHistoryLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WordHistoryInitial value)? initial,
    TResult Function(WordHistoryLoading value)? loading,
    TResult Function(WordHistoryError value)? error,
    TResult Function(WordHistoryLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordHistoryStateCopyWith<$Res> {
  factory $WordHistoryStateCopyWith(
          WordHistoryState value, $Res Function(WordHistoryState) then) =
      _$WordHistoryStateCopyWithImpl<$Res, WordHistoryState>;
}

/// @nodoc
class _$WordHistoryStateCopyWithImpl<$Res, $Val extends WordHistoryState>
    implements $WordHistoryStateCopyWith<$Res> {
  _$WordHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$WordHistoryInitialCopyWith<$Res> {
  factory _$$WordHistoryInitialCopyWith(_$WordHistoryInitial value,
          $Res Function(_$WordHistoryInitial) then) =
      __$$WordHistoryInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WordHistoryInitialCopyWithImpl<$Res>
    extends _$WordHistoryStateCopyWithImpl<$Res, _$WordHistoryInitial>
    implements _$$WordHistoryInitialCopyWith<$Res> {
  __$$WordHistoryInitialCopyWithImpl(
      _$WordHistoryInitial _value, $Res Function(_$WordHistoryInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WordHistoryInitial implements WordHistoryInitial {
  const _$WordHistoryInitial();

  @override
  String toString() {
    return 'WordHistoryState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WordHistoryInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
    required TResult Function(List<WordHistory> list) loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? error,
    TResult? Function(List<WordHistory> list)? loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<WordHistory> list)? loaded,
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
    required TResult Function(WordHistoryInitial value) initial,
    required TResult Function(WordHistoryLoading value) loading,
    required TResult Function(WordHistoryError value) error,
    required TResult Function(WordHistoryLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WordHistoryInitial value)? initial,
    TResult? Function(WordHistoryLoading value)? loading,
    TResult? Function(WordHistoryError value)? error,
    TResult? Function(WordHistoryLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WordHistoryInitial value)? initial,
    TResult Function(WordHistoryLoading value)? loading,
    TResult Function(WordHistoryError value)? error,
    TResult Function(WordHistoryLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class WordHistoryInitial implements WordHistoryState {
  const factory WordHistoryInitial() = _$WordHistoryInitial;
}

/// @nodoc
abstract class _$$WordHistoryLoadingCopyWith<$Res> {
  factory _$$WordHistoryLoadingCopyWith(_$WordHistoryLoading value,
          $Res Function(_$WordHistoryLoading) then) =
      __$$WordHistoryLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WordHistoryLoadingCopyWithImpl<$Res>
    extends _$WordHistoryStateCopyWithImpl<$Res, _$WordHistoryLoading>
    implements _$$WordHistoryLoadingCopyWith<$Res> {
  __$$WordHistoryLoadingCopyWithImpl(
      _$WordHistoryLoading _value, $Res Function(_$WordHistoryLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WordHistoryLoading implements WordHistoryLoading {
  const _$WordHistoryLoading();

  @override
  String toString() {
    return 'WordHistoryState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WordHistoryLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
    required TResult Function(List<WordHistory> list) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? error,
    TResult? Function(List<WordHistory> list)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<WordHistory> list)? loaded,
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
    required TResult Function(WordHistoryInitial value) initial,
    required TResult Function(WordHistoryLoading value) loading,
    required TResult Function(WordHistoryError value) error,
    required TResult Function(WordHistoryLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WordHistoryInitial value)? initial,
    TResult? Function(WordHistoryLoading value)? loading,
    TResult? Function(WordHistoryError value)? error,
    TResult? Function(WordHistoryLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WordHistoryInitial value)? initial,
    TResult Function(WordHistoryLoading value)? loading,
    TResult Function(WordHistoryError value)? error,
    TResult Function(WordHistoryLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class WordHistoryLoading implements WordHistoryState {
  const factory WordHistoryLoading() = _$WordHistoryLoading;
}

/// @nodoc
abstract class _$$WordHistoryErrorCopyWith<$Res> {
  factory _$$WordHistoryErrorCopyWith(
          _$WordHistoryError value, $Res Function(_$WordHistoryError) then) =
      __$$WordHistoryErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$WordHistoryErrorCopyWithImpl<$Res>
    extends _$WordHistoryStateCopyWithImpl<$Res, _$WordHistoryError>
    implements _$$WordHistoryErrorCopyWith<$Res> {
  __$$WordHistoryErrorCopyWithImpl(
      _$WordHistoryError _value, $Res Function(_$WordHistoryError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$WordHistoryError implements WordHistoryError {
  const _$WordHistoryError();

  @override
  String toString() {
    return 'WordHistoryState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$WordHistoryError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
    required TResult Function(List<WordHistory> list) loaded,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? error,
    TResult? Function(List<WordHistory> list)? loaded,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<WordHistory> list)? loaded,
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
    required TResult Function(WordHistoryInitial value) initial,
    required TResult Function(WordHistoryLoading value) loading,
    required TResult Function(WordHistoryError value) error,
    required TResult Function(WordHistoryLoaded value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WordHistoryInitial value)? initial,
    TResult? Function(WordHistoryLoading value)? loading,
    TResult? Function(WordHistoryError value)? error,
    TResult? Function(WordHistoryLoaded value)? loaded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WordHistoryInitial value)? initial,
    TResult Function(WordHistoryLoading value)? loading,
    TResult Function(WordHistoryError value)? error,
    TResult Function(WordHistoryLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class WordHistoryError implements WordHistoryState {
  const factory WordHistoryError() = _$WordHistoryError;
}

/// @nodoc
abstract class _$$WordHistoryLoadedCopyWith<$Res> {
  factory _$$WordHistoryLoadedCopyWith(
          _$WordHistoryLoaded value, $Res Function(_$WordHistoryLoaded) then) =
      __$$WordHistoryLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<WordHistory> list});
}

/// @nodoc
class __$$WordHistoryLoadedCopyWithImpl<$Res>
    extends _$WordHistoryStateCopyWithImpl<$Res, _$WordHistoryLoaded>
    implements _$$WordHistoryLoadedCopyWith<$Res> {
  __$$WordHistoryLoadedCopyWithImpl(
      _$WordHistoryLoaded _value, $Res Function(_$WordHistoryLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$WordHistoryLoaded(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<WordHistory>,
    ));
  }
}

/// @nodoc

class _$WordHistoryLoaded implements WordHistoryLoaded {
  const _$WordHistoryLoaded(final List<WordHistory> list) : _list = list;

  final List<WordHistory> _list;
  @override
  List<WordHistory> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'WordHistoryState.loaded(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordHistoryLoaded &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WordHistoryLoadedCopyWith<_$WordHistoryLoaded> get copyWith =>
      __$$WordHistoryLoadedCopyWithImpl<_$WordHistoryLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() error,
    required TResult Function(List<WordHistory> list) loaded,
  }) {
    return loaded(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? error,
    TResult? Function(List<WordHistory> list)? loaded,
  }) {
    return loaded?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? error,
    TResult Function(List<WordHistory> list)? loaded,
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
    required TResult Function(WordHistoryInitial value) initial,
    required TResult Function(WordHistoryLoading value) loading,
    required TResult Function(WordHistoryError value) error,
    required TResult Function(WordHistoryLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WordHistoryInitial value)? initial,
    TResult? Function(WordHistoryLoading value)? loading,
    TResult? Function(WordHistoryError value)? error,
    TResult? Function(WordHistoryLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WordHistoryInitial value)? initial,
    TResult Function(WordHistoryLoading value)? loading,
    TResult Function(WordHistoryError value)? error,
    TResult Function(WordHistoryLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class WordHistoryLoaded implements WordHistoryState {
  const factory WordHistoryLoaded(final List<WordHistory> list) =
      _$WordHistoryLoaded;

  List<WordHistory> get list;
  @JsonKey(ignore: true)
  _$$WordHistoryLoadedCopyWith<_$WordHistoryLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}
