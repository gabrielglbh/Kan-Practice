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
abstract class _$$BackupLoadingCopyWith<$Res> {
  factory _$$BackupLoadingCopyWith(
          _$BackupLoading value, $Res Function(_$BackupLoading) then) =
      __$$BackupLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BackupLoadingCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupLoading>
    implements _$$BackupLoadingCopyWith<$Res> {
  __$$BackupLoadingCopyWithImpl(
      _$BackupLoading _value, $Res Function(_$BackupLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BackupLoading implements BackupLoading {
  const _$BackupLoading();

  @override
  String toString() {
    return 'BackupState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BackupLoading);
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
  const factory BackupLoading() = _$BackupLoading;
}

/// @nodoc
abstract class _$$BackupLoadedCopyWith<$Res> {
  factory _$$BackupLoadedCopyWith(
          _$BackupLoaded value, $Res Function(_$BackupLoaded) then) =
      __$$BackupLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$BackupLoadedCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupLoaded>
    implements _$$BackupLoadedCopyWith<$Res> {
  __$$BackupLoadedCopyWithImpl(
      _$BackupLoaded _value, $Res Function(_$BackupLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$BackupLoaded(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BackupLoaded implements BackupLoaded {
  const _$BackupLoaded(this.message);

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
            other is _$BackupLoaded &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BackupLoadedCopyWith<_$BackupLoaded> get copyWith =>
      __$$BackupLoadedCopyWithImpl<_$BackupLoaded>(this, _$identity);

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
  const factory BackupLoaded(final String message) = _$BackupLoaded;

  String get message;
  @JsonKey(ignore: true)
  _$$BackupLoadedCopyWith<_$BackupLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BackupInitialCopyWith<$Res> {
  factory _$$BackupInitialCopyWith(
          _$BackupInitial value, $Res Function(_$BackupInitial) then) =
      __$$BackupInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BackupInitialCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupInitial>
    implements _$$BackupInitialCopyWith<$Res> {
  __$$BackupInitialCopyWithImpl(
      _$BackupInitial _value, $Res Function(_$BackupInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BackupInitial implements BackupInitial {
  const _$BackupInitial();

  @override
  String toString() {
    return 'BackupState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BackupInitial);
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
  const factory BackupInitial() = _$BackupInitial;
}

/// @nodoc
abstract class _$$BackupErrorCopyWith<$Res> {
  factory _$$BackupErrorCopyWith(
          _$BackupError value, $Res Function(_$BackupError) then) =
      __$$BackupErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$BackupErrorCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupError>
    implements _$$BackupErrorCopyWith<$Res> {
  __$$BackupErrorCopyWithImpl(
      _$BackupError _value, $Res Function(_$BackupError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$BackupError(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BackupError implements BackupError {
  const _$BackupError(this.message);

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
            other is _$BackupError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BackupErrorCopyWith<_$BackupError> get copyWith =>
      __$$BackupErrorCopyWithImpl<_$BackupError>(this, _$identity);

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
  const factory BackupError(final String message) = _$BackupError;

  String get message;
  @JsonKey(ignore: true)
  _$$BackupErrorCopyWith<_$BackupError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BackupVersionRetrievedCopyWith<$Res> {
  factory _$$BackupVersionRetrievedCopyWith(_$BackupVersionRetrieved value,
          $Res Function(_$BackupVersionRetrieved) then) =
      __$$BackupVersionRetrievedCopyWithImpl<$Res>;
  @useResult
  $Res call({String version, List<String> notes});
}

/// @nodoc
class __$$BackupVersionRetrievedCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupVersionRetrieved>
    implements _$$BackupVersionRetrievedCopyWith<$Res> {
  __$$BackupVersionRetrievedCopyWithImpl(_$BackupVersionRetrieved _value,
      $Res Function(_$BackupVersionRetrieved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? notes = null,
  }) {
    return _then(_$BackupVersionRetrieved(
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

class _$BackupVersionRetrieved implements BackupVersionRetrieved {
  const _$BackupVersionRetrieved(this.version, final List<String> notes)
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
            other is _$BackupVersionRetrieved &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._notes, _notes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, version, const DeepCollectionEquality().hash(_notes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BackupVersionRetrievedCopyWith<_$BackupVersionRetrieved> get copyWith =>
      __$$BackupVersionRetrievedCopyWithImpl<_$BackupVersionRetrieved>(
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
      _$BackupVersionRetrieved;

  String get version;
  List<String> get notes;
  @JsonKey(ignore: true)
  _$$BackupVersionRetrievedCopyWith<_$BackupVersionRetrieved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BackupNotesRetrievedCopyWith<$Res> {
  factory _$$BackupNotesRetrievedCopyWith(_$BackupNotesRetrieved value,
          $Res Function(_$BackupNotesRetrieved) then) =
      __$$BackupNotesRetrievedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> notes});
}

/// @nodoc
class __$$BackupNotesRetrievedCopyWithImpl<$Res>
    extends _$BackupStateCopyWithImpl<$Res, _$BackupNotesRetrieved>
    implements _$$BackupNotesRetrievedCopyWith<$Res> {
  __$$BackupNotesRetrievedCopyWithImpl(_$BackupNotesRetrieved _value,
      $Res Function(_$BackupNotesRetrieved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
  }) {
    return _then(_$BackupNotesRetrieved(
      null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$BackupNotesRetrieved implements BackupNotesRetrieved {
  const _$BackupNotesRetrieved(final List<String> notes) : _notes = notes;

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
            other is _$BackupNotesRetrieved &&
            const DeepCollectionEquality().equals(other._notes, _notes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_notes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BackupNotesRetrievedCopyWith<_$BackupNotesRetrieved> get copyWith =>
      __$$BackupNotesRetrievedCopyWithImpl<_$BackupNotesRetrieved>(
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
      _$BackupNotesRetrieved;

  List<String> get notes;
  @JsonKey(ignore: true)
  _$$BackupNotesRetrievedCopyWith<_$BackupNotesRetrieved> get copyWith =>
      throw _privateConstructorUsedError;
}
