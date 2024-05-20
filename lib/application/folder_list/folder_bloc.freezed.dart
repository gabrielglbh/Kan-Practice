// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'folder_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FolderState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Folder> lists) loaded,
    required TResult Function() listAdded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Folder> lists)? loaded,
    TResult? Function()? listAdded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Folder> lists)? loaded,
    TResult Function()? listAdded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FolderLoading value) loading,
    required TResult Function(FolderLoaded value) loaded,
    required TResult Function(FolderListAdded value) listAdded,
    required TResult Function(FolderError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FolderLoading value)? loading,
    TResult? Function(FolderLoaded value)? loaded,
    TResult? Function(FolderListAdded value)? listAdded,
    TResult? Function(FolderError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FolderLoading value)? loading,
    TResult Function(FolderLoaded value)? loaded,
    TResult Function(FolderListAdded value)? listAdded,
    TResult Function(FolderError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FolderStateCopyWith<$Res> {
  factory $FolderStateCopyWith(
          FolderState value, $Res Function(FolderState) then) =
      _$FolderStateCopyWithImpl<$Res, FolderState>;
}

/// @nodoc
class _$FolderStateCopyWithImpl<$Res, $Val extends FolderState>
    implements $FolderStateCopyWith<$Res> {
  _$FolderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FolderLoadingImplCopyWith<$Res> {
  factory _$$FolderLoadingImplCopyWith(
          _$FolderLoadingImpl value, $Res Function(_$FolderLoadingImpl) then) =
      __$$FolderLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FolderLoadingImplCopyWithImpl<$Res>
    extends _$FolderStateCopyWithImpl<$Res, _$FolderLoadingImpl>
    implements _$$FolderLoadingImplCopyWith<$Res> {
  __$$FolderLoadingImplCopyWithImpl(
      _$FolderLoadingImpl _value, $Res Function(_$FolderLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FolderLoadingImpl implements FolderLoading {
  const _$FolderLoadingImpl();

  @override
  String toString() {
    return 'FolderState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FolderLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Folder> lists) loaded,
    required TResult Function() listAdded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Folder> lists)? loaded,
    TResult? Function()? listAdded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Folder> lists)? loaded,
    TResult Function()? listAdded,
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
    required TResult Function(FolderLoading value) loading,
    required TResult Function(FolderLoaded value) loaded,
    required TResult Function(FolderListAdded value) listAdded,
    required TResult Function(FolderError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FolderLoading value)? loading,
    TResult? Function(FolderLoaded value)? loaded,
    TResult? Function(FolderListAdded value)? listAdded,
    TResult? Function(FolderError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FolderLoading value)? loading,
    TResult Function(FolderLoaded value)? loaded,
    TResult Function(FolderListAdded value)? listAdded,
    TResult Function(FolderError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class FolderLoading implements FolderState {
  const factory FolderLoading() = _$FolderLoadingImpl;
}

/// @nodoc
abstract class _$$FolderLoadedImplCopyWith<$Res> {
  factory _$$FolderLoadedImplCopyWith(
          _$FolderLoadedImpl value, $Res Function(_$FolderLoadedImpl) then) =
      __$$FolderLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Folder> lists});
}

/// @nodoc
class __$$FolderLoadedImplCopyWithImpl<$Res>
    extends _$FolderStateCopyWithImpl<$Res, _$FolderLoadedImpl>
    implements _$$FolderLoadedImplCopyWith<$Res> {
  __$$FolderLoadedImplCopyWithImpl(
      _$FolderLoadedImpl _value, $Res Function(_$FolderLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lists = null,
  }) {
    return _then(_$FolderLoadedImpl(
      null == lists
          ? _value._lists
          : lists // ignore: cast_nullable_to_non_nullable
              as List<Folder>,
    ));
  }
}

/// @nodoc

class _$FolderLoadedImpl implements FolderLoaded {
  const _$FolderLoadedImpl(final List<Folder> lists) : _lists = lists;

  final List<Folder> _lists;
  @override
  List<Folder> get lists {
    if (_lists is EqualUnmodifiableListView) return _lists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lists);
  }

  @override
  String toString() {
    return 'FolderState.loaded(lists: $lists)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FolderLoadedImpl &&
            const DeepCollectionEquality().equals(other._lists, _lists));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_lists));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FolderLoadedImplCopyWith<_$FolderLoadedImpl> get copyWith =>
      __$$FolderLoadedImplCopyWithImpl<_$FolderLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Folder> lists) loaded,
    required TResult Function() listAdded,
    required TResult Function() error,
  }) {
    return loaded(lists);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Folder> lists)? loaded,
    TResult? Function()? listAdded,
    TResult? Function()? error,
  }) {
    return loaded?.call(lists);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Folder> lists)? loaded,
    TResult Function()? listAdded,
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
    required TResult Function(FolderLoading value) loading,
    required TResult Function(FolderLoaded value) loaded,
    required TResult Function(FolderListAdded value) listAdded,
    required TResult Function(FolderError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FolderLoading value)? loading,
    TResult? Function(FolderLoaded value)? loaded,
    TResult? Function(FolderListAdded value)? listAdded,
    TResult? Function(FolderError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FolderLoading value)? loading,
    TResult Function(FolderLoaded value)? loaded,
    TResult Function(FolderListAdded value)? listAdded,
    TResult Function(FolderError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class FolderLoaded implements FolderState {
  const factory FolderLoaded(final List<Folder> lists) = _$FolderLoadedImpl;

  List<Folder> get lists;
  @JsonKey(ignore: true)
  _$$FolderLoadedImplCopyWith<_$FolderLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FolderListAddedImplCopyWith<$Res> {
  factory _$$FolderListAddedImplCopyWith(_$FolderListAddedImpl value,
          $Res Function(_$FolderListAddedImpl) then) =
      __$$FolderListAddedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FolderListAddedImplCopyWithImpl<$Res>
    extends _$FolderStateCopyWithImpl<$Res, _$FolderListAddedImpl>
    implements _$$FolderListAddedImplCopyWith<$Res> {
  __$$FolderListAddedImplCopyWithImpl(
      _$FolderListAddedImpl _value, $Res Function(_$FolderListAddedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FolderListAddedImpl implements FolderListAdded {
  const _$FolderListAddedImpl();

  @override
  String toString() {
    return 'FolderState.listAdded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FolderListAddedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Folder> lists) loaded,
    required TResult Function() listAdded,
    required TResult Function() error,
  }) {
    return listAdded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Folder> lists)? loaded,
    TResult? Function()? listAdded,
    TResult? Function()? error,
  }) {
    return listAdded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Folder> lists)? loaded,
    TResult Function()? listAdded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (listAdded != null) {
      return listAdded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FolderLoading value) loading,
    required TResult Function(FolderLoaded value) loaded,
    required TResult Function(FolderListAdded value) listAdded,
    required TResult Function(FolderError value) error,
  }) {
    return listAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FolderLoading value)? loading,
    TResult? Function(FolderLoaded value)? loaded,
    TResult? Function(FolderListAdded value)? listAdded,
    TResult? Function(FolderError value)? error,
  }) {
    return listAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FolderLoading value)? loading,
    TResult Function(FolderLoaded value)? loaded,
    TResult Function(FolderListAdded value)? listAdded,
    TResult Function(FolderError value)? error,
    required TResult orElse(),
  }) {
    if (listAdded != null) {
      return listAdded(this);
    }
    return orElse();
  }
}

