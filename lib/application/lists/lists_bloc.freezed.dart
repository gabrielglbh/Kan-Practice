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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$ListsLoadedCopyWith<$Res> {
  factory _$$ListsLoadedCopyWith(
          _$ListsLoaded value, $Res Function(_$ListsLoaded) then) =
      __$$ListsLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<WordList> lists});
}

/// @nodoc
class __$$ListsLoadedCopyWithImpl<$Res>
    extends _$ListsStateCopyWithImpl<$Res, _$ListsLoaded>
    implements _$$ListsLoadedCopyWith<$Res> {
  __$$ListsLoadedCopyWithImpl(
      _$ListsLoaded _value, $Res Function(_$ListsLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lists = null,
  }) {
    return _then(_$ListsLoaded(
      null == lists
          ? _value._lists
          : lists // ignore: cast_nullable_to_non_nullable
              as List<WordList>,
    ));
  }
}

/// @nodoc

class _$ListsLoaded implements ListsLoaded {
  const _$ListsLoaded(final List<WordList> lists) : _lists = lists;

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListsLoaded &&
            const DeepCollectionEquality().equals(other._lists, _lists));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_lists));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListsLoadedCopyWith<_$ListsLoaded> get copyWith =>
      __$$ListsLoadedCopyWithImpl<_$ListsLoaded>(this, _$identity);

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
  const factory ListsLoaded(final List<WordList> lists) = _$ListsLoaded;

  List<WordList> get lists;
  @JsonKey(ignore: true)
  _$$ListsLoadedCopyWith<_$ListsLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListsLoadingCopyWith<$Res> {
  factory _$$ListsLoadingCopyWith(
          _$ListsLoading value, $Res Function(_$ListsLoading) then) =
      __$$ListsLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListsLoadingCopyWithImpl<$Res>
    extends _$ListsStateCopyWithImpl<$Res, _$ListsLoading>
    implements _$$ListsLoadingCopyWith<$Res> {
  __$$ListsLoadingCopyWithImpl(
      _$ListsLoading _value, $Res Function(_$ListsLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListsLoading implements ListsLoading {
  const _$ListsLoading();

  @override
  String toString() {
    return 'ListsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListsLoading);
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
  const factory ListsLoading() = _$ListsLoading;
}

/// @nodoc
abstract class _$$ListsErrorCopyWith<$Res> {
  factory _$$ListsErrorCopyWith(
          _$ListsError value, $Res Function(_$ListsError) then) =
      __$$ListsErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListsErrorCopyWithImpl<$Res>
    extends _$ListsStateCopyWithImpl<$Res, _$ListsError>
    implements _$$ListsErrorCopyWith<$Res> {
  __$$ListsErrorCopyWithImpl(
      _$ListsError _value, $Res Function(_$ListsError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ListsError implements ListsError {
  const _$ListsError();

  @override
  String toString() {
    return 'ListsState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListsError);
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
  const factory ListsError() = _$ListsError;
}
