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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$FolderLoadingCopyWith<$Res> {
  factory _$$FolderLoadingCopyWith(
          _$FolderLoading value, $Res Function(_$FolderLoading) then) =
      __$$FolderLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FolderLoadingCopyWithImpl<$Res>
    extends _$FolderStateCopyWithImpl<$Res, _$FolderLoading>
    implements _$$FolderLoadingCopyWith<$Res> {
  __$$FolderLoadingCopyWithImpl(
      _$FolderLoading _value, $Res Function(_$FolderLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FolderLoading implements FolderLoading {
  const _$FolderLoading();

  @override
  String toString() {
    return 'FolderState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FolderLoading);
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
  const factory FolderLoading() = _$FolderLoading;
}

/// @nodoc
abstract class _$$FolderLoadedCopyWith<$Res> {
  factory _$$FolderLoadedCopyWith(
          _$FolderLoaded value, $Res Function(_$FolderLoaded) then) =
      __$$FolderLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Folder> lists});
}

/// @nodoc
class __$$FolderLoadedCopyWithImpl<$Res>
    extends _$FolderStateCopyWithImpl<$Res, _$FolderLoaded>
    implements _$$FolderLoadedCopyWith<$Res> {
  __$$FolderLoadedCopyWithImpl(
      _$FolderLoaded _value, $Res Function(_$FolderLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lists = null,
  }) {
    return _then(_$FolderLoaded(
      null == lists
          ? _value._lists
          : lists // ignore: cast_nullable_to_non_nullable
              as List<Folder>,
    ));
  }
}

/// @nodoc

class _$FolderLoaded implements FolderLoaded {
  const _$FolderLoaded(final List<Folder> lists) : _lists = lists;

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FolderLoaded &&
            const DeepCollectionEquality().equals(other._lists, _lists));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_lists));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FolderLoadedCopyWith<_$FolderLoaded> get copyWith =>
      __$$FolderLoadedCopyWithImpl<_$FolderLoaded>(this, _$identity);

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
  const factory FolderLoaded(final List<Folder> lists) = _$FolderLoaded;

  List<Folder> get lists;
  @JsonKey(ignore: true)
  _$$FolderLoadedCopyWith<_$FolderLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FolderListAddedCopyWith<$Res> {
  factory _$$FolderListAddedCopyWith(
          _$FolderListAdded value, $Res Function(_$FolderListAdded) then) =
      __$$FolderListAddedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FolderListAddedCopyWithImpl<$Res>
    extends _$FolderStateCopyWithImpl<$Res, _$FolderListAdded>
    implements _$$FolderListAddedCopyWith<$Res> {
  __$$FolderListAddedCopyWithImpl(
      _$FolderListAdded _value, $Res Function(_$FolderListAdded) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FolderListAdded implements FolderListAdded {
  const _$FolderListAdded();

  @override
  String toString() {
    return 'FolderState.listAdded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FolderListAdded);
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
  const factory FolderListAdded() = _$FolderListAdded;
}

/// @nodoc
abstract class _$$FolderErrorCopyWith<$Res> {
  factory _$$FolderErrorCopyWith(
          _$FolderError value, $Res Function(_$FolderError) then) =
      __$$FolderErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FolderErrorCopyWithImpl<$Res>
    extends _$FolderStateCopyWithImpl<$Res, _$FolderError>
    implements _$$FolderErrorCopyWith<$Res> {
  __$$FolderErrorCopyWithImpl(
      _$FolderError _value, $Res Function(_$FolderError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FolderError implements FolderError {
  const _$FolderError();

  @override
  String toString() {
    return 'FolderState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FolderError);
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
  const factory FolderError() = _$FolderError;
}
