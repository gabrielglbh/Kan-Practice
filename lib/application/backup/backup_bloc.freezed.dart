// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BackupState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) loaded,
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String version, List<String> notes)
        versionRetrieved,
    required TResult Function(List<String> notes) notesRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? loaded,
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String version, List<String> notes)? versionRetrieved,
    TResult? Function(List<String> notes)? notesRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? loaded,
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String version, List<String> notes)? versionRetrieved,
    TResult Function(List<String> notes)? notesRetrieved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BackupLoading value) loading,
    required TResult Function(BackupLoaded value) loaded,
    required TResult Function(BackupInitial value) initial,
    required TResult Function(BackupError value) error,
    required TResult Function(BackupVersionRetrieved value) versionRetrieved,
    required TResult Function(BackupNotesRetrieved value) notesRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BackupLoading value)? loading,
    TResult? Function(BackupLoaded value)? loaded,
    TResult? Function(BackupInitial value)? initial,
    TResult? Function(BackupError value)? error,
    TResult? Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult? Function(BackupNotesRetrieved value)? notesRetrieved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BackupLoading value)? loading,
    TResult Function(BackupLoaded value)? loaded,
    TResult Function(BackupInitial value)? initial,
    TResult Function(BackupError value)? error,
    TResult Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult Function(BackupNotesRetrieved value)? notesRetrieved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackupStateCopyWith<$Res> {
  factory $BackupStateCopyWith(
          BackupState value, $Res Function(BackupState) then) =
      _$BackupStateCopyWithImpl<$Res, BackupState>;
}

