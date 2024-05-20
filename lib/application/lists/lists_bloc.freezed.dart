// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lists_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ListsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<WordList> lists) loaded,
    required TResult Function() loading,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<WordList> lists)? loaded,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<WordList> lists)? loaded,
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ListsLoaded value) loaded,
    required TResult Function(ListsLoading value) loading,
    required TResult Function(ListsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListsLoaded value)? loaded,
    TResult? Function(ListsLoading value)? loading,
    TResult? Function(ListsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListsLoaded value)? loaded,
    TResult Function(ListsLoading value)? loading,
    TResult Function(ListsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListsStateCopyWith<$Res> {
  factory $ListsStateCopyWith(
          ListsState value, $Res Function(ListsState) then) =
      _$ListsStateCopyWithImpl<$Res, ListsState>;
}

/// @nodoc
class _$ListsStateCopyWithImpl<$Res, $Val extends ListsState>
    implements $ListsStateCopyWith<$Res> {
  _$ListsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ListsLoadedImplCopyWith<$Res> {
  factory _$$ListsLoadedImplCopyWith(
          _$ListsLoadedImpl value, $Res Function(_$ListsLoadedImpl) then) =
      __$$ListsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<WordList> lists});
}

/// @nodoc
class __$$ListsLoadedImplCopyWithImpl<$Res>
    extends _$ListsStateCopyWithImpl<$Res, _$ListsLoadedImpl>
    implements _$$ListsLoadedImplCopyWith<$Res> {
  __$$ListsLoadedImplCopyWithImpl(
      _$ListsLoadedImpl _value, $Res Function(_$ListsLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lists = null,
  }) {
    return _then(_$ListsLoadedImpl(
      null == lists
          ? _value._lists
          : lists // ignore: cast_nullable_to_non_nullable
              as List<WordList>,
    ));
  }
}

/// @nodoc

class _$ListsLoadedImpl implements ListsLoaded {
  const _$ListsLoadedImpl(final List<WordList> lists) : _lists = lists;

  final List<WordList> _lists;
  @override
  List<WordList> get lists {
    if (_lists is EqualUnmodifiableListView) return _lists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lists);
  }

  @override
  String toString() {
    return 'ListsState.loaded(lists: $lists)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListsLoadedImpl &&
            const DeepCollectionEquality().equals(other._lists, _lists));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_lists));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListsLoadedImplCopyWith<_$ListsLoadedImpl> get copyWith =>
      __$$ListsLoadedImplCopyWithImpl<_$ListsLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<WordList> lists) loaded,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return loaded(lists);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<WordList> lists)? loaded,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return loaded?.call(lists);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<WordList> lists)? loaded,
    TResult Function()? loading,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(lists);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ListsLoaded value) loaded,
    required TResult Function(ListsLoading value) loading,
    required TResult Function(ListsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListsLoaded value)? loaded,
    TResult? Function(ListsLoading value)? loading,
    TResult? Function(ListsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListsLoaded value)? loaded,
    TResult Function(ListsLoading value)? loading,
    TResult Function(ListsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ListsLoaded implements ListsState {
  const factory ListsLoaded(final List<WordList> lists) = _$ListsLoadedImpl;

  List<WordList> get lists;
  @JsonKey(ignore: true)
  _$$ListsLoadedImplCopyWith<_$ListsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListsLoadingImplCopyWith<$Res> {
  factory _$$ListsLoadingImplCopyWith(
          _$ListsLoadingImpl value, $Res Function(_$ListsLoadingImpl) then) =
      __$$ListsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListsLoadingImplCopyWithImpl<$Res>
    extends _$ListsStateCopyWithImpl<$Res, _$ListsLoadingImpl>
    implements _$$ListsLoadingImplCopyWith<$Res> {
  __$$ListsLoadingImplCopyWithImpl(
      _$ListsLoadingImpl _value, $Res Function(_$ListsLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListsLoadingImpl implements ListsLoading {
  const _$ListsLoadingImpl();

  @override
  String toString() {
    return 'ListsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<WordList> lists) loaded,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<WordList> lists)? loaded,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<WordList> lists)? loaded,
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
    required TResult Function(ListsLoaded value) loaded,
    required TResult Function(ListsLoading value) loading,
    required TResult Function(ListsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListsLoaded value)? loaded,
    TResult? Function(ListsLoading value)? loading,
    TResult? Function(ListsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListsLoaded value)? loaded,
    TResult Function(ListsLoading value)? loading,
    TResult Function(ListsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ListsLoading implements ListsState {
  const factory ListsLoading() = _$ListsLoadingImpl;
}

/// @nodoc
abstract class _$$ListsErrorImplCopyWith<$Res> {
  factory _$$ListsErrorImplCopyWith(
          _$ListsErrorImpl value, $Res Function(_$ListsErrorImpl) then) =
      __$$ListsErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListsErrorImplCopyWithImpl<$Res>
    extends _$ListsStateCopyWithImpl<$Res, _$ListsErrorImpl>
    implements _$$ListsErrorImplCopyWith<$Res> {
  __$$ListsErrorImplCopyWithImpl(
      _$ListsErrorImpl _value, $Res Function(_$ListsErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListsErrorImpl implements ListsError {
  const _$ListsErrorImpl();

  @override
  String toString() {
    return 'ListsState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListsErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<WordList> lists) loaded,
    required TResult Function() loading,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<WordList> lists)? loaded,
    TResult? Function()? loading,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<WordList> lists)? loaded,
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
    required TResult Function(ListsLoaded value) loaded,
    required TResult Function(ListsLoading value) loading,
    required TResult Function(ListsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ListsLoaded value)? loaded,
    TResult? Function(ListsLoading value)? loading,
    TResult? Function(ListsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ListsLoaded value)? loaded,
    TResult Function(ListsLoading value)? loading,
    TResult Function(ListsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ListsError implements ListsState {
  const factory ListsError() = _$ListsErrorImpl;
}