abstract class FolderListAdded implements FolderState {
  const factory FolderListAdded() = _$FolderListAddedImpl;
}

/// @nodoc
abstract class _$$FolderErrorImplCopyWith<$Res> {
  factory _$$FolderErrorImplCopyWith(
          _$FolderErrorImpl value, $Res Function(_$FolderErrorImpl) then) =
      __$$FolderErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FolderErrorImplCopyWithImpl<$Res>
    extends _$FolderStateCopyWithImpl<$Res, _$FolderErrorImpl>
    implements _$$FolderErrorImplCopyWith<$Res> {
  __$$FolderErrorImplCopyWithImpl(
      _$FolderErrorImpl _value, $Res Function(_$FolderErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FolderErrorImpl implements FolderError {
  const _$FolderErrorImpl();

  @override
  String toString() {
    return 'FolderState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FolderErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Folder> lists) loaded,
    required TResult Function() listAdded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Folder> lists)? loaded,
    TResult? Function()? listAdded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Folder> lists)? loaded,
    TResult Function()? listAdded,
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
    required TResult Function(FolderLoading value) loading,
    required TResult Function(FolderLoaded value) loaded,
    required TResult Function(FolderListAdded value) listAdded,
    required TResult Function(FolderError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FolderLoading value)? loading,
    TResult? Function(FolderLoaded value)? loaded,
    TResult? Function(FolderListAdded value)? listAdded,
    TResult? Function(FolderError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FolderLoading value)? loading,
    TResult Function(FolderLoaded value)? loaded,
    TResult Function(FolderListAdded value)? listAdded,
    TResult Function(FolderError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class FolderError implements FolderState {
  const factory FolderError() = _$FolderErrorImpl;
}