/// @nodoc
class _$BackupStateCopyWithImpl<$Res, $Val extends BackupState>
    implements $BackupStateCopyWith<$Res> {
  _$BackupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BackupLoadingImplCopyWith<$Res> {
  factory _$$BackupLoadingImplCopyWith(
          _$BackupLoadingImpl value, $Res Function(_$BackupLoadingImpl) then) =
      __$$BackupLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BackupLoadingImplCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupLoadingImpl>
    implements _$$BackupLoadingImplCopyWith<$Res> {
  __$$BackupLoadingImplCopyWithImpl(
      _$BackupLoadingImpl _value, $Res Function(_$BackupLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BackupLoadingImpl implements BackupLoading {
  const _$BackupLoadingImpl();

  @override
  String toString() {
    return 'BackupState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BackupLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) loaded,
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String version, List<String> notes)
        versionRetrieved,
    required TResult Function(List<String> notes) notesRetrieved,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? loaded,
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String version, List<String> notes)? versionRetrieved,
    TResult? Function(List<String> notes)? notesRetrieved,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? loaded,
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String version, List<String> notes)? versionRetrieved,
    TResult Function(List<String> notes)? notesRetrieved,
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
    required TResult Function(BackupLoading value) loading,
    required TResult Function(BackupLoaded value) loaded,
    required TResult Function(BackupInitial value) initial,
    required TResult Function(BackupError value) error,
    required TResult Function(BackupVersionRetrieved value) versionRetrieved,
    required TResult Function(BackupNotesRetrieved value) notesRetrieved,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BackupLoading value)? loading,
    TResult? Function(BackupLoaded value)? loaded,
    TResult? Function(BackupInitial value)? initial,
    TResult? Function(BackupError value)? error,
    TResult? Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult? Function(BackupNotesRetrieved value)? notesRetrieved,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BackupLoading value)? loading,
    TResult Function(BackupLoaded value)? loaded,
    TResult Function(BackupInitial value)? initial,
    TResult Function(BackupError value)? error,
    TResult Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult Function(BackupNotesRetrieved value)? notesRetrieved,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BackupLoading implements BackupState {
  const factory BackupLoading() = _$BackupLoadingImpl;
}

/// @nodoc
abstract class _$$BackupLoadedImplCopyWith<$Res> {
  factory _$$BackupLoadedImplCopyWith(
          _$BackupLoadedImpl value, $Res Function(_$BackupLoadedImpl) then) =
      __$$BackupLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$BackupLoadedImplCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupLoadedImpl>
    implements _$$BackupLoadedImplCopyWith<$Res> {
  __$$BackupLoadedImplCopyWithImpl(
      _$BackupLoadedImpl _value, $Res Function(_$BackupLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$BackupLoadedImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BackupLoadedImpl implements BackupLoaded {
  const _$BackupLoadedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BackupState.loaded(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackupLoadedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BackupLoadedImplCopyWith<_$BackupLoadedImpl> get copyWith =>
      __$$BackupLoadedImplCopyWithImpl<_$BackupLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) loaded,
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String version, List<String> notes)
        versionRetrieved,
    required TResult Function(List<String> notes) notesRetrieved,
  }) {
    return loaded(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? loaded,
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String version, List<String> notes)? versionRetrieved,
    TResult? Function(List<String> notes)? notesRetrieved,
  }) {
    return loaded?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? loaded,
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String version, List<String> notes)? versionRetrieved,
    TResult Function(List<String> notes)? notesRetrieved,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BackupLoading value) loading,
    required TResult Function(BackupLoaded value) loaded,
    required TResult Function(BackupInitial value) initial,
    required TResult Function(BackupError value) error,
    required TResult Function(BackupVersionRetrieved value) versionRetrieved,
    required TResult Function(BackupNotesRetrieved value) notesRetrieved,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BackupLoading value)? loading,
    TResult? Function(BackupLoaded value)? loaded,
    TResult? Function(BackupInitial value)? initial,
    TResult? Function(BackupError value)? error,
    TResult? Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult? Function(BackupNotesRetrieved value)? notesRetrieved,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BackupLoading value)? loading,
    TResult Function(BackupLoaded value)? loaded,
    TResult Function(BackupInitial value)? initial,
    TResult Function(BackupError value)? error,
    TResult Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult Function(BackupNotesRetrieved value)? notesRetrieved,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BackupLoaded implements BackupState {
  const factory BackupLoaded(final String message) = _$BackupLoadedImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$BackupLoadedImplCopyWith<_$BackupLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BackupInitialImplCopyWith<$Res> {
  factory _$$BackupInitialImplCopyWith(
          _$BackupInitialImpl value, $Res Function(_$BackupInitialImpl) then) =
      __$$BackupInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BackupInitialImplCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupInitialImpl>
    implements _$$BackupInitialImplCopyWith<$Res> {
  __$$BackupInitialImplCopyWithImpl(
      _$BackupInitialImpl _value, $Res Function(_$BackupInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BackupInitialImpl implements BackupInitial {
  const _$BackupInitialImpl();

  @override
  String toString() {
    return 'BackupState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BackupInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) loaded,
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String version, List<String> notes)
        versionRetrieved,
    required TResult Function(List<String> notes) notesRetrieved,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? loaded,
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String version, List<String> notes)? versionRetrieved,
    TResult? Function(List<String> notes)? notesRetrieved,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? loaded,
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String version, List<String> notes)? versionRetrieved,
    TResult Function(List<String> notes)? notesRetrieved,
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
    required TResult Function(BackupLoading value) loading,
    required TResult Function(BackupLoaded value) loaded,
    required TResult Function(BackupInitial value) initial,
    required TResult Function(BackupError value) error,
    required TResult Function(BackupVersionRetrieved value) versionRetrieved,
    required TResult Function(BackupNotesRetrieved value) notesRetrieved,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BackupLoading value)? loading,
    TResult? Function(BackupLoaded value)? loaded,
    TResult? Function(BackupInitial value)? initial,
    TResult? Function(BackupError value)? error,
    TResult? Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult? Function(BackupNotesRetrieved value)? notesRetrieved,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BackupLoading value)? loading,
    TResult Function(BackupLoaded value)? loaded,
    TResult Function(BackupInitial value)? initial,
    TResult Function(BackupError value)? error,
    TResult Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult Function(BackupNotesRetrieved value)? notesRetrieved,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BackupInitial implements BackupState {
  const factory BackupInitial() = _$BackupInitialImpl;
}

/// @nodoc
abstract class _$$BackupErrorImplCopyWith<$Res> {
  factory _$$BackupErrorImplCopyWith(
          _$BackupErrorImpl value, $Res Function(_$BackupErrorImpl) then) =
      __$$BackupErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$BackupErrorImplCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupErrorImpl>
    implements _$$BackupErrorImplCopyWith<$Res> {
  __$$BackupErrorImplCopyWithImpl(
      _$BackupErrorImpl _value, $Res Function(_$BackupErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$BackupErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BackupErrorImpl implements BackupError {
  const _$BackupErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BackupState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackupErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BackupErrorImplCopyWith<_$BackupErrorImpl> get copyWith =>
      __$$BackupErrorImplCopyWithImpl<_$BackupErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) loaded,
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String version, List<String> notes)
        versionRetrieved,
    required TResult Function(List<String> notes) notesRetrieved,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? loaded,
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String version, List<String> notes)? versionRetrieved,
    TResult? Function(List<String> notes)? notesRetrieved,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? loaded,
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String version, List<String> notes)? versionRetrieved,
    TResult Function(List<String> notes)? notesRetrieved,
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
    required TResult Function(BackupLoading value) loading,
    required TResult Function(BackupLoaded value) loaded,
    required TResult Function(BackupInitial value) initial,
    required TResult Function(BackupError value) error,
    required TResult Function(BackupVersionRetrieved value) versionRetrieved,
    required TResult Function(BackupNotesRetrieved value) notesRetrieved,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BackupLoading value)? loading,
    TResult? Function(BackupLoaded value)? loaded,
    TResult? Function(BackupInitial value)? initial,
    TResult? Function(BackupError value)? error,
    TResult? Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult? Function(BackupNotesRetrieved value)? notesRetrieved,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BackupLoading value)? loading,
    TResult Function(BackupLoaded value)? loaded,
    TResult Function(BackupInitial value)? initial,
    TResult Function(BackupError value)? error,
    TResult Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult Function(BackupNotesRetrieved value)? notesRetrieved,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BackupError implements BackupState {
  const factory BackupError(final String message) = _$BackupErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$BackupErrorImplCopyWith<_$BackupErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BackupVersionRetrievedImplCopyWith<$Res> {
  factory _$$BackupVersionRetrievedImplCopyWith(
          _$BackupVersionRetrievedImpl value,
          $Res Function(_$BackupVersionRetrievedImpl) then) =
      __$$BackupVersionRetrievedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String version, List<String> notes});
}

