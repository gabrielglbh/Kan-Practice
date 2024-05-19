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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$StatsLoadedImplCopyWith<$Res> {
  factory _$$StatsLoadedImplCopyWith(
          _$StatsLoadedImpl value, $Res Function(_$StatsLoadedImpl) then) =
      __$$StatsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({KanPracticeStats stats});
}

/// @nodoc
class __$$StatsLoadedImplCopyWithImpl<$Res>
    extends _$StatsStateCopyWithImpl<$Res, _$StatsLoadedImpl>
    implements _$$StatsLoadedImplCopyWith<$Res> {
  __$$StatsLoadedImplCopyWithImpl(
      _$StatsLoadedImpl _value, $Res Function(_$StatsLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = null,
  }) {
    return _then(_$StatsLoadedImpl(
      null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as KanPracticeStats,
    ));
  }
}

/// @nodoc

class _$StatsLoadedImpl implements StatsLoaded {
  const _$StatsLoadedImpl(this.stats);

  @override
  final KanPracticeStats stats;

  @override
  String toString() {
    return 'StatsState.loaded(stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsLoadedImpl &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stats);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatsLoadedImplCopyWith<_$StatsLoadedImpl> get copyWith =>
      __$$StatsLoadedImplCopyWithImpl<_$StatsLoadedImpl>(this, _$identity);

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
  const factory StatsLoaded(final KanPracticeStats stats) = _$StatsLoadedImpl;

  KanPracticeStats get stats;
  @JsonKey(ignore: true)
  _$$StatsLoadedImplCopyWith<_$StatsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatsLoadingImplCopyWith<$Res> {
  factory _$$StatsLoadingImplCopyWith(
          _$StatsLoadingImpl value, $Res Function(_$StatsLoadingImpl) then) =
      __$$StatsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StatsLoadingImplCopyWithImpl<$Res>
    extends _$StatsStateCopyWithImpl<$Res, _$StatsLoadingImpl>
    implements _$$StatsLoadingImplCopyWith<$Res> {
  __$$StatsLoadingImplCopyWithImpl(
      _$StatsLoadingImpl _value, $Res Function(_$StatsLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StatsLoadingImpl implements StatsLoading {
  const _$StatsLoadingImpl();

  @override
  String toString() {
    return 'StatsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StatsLoadingImpl);
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
  const factory StatsLoading() = _$StatsLoadingImpl;
}

/// @nodoc
abstract class _$$StatsInitialImplCopyWith<$Res> {
  factory _$$StatsInitialImplCopyWith(
          _$StatsInitialImpl value, $Res Function(_$StatsInitialImpl) then) =
      __$$StatsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StatsInitialImplCopyWithImpl<$Res>
    extends _$StatsStateCopyWithImpl<$Res, _$StatsInitialImpl>
    implements _$$StatsInitialImplCopyWith<$Res> {
  __$$StatsInitialImplCopyWithImpl(
      _$StatsInitialImpl _value, $Res Function(_$StatsInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StatsInitialImpl implements StatsInitial {
  const _$StatsInitialImpl();

  @override
  String toString() {
    return 'StatsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StatsInitialImpl);
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
  const factory StatsInitial() = _$StatsInitialImpl;
}
