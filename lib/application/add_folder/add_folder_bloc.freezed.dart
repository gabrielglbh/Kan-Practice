// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_folder_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddFolderState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() initial,
    required TResult Function(
            List<WordList> lists, Map<String, bool> alreadyAdded)
        loadedLists,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? initial,
    TResult? Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? initial,
    TResult Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddFolderLoading value) loading,
    required TResult Function(AddFolderLoaded value) loaded,
    required TResult Function(AddFolderInitial value) initial,
    required TResult Function(AddFolderLoadedLists value) loadedLists,
    required TResult Function(AddFolderError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddFolderLoading value)? loading,
    TResult? Function(AddFolderLoaded value)? loaded,
    TResult? Function(AddFolderInitial value)? initial,
    TResult? Function(AddFolderLoadedLists value)? loadedLists,
    TResult? Function(AddFolderError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddFolderLoading value)? loading,
    TResult Function(AddFolderLoaded value)? loaded,
    TResult Function(AddFolderInitial value)? initial,
    TResult Function(AddFolderLoadedLists value)? loadedLists,
    TResult Function(AddFolderError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddFolderStateCopyWith<$Res> {
  factory $AddFolderStateCopyWith(
          AddFolderState value, $Res Function(AddFolderState) then) =
      _$AddFolderStateCopyWithImpl<$Res, AddFolderState>;
}

/// @nodoc
class _$AddFolderStateCopyWithImpl<$Res, $Val extends AddFolderState>
    implements $AddFolderStateCopyWith<$Res> {
  _$AddFolderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AddFolderLoadingImplCopyWith<$Res> {
  factory _$$AddFolderLoadingImplCopyWith(_$AddFolderLoadingImpl value,
          $Res Function(_$AddFolderLoadingImpl) then) =
      __$$AddFolderLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddFolderLoadingImplCopyWithImpl<$Res>
    extends _$AddFolderStateCopyWithImpl<$Res, _$AddFolderLoadingImpl>
    implements _$$AddFolderLoadingImplCopyWith<$Res> {
  __$$AddFolderLoadingImplCopyWithImpl(_$AddFolderLoadingImpl _value,
      $Res Function(_$AddFolderLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AddFolderLoadingImpl implements AddFolderLoading {
  const _$AddFolderLoadingImpl();

  @override
  String toString() {
    return 'AddFolderState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddFolderLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() initial,
    required TResult Function(
            List<WordList> lists, Map<String, bool> alreadyAdded)
        loadedLists,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? initial,
    TResult? Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? initial,
    TResult Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult Function(String message)? error,
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
    required TResult Function(AddFolderLoading value) loading,
    required TResult Function(AddFolderLoaded value) loaded,
    required TResult Function(AddFolderInitial value) initial,
    required TResult Function(AddFolderLoadedLists value) loadedLists,
    required TResult Function(AddFolderError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddFolderLoading value)? loading,
    TResult? Function(AddFolderLoaded value)? loaded,
    TResult? Function(AddFolderInitial value)? initial,
    TResult? Function(AddFolderLoadedLists value)? loadedLists,
    TResult? Function(AddFolderError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddFolderLoading value)? loading,
    TResult Function(AddFolderLoaded value)? loaded,
    TResult Function(AddFolderInitial value)? initial,
    TResult Function(AddFolderLoadedLists value)? loadedLists,
    TResult Function(AddFolderError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AddFolderLoading implements AddFolderState {
  const factory AddFolderLoading() = _$AddFolderLoadingImpl;
}

/// @nodoc
abstract class _$$AddFolderLoadedImplCopyWith<$Res> {
  factory _$$AddFolderLoadedImplCopyWith(_$AddFolderLoadedImpl value,
          $Res Function(_$AddFolderLoadedImpl) then) =
      __$$AddFolderLoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddFolderLoadedImplCopyWithImpl<$Res>
    extends _$AddFolderStateCopyWithImpl<$Res, _$AddFolderLoadedImpl>
    implements _$$AddFolderLoadedImplCopyWith<$Res> {
  __$$AddFolderLoadedImplCopyWithImpl(
      _$AddFolderLoadedImpl _value, $Res Function(_$AddFolderLoadedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AddFolderLoadedImpl implements AddFolderLoaded {
  const _$AddFolderLoadedImpl();

  @override
  String toString() {
    return 'AddFolderState.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddFolderLoadedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() initial,
    required TResult Function(
            List<WordList> lists, Map<String, bool> alreadyAdded)
        loadedLists,
    required TResult Function(String message) error,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? initial,
    TResult? Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? initial,
    TResult Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddFolderLoading value) loading,
    required TResult Function(AddFolderLoaded value) loaded,
    required TResult Function(AddFolderInitial value) initial,
    required TResult Function(AddFolderLoadedLists value) loadedLists,
    required TResult Function(AddFolderError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddFolderLoading value)? loading,
    TResult? Function(AddFolderLoaded value)? loaded,
    TResult? Function(AddFolderInitial value)? initial,
    TResult? Function(AddFolderLoadedLists value)? loadedLists,
    TResult? Function(AddFolderError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddFolderLoading value)? loading,
    TResult Function(AddFolderLoaded value)? loaded,
    TResult Function(AddFolderInitial value)? initial,
    TResult Function(AddFolderLoadedLists value)? loadedLists,
    TResult Function(AddFolderError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AddFolderLoaded implements AddFolderState {
  const factory AddFolderLoaded() = _$AddFolderLoadedImpl;
}

/// @nodoc
abstract class _$$AddFolderInitialImplCopyWith<$Res> {
  factory _$$AddFolderInitialImplCopyWith(_$AddFolderInitialImpl value,
          $Res Function(_$AddFolderInitialImpl) then) =
      __$$AddFolderInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddFolderInitialImplCopyWithImpl<$Res>
    extends _$AddFolderStateCopyWithImpl<$Res, _$AddFolderInitialImpl>
    implements _$$AddFolderInitialImplCopyWith<$Res> {
  __$$AddFolderInitialImplCopyWithImpl(_$AddFolderInitialImpl _value,
      $Res Function(_$AddFolderInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AddFolderInitialImpl implements AddFolderInitial {
  const _$AddFolderInitialImpl();

  @override
  String toString() {
    return 'AddFolderState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddFolderInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() initial,
    required TResult Function(
            List<WordList> lists, Map<String, bool> alreadyAdded)
        loadedLists,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? initial,
    TResult? Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? initial,
    TResult Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult Function(String message)? error,
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
    required TResult Function(AddFolderLoading value) loading,
    required TResult Function(AddFolderLoaded value) loaded,
    required TResult Function(AddFolderInitial value) initial,
    required TResult Function(AddFolderLoadedLists value) loadedLists,
    required TResult Function(AddFolderError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddFolderLoading value)? loading,
    TResult? Function(AddFolderLoaded value)? loaded,
    TResult? Function(AddFolderInitial value)? initial,
    TResult? Function(AddFolderLoadedLists value)? loadedLists,
    TResult? Function(AddFolderError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddFolderLoading value)? loading,
    TResult Function(AddFolderLoaded value)? loaded,
    TResult Function(AddFolderInitial value)? initial,
    TResult Function(AddFolderLoadedLists value)? loadedLists,
    TResult Function(AddFolderError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AddFolderInitial implements AddFolderState {
  const factory AddFolderInitial() = _$AddFolderInitialImpl;
}

/// @nodoc
abstract class _$$AddFolderLoadedListsImplCopyWith<$Res> {
  factory _$$AddFolderLoadedListsImplCopyWith(_$AddFolderLoadedListsImpl value,
          $Res Function(_$AddFolderLoadedListsImpl) then) =
      __$$AddFolderLoadedListsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<WordList> lists, Map<String, bool> alreadyAdded});
}

/// @nodoc
class __$$AddFolderLoadedListsImplCopyWithImpl<$Res>
    extends _$AddFolderStateCopyWithImpl<$Res, _$AddFolderLoadedListsImpl>
    implements _$$AddFolderLoadedListsImplCopyWith<$Res> {
  __$$AddFolderLoadedListsImplCopyWithImpl(_$AddFolderLoadedListsImpl _value,
      $Res Function(_$AddFolderLoadedListsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lists = null,
    Object? alreadyAdded = null,
  }) {
    return _then(_$AddFolderLoadedListsImpl(
      null == lists
          ? _value._lists
          : lists // ignore: cast_nullable_to_non_nullable
              as List<WordList>,
      null == alreadyAdded
          ? _value._alreadyAdded
          : alreadyAdded // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ));
  }
}

/// @nodoc

class _$AddFolderLoadedListsImpl implements AddFolderLoadedLists {
  const _$AddFolderLoadedListsImpl(
      final List<WordList> lists, final Map<String, bool> alreadyAdded)
      : _lists = lists,
        _alreadyAdded = alreadyAdded;

  final List<WordList> _lists;
  @override
  List<WordList> get lists {
    if (_lists is EqualUnmodifiableListView) return _lists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lists);
  }

  final Map<String, bool> _alreadyAdded;
  @override
  Map<String, bool> get alreadyAdded {
    if (_alreadyAdded is EqualUnmodifiableMapView) return _alreadyAdded;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_alreadyAdded);
  }

  @override
  String toString() {
    return 'AddFolderState.loadedLists(lists: $lists, alreadyAdded: $alreadyAdded)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddFolderLoadedListsImpl &&
            const DeepCollectionEquality().equals(other._lists, _lists) &&
            const DeepCollectionEquality()
                .equals(other._alreadyAdded, _alreadyAdded));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_lists),
      const DeepCollectionEquality().hash(_alreadyAdded));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddFolderLoadedListsImplCopyWith<_$AddFolderLoadedListsImpl>
      get copyWith =>
          __$$AddFolderLoadedListsImplCopyWithImpl<_$AddFolderLoadedListsImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() initial,
    required TResult Function(
            List<WordList> lists, Map<String, bool> alreadyAdded)
        loadedLists,
    required TResult Function(String message) error,
  }) {
    return loadedLists(lists, alreadyAdded);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? initial,
    TResult? Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult? Function(String message)? error,
  }) {
    return loadedLists?.call(lists, alreadyAdded);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? initial,
    TResult Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loadedLists != null) {
      return loadedLists(lists, alreadyAdded);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddFolderLoading value) loading,
    required TResult Function(AddFolderLoaded value) loaded,
    required TResult Function(AddFolderInitial value) initial,
    required TResult Function(AddFolderLoadedLists value) loadedLists,
    required TResult Function(AddFolderError value) error,
  }) {
    return loadedLists(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddFolderLoading value)? loading,
    TResult? Function(AddFolderLoaded value)? loaded,
    TResult? Function(AddFolderInitial value)? initial,
    TResult? Function(AddFolderLoadedLists value)? loadedLists,
    TResult? Function(AddFolderError value)? error,
  }) {
    return loadedLists?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddFolderLoading value)? loading,
    TResult Function(AddFolderLoaded value)? loaded,
    TResult Function(AddFolderInitial value)? initial,
    TResult Function(AddFolderLoadedLists value)? loadedLists,
    TResult Function(AddFolderError value)? error,
    required TResult orElse(),
  }) {
    if (loadedLists != null) {
      return loadedLists(this);
    }
    return orElse();
  }
}

abstract class AddFolderLoadedLists implements AddFolderState {
  const factory AddFolderLoadedLists(
          final List<WordList> lists, final Map<String, bool> alreadyAdded) =
      _$AddFolderLoadedListsImpl;

  List<WordList> get lists;
  Map<String, bool> get alreadyAdded;
  @JsonKey(ignore: true)
  _$$AddFolderLoadedListsImplCopyWith<_$AddFolderLoadedListsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddFolderErrorImplCopyWith<$Res> {
  factory _$$AddFolderErrorImplCopyWith(_$AddFolderErrorImpl value,
          $Res Function(_$AddFolderErrorImpl) then) =
      __$$AddFolderErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AddFolderErrorImplCopyWithImpl<$Res>
    extends _$AddFolderStateCopyWithImpl<$Res, _$AddFolderErrorImpl>
    implements _$$AddFolderErrorImplCopyWith<$Res> {
  __$$AddFolderErrorImplCopyWithImpl(
      _$AddFolderErrorImpl _value, $Res Function(_$AddFolderErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AddFolderErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddFolderErrorImpl implements AddFolderError {
  const _$AddFolderErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AddFolderState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddFolderErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddFolderErrorImplCopyWith<_$AddFolderErrorImpl> get copyWith =>
      __$$AddFolderErrorImplCopyWithImpl<_$AddFolderErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() initial,
    required TResult Function(
            List<WordList> lists, Map<String, bool> alreadyAdded)
        loadedLists,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? initial,
    TResult? Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? initial,
    TResult Function(List<WordList> lists, Map<String, bool> alreadyAdded)?
        loadedLists,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddFolderLoading value) loading,
    required TResult Function(AddFolderLoaded value) loaded,
    required TResult Function(AddFolderInitial value) initial,
    required TResult Function(AddFolderLoadedLists value) loadedLists,
    required TResult Function(AddFolderError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddFolderLoading value)? loading,
    TResult? Function(AddFolderLoaded value)? loaded,
    TResult? Function(AddFolderInitial value)? initial,
    TResult? Function(AddFolderLoadedLists value)? loadedLists,
    TResult? Function(AddFolderError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddFolderLoading value)? loading,
    TResult Function(AddFolderLoaded value)? loaded,
    TResult Function(AddFolderInitial value)? initial,
    TResult Function(AddFolderLoadedLists value)? loadedLists,
    TResult Function(AddFolderError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AddFolderError implements AddFolderState {
  const factory AddFolderError(final String message) = _$AddFolderErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$AddFolderErrorImplCopyWith<_$AddFolderErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
