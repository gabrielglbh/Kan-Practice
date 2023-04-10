// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StatsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(KanPracticeStats stats) loaded,
    required TResult Function() loading,
    required TResult Function() initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(KanPracticeStats stats)? loaded,
    TResult? Function()? loading,
    TResult? Function()? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(KanPracticeStats stats)? loaded,
    TResult Function()? loading,
    TResult Function()? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StatsLoaded value) loaded,
    required TResult Function(StatsLoading value) loading,
    required TResult Function(StatsInitial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StatsLoaded value)? loaded,
    TResult? Function(StatsLoading value)? loading,
    TResult? Function(StatsInitial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StatsLoaded value)? loaded,
    TResult Function(StatsLoading value)? loading,
    TResult Function(StatsInitial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatsStateCopyWith<$Res> {
  factory $StatsStateCopyWith(
          StatsState value, $Res Function(StatsState) then) =
      _$StatsStateCopyWithImpl<$Res, StatsState>;
}

/// @nodoc
class _$StatsStateCopyWithImpl<$Res, $Val extends StatsState>
    implements $StatsStateCopyWith<$Res> {
  _$StatsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StatsLoadedCopyWith<$Res> {
  factory _$$StatsLoadedCopyWith(
          _$StatsLoaded value, $Res Function(_$StatsLoaded) then) =
      __$$StatsLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({KanPracticeStats stats});
}

/// @nodoc
class __$$StatsLoadedCopyWithImpl<$Res>
    extends _$StatsStateCopyWithImpl<$Res, _$StatsLoaded>
    implements _$$StatsLoadedCopyWith<$Res> {
  __$$StatsLoadedCopyWithImpl(
      _$StatsLoaded _value, $Res Function(_$StatsLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = null,
  }) {
    return _then(_$StatsLoaded(
      null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as KanPracticeStats,
    ));
  }
}

/// @nodoc

class _$StatsLoaded implements StatsLoaded {
  const _$StatsLoaded(this.stats);

  @override
  final KanPracticeStats stats;

  @override
  String toString() {
    return 'StatsState.loaded(stats: $stats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsLoaded &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stats);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatsLoadedCopyWith<_$StatsLoaded> get copyWith =>
      __$$StatsLoadedCopyWithImpl<_$StatsLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(KanPracticeStats stats) loaded,
    required TResult Function() loading,
    required TResult Function() initial,
  }) {
    return loaded(stats);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(KanPracticeStats stats)? loaded,
    TResult? Function()? loading,
    TResult? Function()? initial,
  }) {
    return loaded?.call(stats);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(KanPracticeStats stats)? loaded,
    TResult Function()? loading,
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(stats);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StatsLoaded value) loaded,
    required TResult Function(StatsLoading value) loading,
    required TResult Function(StatsInitial value) initial,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StatsLoaded value)? loaded,
    TResult? Function(StatsLoading value)? loading,
    TResult? Function(StatsInitial value)? initial,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StatsLoaded value)? loaded,
    TResult Function(StatsLoading value)? loading,
    TResult Function(StatsInitial value)? initial,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class StatsLoaded implements StatsState {
  const factory StatsLoaded(final KanPracticeStats stats) = _$StatsLoaded;

  KanPracticeStats get stats;
  @JsonKey(ignore: true)
  _$$StatsLoadedCopyWith<_$StatsLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatsLoadingCopyWith<$Res> {
  factory _$$StatsLoadingCopyWith(
          _$StatsLoading value, $Res Function(_$StatsLoading) then) =
      __$$StatsLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StatsLoadingCopyWithImpl<$Res>
    extends _$StatsStateCopyWithImpl<$Res, _$StatsLoading>
    implements _$$StatsLoadingCopyWith<$Res> {
  __$$StatsLoadingCopyWithImpl(
      _$StatsLoading _value, $Res Function(_$StatsLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StatsLoading implements StatsLoading {
  const _$StatsLoading();

  @override
  String toString() {
    return 'StatsState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StatsLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(KanPracticeStats stats) loaded,
    required TResult Function() loading,
    required TResult Function() initial,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(KanPracticeStats stats)? loaded,
    TResult? Function()? loading,
    TResult? Function()? initial,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(KanPracticeStats stats)? loaded,
    TResult Function()? loading,
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
    required TResult Function(StatsLoaded value) loaded,
    required TResult Function(StatsLoading value) loading,
    required TResult Function(StatsInitial value) initial,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StatsLoaded value)? loaded,
    TResult? Function(StatsLoading value)? loading,
    TResult? Function(StatsInitial value)? initial,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StatsLoaded value)? loaded,
    TResult Function(StatsLoading value)? loading,
    TResult Function(StatsInitial value)? initial,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class StatsLoading implements StatsState {
  const factory StatsLoading() = _$StatsLoading;
}

/// @nodoc
abstract class _$$StatsInitialCopyWith<$Res> {
  factory _$$StatsInitialCopyWith(
          _$StatsInitial value, $Res Function(_$StatsInitial) then) =
      __$$StatsInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StatsInitialCopyWithImpl<$Res>
    extends _$StatsStateCopyWithImpl<$Res, _$StatsInitial>
    implements _$$StatsInitialCopyWith<$Res> {
  __$$StatsInitialCopyWithImpl(
      _$StatsInitial _value, $Res Function(_$StatsInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StatsInitial implements StatsInitial {
  const _$StatsInitial();

  @override
  String toString() {
    return 'StatsState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StatsInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(KanPracticeStats stats) loaded,
    required TResult Function() loading,
    required TResult Function() initial,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(KanPracticeStats stats)? loaded,
    TResult? Function()? loading,
    TResult? Function()? initial,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(KanPracticeStats stats)? loaded,
    TResult Function()? loading,
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
    required TResult Function(StatsLoaded value) loaded,
    required TResult Function(StatsLoading value) loading,
    required TResult Function(StatsInitial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StatsLoaded value)? loaded,
    TResult? Function(StatsLoading value)? loading,
    TResult? Function(StatsInitial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StatsLoaded value)? loaded,
    TResult Function(StatsLoading value)? loading,
    TResult Function(StatsInitial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class StatsInitial implements StatsState {
  const factory StatsInitial() = _$StatsInitial;
}
