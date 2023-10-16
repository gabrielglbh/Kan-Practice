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
abstract class _$$TestHistoryLoadedImplCopyWith<$Res> {
  factory _$$TestHistoryLoadedImplCopyWith(_$TestHistoryLoadedImpl value,
          $Res Function(_$TestHistoryLoadedImpl) then) =
      __$$TestHistoryLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Test> list});
}

/// @nodoc
class __$$TestHistoryLoadedImplCopyWithImpl<$Res>
    extends _$TestHistoryStateCopyWithImpl<$Res, _$TestHistoryLoadedImpl>
    implements _$$TestHistoryLoadedImplCopyWith<$Res> {
  __$$TestHistoryLoadedImplCopyWithImpl(_$TestHistoryLoadedImpl _value,
      $Res Function(_$TestHistoryLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
  }) {
    return _then(_$TestHistoryLoadedImpl(
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Test>,
    ));
  }
}

/// @nodoc

class _$TestHistoryLoadedImpl implements TestHistoryLoaded {
  const _$TestHistoryLoadedImpl(final List<Test> list) : _list = list;

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
            other is _$TestHistoryLoadedImpl &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestHistoryLoadedImplCopyWith<_$TestHistoryLoadedImpl> get copyWith =>
      __$$TestHistoryLoadedImplCopyWithImpl<_$TestHistoryLoadedImpl>(
          this, _$identity);

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
  const factory TestHistoryLoaded(final List<Test> list) =
      _$TestHistoryLoadedImpl;

  List<Test> get list;
  @JsonKey(ignore: true)
  _$$TestHistoryLoadedImplCopyWith<_$TestHistoryLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestHistoryLoadingImplCopyWith<$Res> {
  factory _$$TestHistoryLoadingImplCopyWith(_$TestHistoryLoadingImpl value,
          $Res Function(_$TestHistoryLoadingImpl) then) =
      __$$TestHistoryLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestHistoryLoadingImplCopyWithImpl<$Res>
    extends _$TestHistoryStateCopyWithImpl<$Res, _$TestHistoryLoadingImpl>
    implements _$$TestHistoryLoadingImplCopyWith<$Res> {
  __$$TestHistoryLoadingImplCopyWithImpl(_$TestHistoryLoadingImpl _value,
      $Res Function(_$TestHistoryLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestHistoryLoadingImpl implements TestHistoryLoading {
  const _$TestHistoryLoadingImpl();

  @override
  String toString() {
    return 'TestHistoryState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TestHistoryLoadingImpl);
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
  const factory TestHistoryLoading() = _$TestHistoryLoadingImpl;
}

/// @nodoc
abstract class _$$TestHistoryInitialImplCopyWith<$Res> {
  factory _$$TestHistoryInitialImplCopyWith(_$TestHistoryInitialImpl value,
          $Res Function(_$TestHistoryInitialImpl) then) =
      __$$TestHistoryInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestHistoryInitialImplCopyWithImpl<$Res>
    extends _$TestHistoryStateCopyWithImpl<$Res, _$TestHistoryInitialImpl>
    implements _$$TestHistoryInitialImplCopyWith<$Res> {
  __$$TestHistoryInitialImplCopyWithImpl(_$TestHistoryInitialImpl _value,
      $Res Function(_$TestHistoryInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestHistoryInitialImpl implements TestHistoryInitial {
  const _$TestHistoryInitialImpl();

  @override
  String toString() {
    return 'TestHistoryState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TestHistoryInitialImpl);
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
  const factory TestHistoryInitial() = _$TestHistoryInitialImpl;
}

/// @nodoc
abstract class _$$TestHistoryErrorImplCopyWith<$Res> {
  factory _$$TestHistoryErrorImplCopyWith(_$TestHistoryErrorImpl value,
          $Res Function(_$TestHistoryErrorImpl) then) =
      __$$TestHistoryErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestHistoryErrorImplCopyWithImpl<$Res>
    extends _$TestHistoryStateCopyWithImpl<$Res, _$TestHistoryErrorImpl>
    implements _$$TestHistoryErrorImplCopyWith<$Res> {
  __$$TestHistoryErrorImplCopyWithImpl(_$TestHistoryErrorImpl _value,
      $Res Function(_$TestHistoryErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestHistoryErrorImpl implements TestHistoryError {
  const _$TestHistoryErrorImpl();

  @override
  String toString() {
    return 'TestHistoryState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TestHistoryErrorImpl);
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
  const factory TestHistoryError() = _$TestHistoryErrorImpl;
}