/// @nodoc
class __$$BackupVersionRetrievedImplCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupVersionRetrievedImpl>
    implements _$$BackupVersionRetrievedImplCopyWith<$Res> {
  __$$BackupVersionRetrievedImplCopyWithImpl(
      _$BackupVersionRetrievedImpl _value,
      $Res Function(_$BackupVersionRetrievedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? notes = null,
  }) {
    return _then(_$BackupVersionRetrievedImpl(
      null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$BackupVersionRetrievedImpl implements BackupVersionRetrieved {
  const _$BackupVersionRetrievedImpl(this.version, final List<String> notes)
      : _notes = notes;

  @override
  final String version;
  final List<String> _notes;
  @override
  List<String> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  String toString() {
    return 'BackupState.versionRetrieved(version: $version, notes: $notes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackupVersionRetrievedImpl &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._notes, _notes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, version, const DeepCollectionEquality().hash(_notes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BackupVersionRetrievedImplCopyWith<_$BackupVersionRetrievedImpl>
      get copyWith => __$$BackupVersionRetrievedImplCopyWithImpl<
          _$BackupVersionRetrievedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) loaded,
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String version, List<String> notes)
        versionRetrieved,
    required TResult Function(List<String> notes) notesRetrieved,
  }) {
    return versionRetrieved(version, notes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? loaded,
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String version, List<String> notes)? versionRetrieved,
    TResult? Function(List<String> notes)? notesRetrieved,
  }) {
    return versionRetrieved?.call(version, notes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? loaded,
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String version, List<String> notes)? versionRetrieved,
    TResult Function(List<String> notes)? notesRetrieved,
    required TResult orElse(),
  }) {
    if (versionRetrieved != null) {
      return versionRetrieved(version, notes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BackupLoading value) loading,
    required TResult Function(BackupLoaded value) loaded,
    required TResult Function(BackupInitial value) initial,
    required TResult Function(BackupError value) error,
    required TResult Function(BackupVersionRetrieved value) versionRetrieved,
    required TResult Function(BackupNotesRetrieved value) notesRetrieved,
  }) {
    return versionRetrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BackupLoading value)? loading,
    TResult? Function(BackupLoaded value)? loaded,
    TResult? Function(BackupInitial value)? initial,
    TResult? Function(BackupError value)? error,
    TResult? Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult? Function(BackupNotesRetrieved value)? notesRetrieved,
  }) {
    return versionRetrieved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BackupLoading value)? loading,
    TResult Function(BackupLoaded value)? loaded,
    TResult Function(BackupInitial value)? initial,
    TResult Function(BackupError value)? error,
    TResult Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult Function(BackupNotesRetrieved value)? notesRetrieved,
    required TResult orElse(),
  }) {
    if (versionRetrieved != null) {
      return versionRetrieved(this);
    }
    return orElse();
  }
}

