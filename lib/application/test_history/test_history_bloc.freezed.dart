// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_history_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TestHistoryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Test> list) loaded,
    required TResult Function() loading,
    required TResult Function() initial,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Test> list)? loaded,
    TResult? Function()? loading,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Test> list)? loaded,
    TResult Function()? loading,
    TResult Function()? initial,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestHistoryLoaded value) loaded,
    required TResult Function(TestHistoryLoading value) loading,
    required TResult Function(TestHistoryInitial value) initial,
    required TResult Function(TestHistoryError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestHistoryLoaded value)? loaded,
    TResult? Function(TestHistoryLoading value)? loading,
    TResult? Function(TestHistoryInitial value)? initial,
    TResult? Function(TestHistoryError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestHistoryLoaded value)? loaded,
    TResult Function(TestHistoryLoading value)? loading,
    TResult Function(TestHistoryInitial value)? initial,
    TResult Function(TestHistoryError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestHistoryStateCopyWith<$Res> {
  factory $TestHistoryStateCopyWith(
          TestHistoryState value, $Res Function(TestHistoryState) then) =
      _$TestHistoryStateCopyWithImpl<$Res, TestHistoryState>;
}

/// @nodoc
class _$TestHistoryStateCopyWithImpl<$Res, $Val extends TestHistoryState>
    implements $TestHistoryStateCopyWith<$Res> {
  _$TestHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TestHistoryLoadedCopyWith<$Res> {
  factory _$$TestHistoryLoadedCopyWith(
          _$TestHistoryLoaded value, $Res Function(_$TestHistoryLoaded) then) =
      __$$TestHistoryLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Test> list});
}

/// @nodoc
class __$$TestHistoryLoadedCopyWithImpl<$Res>
    extends _$TestHistoryStateCopyWithImpl<$Res, _$TestHistoryLoaded>
    implements _$$TestHistoryLoadedCopyWith<$Res> {
  __$$TestHistoryLoadedCopyWithImpl(
      _$TestHistoryLoaded _value, $Res Function(_$TestHistoryLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$TestHistoryLoaded(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Test>,
    ));
  }
}

/// @nodoc

class _$TestHistoryLoaded implements TestHistoryLoaded {
  const _$TestHistoryLoaded(final List<Test> list) : _list = list;

