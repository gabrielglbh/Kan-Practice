// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String date) loaded,
    required TResult Function() initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String date)? loaded,
    TResult? Function()? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String date)? loaded,
    TResult Function()? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingsLoading value) loading,
    required TResult Function(SettingsLoaded value) loaded,
    required TResult Function(SettingsInitial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsLoading value)? loading,
    TResult? Function(SettingsLoaded value)? loaded,
    TResult? Function(SettingsInitial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsLoading value)? loading,
    TResult Function(SettingsLoaded value)? loaded,
    TResult Function(SettingsInitial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SettingsLoadingCopyWith<$Res> {
  factory _$$SettingsLoadingCopyWith(
          _$SettingsLoading value, $Res Function(_$SettingsLoading) then) =
      __$$SettingsLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SettingsLoadingCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsLoading>
    implements _$$SettingsLoadingCopyWith<$Res> {
  __$$SettingsLoadingCopyWithImpl(
      _$SettingsLoading _value, $Res Function(_$SettingsLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SettingsLoading implements SettingsLoading {
  const _$SettingsLoading();

  @override
  String toString() {
    return 'SettingsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SettingsLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String date) loaded,
    required TResult Function() initial,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String date)? loaded,
    TResult? Function()? initial,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String date)? loaded,
    TResult Function()? initial,
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
    required TResult Function(SettingsLoading value) loading,
    required TResult Function(SettingsLoaded value) loaded,
    required TResult Function(SettingsInitial value) initial,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsLoading value)? loading,
    TResult? Function(SettingsLoaded value)? loaded,
    TResult? Function(SettingsInitial value)? initial,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsLoading value)? loading,
    TResult Function(SettingsLoaded value)? loaded,
    TResult Function(SettingsInitial value)? initial,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SettingsLoading implements SettingsState {
  const factory SettingsLoading() = _$SettingsLoading;
}

/// @nodoc
abstract class _$$SettingsLoadedCopyWith<$Res> {
  factory _$$SettingsLoadedCopyWith(
          _$SettingsLoaded value, $Res Function(_$SettingsLoaded) then) =
      __$$SettingsLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({String date});
}

/// @nodoc
class __$$SettingsLoadedCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsLoaded>
    implements _$$SettingsLoadedCopyWith<$Res> {
  __$$SettingsLoadedCopyWithImpl(
      _$SettingsLoaded _value, $Res Function(_$SettingsLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
  }) {
    return _then(_$SettingsLoaded(
      null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SettingsLoaded implements SettingsLoaded {
  const _$SettingsLoaded(this.date);

  @override
  final String date;

  @override
  String toString() {
    return 'SettingsState.loaded(date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsLoaded &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsLoadedCopyWith<_$SettingsLoaded> get copyWith =>
      __$$SettingsLoadedCopyWithImpl<_$SettingsLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String date) loaded,
    required TResult Function() initial,
  }) {
    return loaded(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String date)? loaded,
    TResult? Function()? initial,
  }) {
    return loaded?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String date)? loaded,
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SettingsLoading value) loading,
    required TResult Function(SettingsLoaded value) loaded,
    required TResult Function(SettingsInitial value) initial,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsLoading value)? loading,
    TResult? Function(SettingsLoaded value)? loaded,
    TResult? Function(SettingsInitial value)? initial,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsLoading value)? loading,
    TResult Function(SettingsLoaded value)? loaded,
    TResult Function(SettingsInitial value)? initial,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SettingsLoaded implements SettingsState {
  const factory SettingsLoaded(final String date) = _$SettingsLoaded;

  String get date;
  @JsonKey(ignore: true)
  _$$SettingsLoadedCopyWith<_$SettingsLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SettingsInitialCopyWith<$Res> {
  factory _$$SettingsInitialCopyWith(
          _$SettingsInitial value, $Res Function(_$SettingsInitial) then) =
      __$$SettingsInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SettingsInitialCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsInitial>
    implements _$$SettingsInitialCopyWith<$Res> {
  __$$SettingsInitialCopyWithImpl(
      _$SettingsInitial _value, $Res Function(_$SettingsInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SettingsInitial implements SettingsInitial {
  const _$SettingsInitial();

  @override
  String toString() {
    return 'SettingsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SettingsInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String date) loaded,
    required TResult Function() initial,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String date)? loaded,
    TResult? Function()? initial,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String date)? loaded,
    TResult Function()? initial,
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
    required TResult Function(SettingsLoading value) loading,
    required TResult Function(SettingsLoaded value) loaded,
    required TResult Function(SettingsInitial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SettingsLoading value)? loading,
    TResult? Function(SettingsLoaded value)? loaded,
    TResult? Function(SettingsInitial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SettingsLoading value)? loading,
    TResult Function(SettingsLoaded value)? loaded,
    TResult Function(SettingsInitial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SettingsInitial implements SettingsState {
  const factory SettingsInitial() = _$SettingsInitial;
}