abstract class BackupVersionRetrieved implements BackupState {
  const factory BackupVersionRetrieved(
          final String version, final List<String> notes) =
      _$BackupVersionRetrievedImpl;

  String get version;
  List<String> get notes;
  @JsonKey(ignore: true)
  _$$BackupVersionRetrievedImplCopyWith<_$BackupVersionRetrievedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BackupNotesRetrievedImplCopyWith<$Res> {
  factory _$$BackupNotesRetrievedImplCopyWith(_$BackupNotesRetrievedImpl value,
          $Res Function(_$BackupNotesRetrievedImpl) then) =
      __$$BackupNotesRetrievedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> notes});
}

/// @nodoc
class __$$BackupNotesRetrievedImplCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupNotesRetrievedImpl>
    implements _$$BackupNotesRetrievedImplCopyWith<$Res> {
  __$$BackupNotesRetrievedImplCopyWithImpl(_$BackupNotesRetrievedImpl _value,
      $Res Function(_$BackupNotesRetrievedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
  }) {
    return _then(_$BackupNotesRetrievedImpl(
      null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$BackupNotesRetrievedImpl implements BackupNotesRetrieved {
  const _$BackupNotesRetrievedImpl(final List<String> notes) : _notes = notes;

  final List<String> _notes;
  @override
  List<String> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  String toString() {
    return 'BackupState.notesRetrieved(notes: $notes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BackupNotesRetrievedImpl &&
            const DeepCollectionEquality().equals(other._notes, _notes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_notes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BackupNotesRetrievedImplCopyWith<_$BackupNotesRetrievedImpl>
      get copyWith =>
          __$$BackupNotesRetrievedImplCopyWithImpl<_$BackupNotesRetrievedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String message) loaded,
    required TResult Function() initial,
    required TResult Function(String message) error,
    required TResult Function(String version, List<String> notes)
        versionRetrieved,
    required TResult Function(List<String> notes) notesRetrieved,
  }) {
    return notesRetrieved(notes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String message)? loaded,
    TResult? Function()? initial,
    TResult? Function(String message)? error,
    TResult? Function(String version, List<String> notes)? versionRetrieved,
    TResult? Function(List<String> notes)? notesRetrieved,
  }) {
    return notesRetrieved?.call(notes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String message)? loaded,
    TResult Function()? initial,
    TResult Function(String message)? error,
    TResult Function(String version, List<String> notes)? versionRetrieved,
    TResult Function(List<String> notes)? notesRetrieved,
    required TResult orElse(),
  }) {
    if (notesRetrieved != null) {
      return notesRetrieved(notes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BackupLoading value) loading,
    required TResult Function(BackupLoaded value) loaded,
    required TResult Function(BackupInitial value) initial,
    required TResult Function(BackupError value) error,
    required TResult Function(BackupVersionRetrieved value) versionRetrieved,
    required TResult Function(BackupNotesRetrieved value) notesRetrieved,
  }) {
    return notesRetrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BackupLoading value)? loading,
    TResult? Function(BackupLoaded value)? loaded,
    TResult? Function(BackupInitial value)? initial,
    TResult? Function(BackupError value)? error,
    TResult? Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult? Function(BackupNotesRetrieved value)? notesRetrieved,
  }) {
    return notesRetrieved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BackupLoading value)? loading,
    TResult Function(BackupLoaded value)? loaded,
    TResult Function(BackupInitial value)? initial,
    TResult Function(BackupError value)? error,
    TResult Function(BackupVersionRetrieved value)? versionRetrieved,
    TResult Function(BackupNotesRetrieved value)? notesRetrieved,
    required TResult orElse(),
  }) {
    if (notesRetrieved != null) {
      return notesRetrieved(this);
    }
    return orElse();
  }
}

abstract class BackupNotesRetrieved implements BackupState {
  const factory BackupNotesRetrieved(final List<String> notes) =
      _$BackupNotesRetrievedImpl;

  List<String> get notes;
  @JsonKey(ignore: true)
  _$$BackupNotesRetrievedImplCopyWith<_$BackupNotesRetrievedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