  final List<Test> _list;
  @override
  List<Test> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'TestHistoryState.loaded(list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestHistoryLoaded &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestHistoryLoadedCopyWith<_$TestHistoryLoaded> get copyWith =>
      __$$TestHistoryLoadedCopyWithImpl<_$TestHistoryLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Test> list) loaded,
    required TResult Function() loading,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return loaded(list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Test> list)? loaded,
    TResult? Function()? loading,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return loaded?.call(list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Test> list)? loaded,
    TResult Function()? loading,
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
    required TResult Function(TestHistoryLoaded value) loaded,
    required TResult Function(TestHistoryLoading value) loading,
    required TResult Function(TestHistoryInitial value) initial,
    required TResult Function(TestHistoryError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestHistoryLoaded value)? loaded,
    TResult? Function(TestHistoryLoading value)? loading,
    TResult? Function(TestHistoryInitial value)? initial,
    TResult? Function(TestHistoryError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestHistoryLoaded value)? loaded,
    TResult Function(TestHistoryLoading value)? loading,
    TResult Function(TestHistoryInitial value)? initial,
    TResult Function(TestHistoryError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TestHistoryLoaded implements TestHistoryState {
  const factory TestHistoryLoaded(final List<Test> list) = _$TestHistoryLoaded;

  List<Test> get list;
  @JsonKey(ignore: true)
  _$$TestHistoryLoadedCopyWith<_$TestHistoryLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestHistoryLoadingCopyWith<$Res> {
  factory _$$TestHistoryLoadingCopyWith(_$TestHistoryLoading value,
          $Res Function(_$TestHistoryLoading) then) =
      __$$TestHistoryLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestHistoryLoadingCopyWithImpl<$Res>
    extends _$TestHistoryStateCopyWithImpl<$Res, _$TestHistoryLoading>
    implements _$$TestHistoryLoadingCopyWith<$Res> {
  __$$TestHistoryLoadingCopyWithImpl(
      _$TestHistoryLoading _value, $Res Function(_$TestHistoryLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestHistoryLoading implements TestHistoryLoading {
  const _$TestHistoryLoading();

  @override
  String toString() {
    return 'TestHistoryState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TestHistoryLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Test> list) loaded,
    required TResult Function() loading,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Test> list)? loaded,
    TResult? Function()? loading,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Test> list)? loaded,
    TResult Function()? loading,
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
    required TResult Function(TestHistoryLoaded value) loaded,
    required TResult Function(TestHistoryLoading value) loading,
    required TResult Function(TestHistoryInitial value) initial,
    required TResult Function(TestHistoryError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestHistoryLoaded value)? loaded,
    TResult? Function(TestHistoryLoading value)? loading,
    TResult? Function(TestHistoryInitial value)? initial,
    TResult? Function(TestHistoryError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestHistoryLoaded value)? loaded,
    TResult Function(TestHistoryLoading value)? loading,
    TResult Function(TestHistoryInitial value)? initial,
    TResult Function(TestHistoryError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TestHistoryLoading implements TestHistoryState {
  const factory TestHistoryLoading() = _$TestHistoryLoading;
}

/// @nodoc
abstract class _$$TestHistoryInitialCopyWith<$Res> {
  factory _$$TestHistoryInitialCopyWith(_$TestHistoryInitial value,
          $Res Function(_$TestHistoryInitial) then) =
      __$$TestHistoryInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestHistoryInitialCopyWithImpl<$Res>
    extends _$TestHistoryStateCopyWithImpl<$Res, _$TestHistoryInitial>
    implements _$$TestHistoryInitialCopyWith<$Res> {
  __$$TestHistoryInitialCopyWithImpl(
      _$TestHistoryInitial _value, $Res Function(_$TestHistoryInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestHistoryInitial implements TestHistoryInitial {
  const _$TestHistoryInitial();

  @override
  String toString() {
    return 'TestHistoryState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TestHistoryInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Test> list) loaded,
    required TResult Function() loading,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Test> list)? loaded,
    TResult? Function()? loading,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Test> list)? loaded,
    TResult Function()? loading,
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
    required TResult Function(TestHistoryLoaded value) loaded,
    required TResult Function(TestHistoryLoading value) loading,
    required TResult Function(TestHistoryInitial value) initial,
    required TResult Function(TestHistoryError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestHistoryLoaded value)? loaded,
    TResult? Function(TestHistoryLoading value)? loading,
    TResult? Function(TestHistoryInitial value)? initial,
    TResult? Function(TestHistoryError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestHistoryLoaded value)? loaded,
    TResult Function(TestHistoryLoading value)? loading,
    TResult Function(TestHistoryInitial value)? initial,
    TResult Function(TestHistoryError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TestHistoryInitial implements TestHistoryState {
  const factory TestHistoryInitial() = _$TestHistoryInitial;
}

/// @nodoc
abstract class _$$TestHistoryErrorCopyWith<$Res> {
  factory _$$TestHistoryErrorCopyWith(
          _$TestHistoryError value, $Res Function(_$TestHistoryError) then) =
      __$$TestHistoryErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestHistoryErrorCopyWithImpl<$Res>
    extends _$TestHistoryStateCopyWithImpl<$Res, _$TestHistoryError>
    implements _$$TestHistoryErrorCopyWith<$Res> {
  __$$TestHistoryErrorCopyWithImpl(
      _$TestHistoryError _value, $Res Function(_$TestHistoryError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestHistoryError implements TestHistoryError {
  const _$TestHistoryError();

  @override
  String toString() {
    return 'TestHistoryState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TestHistoryError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Test> list) loaded,
    required TResult Function() loading,
    required TResult Function() initial,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Test> list)? loaded,
    TResult? Function()? loading,
    TResult? Function()? initial,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Test> list)? loaded,
    TResult Function()? loading,
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
    required TResult Function(TestHistoryLoaded value) loaded,
    required TResult Function(TestHistoryLoading value) loading,
    required TResult Function(TestHistoryInitial value) initial,
    required TResult Function(TestHistoryError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestHistoryLoaded value)? loaded,
    TResult? Function(TestHistoryLoading value)? loading,
    TResult? Function(TestHistoryInitial value)? initial,
    TResult? Function(TestHistoryError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestHistoryLoaded value)? loaded,
    TResult Function(TestHistoryLoading value)? loading,
    TResult Function(TestHistoryInitial value)? initial,
    TResult Function(TestHistoryError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TestHistoryError implements TestHistoryState {
  const factory TestHistoryError() = _$TestHistoryError;
}
