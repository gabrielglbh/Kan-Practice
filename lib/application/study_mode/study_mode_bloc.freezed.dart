// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_mode_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StudyModeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() sm2Calculated,
    required TResult Function(int score) scoreCalculated,
    required TResult Function(double score) scoreObtained,
    required TResult Function() testFinished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? sm2Calculated,
    TResult? Function(int score)? scoreCalculated,
    TResult? Function(double score)? scoreObtained,
    TResult? Function()? testFinished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? sm2Calculated,
    TResult Function(int score)? scoreCalculated,
    TResult Function(double score)? scoreObtained,
    TResult Function()? testFinished,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StudyModeLoading value) loading,
    required TResult Function(StudyModeLoaded value) loaded,
    required TResult Function(StudyModeSM2Calculated value) sm2Calculated,
    required TResult Function(StudyModeScoreCalculated value) scoreCalculated,
    required TResult Function(StudyModeScoreObtained value) scoreObtained,
    required TResult Function(StudyModeTestFinished value) testFinished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudyModeLoading value)? loading,
    TResult? Function(StudyModeLoaded value)? loaded,
    TResult? Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult? Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult? Function(StudyModeScoreObtained value)? scoreObtained,
    TResult? Function(StudyModeTestFinished value)? testFinished,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudyModeLoading value)? loading,
    TResult Function(StudyModeLoaded value)? loaded,
    TResult Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult Function(StudyModeScoreObtained value)? scoreObtained,
    TResult Function(StudyModeTestFinished value)? testFinished,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyModeStateCopyWith<$Res> {
  factory $StudyModeStateCopyWith(
          StudyModeState value, $Res Function(StudyModeState) then) =
      _$StudyModeStateCopyWithImpl<$Res, StudyModeState>;
}

/// @nodoc
class _$StudyModeStateCopyWithImpl<$Res, $Val extends StudyModeState>
    implements $StudyModeStateCopyWith<$Res> {
  _$StudyModeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StudyModeLoadingImplCopyWith<$Res> {
  factory _$$StudyModeLoadingImplCopyWith(_$StudyModeLoadingImpl value,
          $Res Function(_$StudyModeLoadingImpl) then) =
      __$$StudyModeLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StudyModeLoadingImplCopyWithImpl<$Res>
    extends _$StudyModeStateCopyWithImpl<$Res, _$StudyModeLoadingImpl>
    implements _$$StudyModeLoadingImplCopyWith<$Res> {
  __$$StudyModeLoadingImplCopyWithImpl(_$StudyModeLoadingImpl _value,
      $Res Function(_$StudyModeLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StudyModeLoadingImpl implements StudyModeLoading {
  const _$StudyModeLoadingImpl();

  @override
  String toString() {
    return 'StudyModeState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StudyModeLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() sm2Calculated,
    required TResult Function(int score) scoreCalculated,
    required TResult Function(double score) scoreObtained,
    required TResult Function() testFinished,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? sm2Calculated,
    TResult? Function(int score)? scoreCalculated,
    TResult? Function(double score)? scoreObtained,
    TResult? Function()? testFinished,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? sm2Calculated,
    TResult Function(int score)? scoreCalculated,
    TResult Function(double score)? scoreObtained,
    TResult Function()? testFinished,
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
    required TResult Function(StudyModeLoading value) loading,
    required TResult Function(StudyModeLoaded value) loaded,
    required TResult Function(StudyModeSM2Calculated value) sm2Calculated,
    required TResult Function(StudyModeScoreCalculated value) scoreCalculated,
    required TResult Function(StudyModeScoreObtained value) scoreObtained,
    required TResult Function(StudyModeTestFinished value) testFinished,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudyModeLoading value)? loading,
    TResult? Function(StudyModeLoaded value)? loaded,
    TResult? Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult? Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult? Function(StudyModeScoreObtained value)? scoreObtained,
    TResult? Function(StudyModeTestFinished value)? testFinished,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudyModeLoading value)? loading,
    TResult Function(StudyModeLoaded value)? loaded,
    TResult Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult Function(StudyModeScoreObtained value)? scoreObtained,
    TResult Function(StudyModeTestFinished value)? testFinished,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class StudyModeLoading implements StudyModeState {
  const factory StudyModeLoading() = _$StudyModeLoadingImpl;
}

/// @nodoc
abstract class _$$StudyModeLoadedImplCopyWith<$Res> {
  factory _$$StudyModeLoadedImplCopyWith(_$StudyModeLoadedImpl value,
          $Res Function(_$StudyModeLoadedImpl) then) =
      __$$StudyModeLoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StudyModeLoadedImplCopyWithImpl<$Res>
    extends _$StudyModeStateCopyWithImpl<$Res, _$StudyModeLoadedImpl>
    implements _$$StudyModeLoadedImplCopyWith<$Res> {
  __$$StudyModeLoadedImplCopyWithImpl(
      _$StudyModeLoadedImpl _value, $Res Function(_$StudyModeLoadedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StudyModeLoadedImpl implements StudyModeLoaded {
  const _$StudyModeLoadedImpl();

  @override
  String toString() {
    return 'StudyModeState.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StudyModeLoadedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() sm2Calculated,
    required TResult Function(int score) scoreCalculated,
    required TResult Function(double score) scoreObtained,
    required TResult Function() testFinished,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? sm2Calculated,
    TResult? Function(int score)? scoreCalculated,
    TResult? Function(double score)? scoreObtained,
    TResult? Function()? testFinished,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? sm2Calculated,
    TResult Function(int score)? scoreCalculated,
    TResult Function(double score)? scoreObtained,
    TResult Function()? testFinished,
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
    required TResult Function(StudyModeLoading value) loading,
    required TResult Function(StudyModeLoaded value) loaded,
    required TResult Function(StudyModeSM2Calculated value) sm2Calculated,
    required TResult Function(StudyModeScoreCalculated value) scoreCalculated,
    required TResult Function(StudyModeScoreObtained value) scoreObtained,
    required TResult Function(StudyModeTestFinished value) testFinished,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudyModeLoading value)? loading,
    TResult? Function(StudyModeLoaded value)? loaded,
    TResult? Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult? Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult? Function(StudyModeScoreObtained value)? scoreObtained,
    TResult? Function(StudyModeTestFinished value)? testFinished,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudyModeLoading value)? loading,
    TResult Function(StudyModeLoaded value)? loaded,
    TResult Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult Function(StudyModeScoreObtained value)? scoreObtained,
    TResult Function(StudyModeTestFinished value)? testFinished,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class StudyModeLoaded implements StudyModeState {
  const factory StudyModeLoaded() = _$StudyModeLoadedImpl;
}

/// @nodoc
abstract class _$$StudyModeSM2CalculatedImplCopyWith<$Res> {
  factory _$$StudyModeSM2CalculatedImplCopyWith(
          _$StudyModeSM2CalculatedImpl value,
          $Res Function(_$StudyModeSM2CalculatedImpl) then) =
      __$$StudyModeSM2CalculatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StudyModeSM2CalculatedImplCopyWithImpl<$Res>
    extends _$StudyModeStateCopyWithImpl<$Res, _$StudyModeSM2CalculatedImpl>
    implements _$$StudyModeSM2CalculatedImplCopyWith<$Res> {
  __$$StudyModeSM2CalculatedImplCopyWithImpl(
      _$StudyModeSM2CalculatedImpl _value,
      $Res Function(_$StudyModeSM2CalculatedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StudyModeSM2CalculatedImpl implements StudyModeSM2Calculated {
  const _$StudyModeSM2CalculatedImpl();

  @override
  String toString() {
    return 'StudyModeState.sm2Calculated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyModeSM2CalculatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() sm2Calculated,
    required TResult Function(int score) scoreCalculated,
    required TResult Function(double score) scoreObtained,
    required TResult Function() testFinished,
  }) {
    return sm2Calculated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? sm2Calculated,
    TResult? Function(int score)? scoreCalculated,
    TResult? Function(double score)? scoreObtained,
    TResult? Function()? testFinished,
  }) {
    return sm2Calculated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? sm2Calculated,
    TResult Function(int score)? scoreCalculated,
    TResult Function(double score)? scoreObtained,
    TResult Function()? testFinished,
    required TResult orElse(),
  }) {
    if (sm2Calculated != null) {
      return sm2Calculated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StudyModeLoading value) loading,
    required TResult Function(StudyModeLoaded value) loaded,
    required TResult Function(StudyModeSM2Calculated value) sm2Calculated,
    required TResult Function(StudyModeScoreCalculated value) scoreCalculated,
    required TResult Function(StudyModeScoreObtained value) scoreObtained,
    required TResult Function(StudyModeTestFinished value) testFinished,
  }) {
    return sm2Calculated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudyModeLoading value)? loading,
    TResult? Function(StudyModeLoaded value)? loaded,
    TResult? Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult? Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult? Function(StudyModeScoreObtained value)? scoreObtained,
    TResult? Function(StudyModeTestFinished value)? testFinished,
  }) {
    return sm2Calculated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudyModeLoading value)? loading,
    TResult Function(StudyModeLoaded value)? loaded,
    TResult Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult Function(StudyModeScoreObtained value)? scoreObtained,
    TResult Function(StudyModeTestFinished value)? testFinished,
    required TResult orElse(),
  }) {
    if (sm2Calculated != null) {
      return sm2Calculated(this);
    }
    return orElse();
  }
}

abstract class StudyModeSM2Calculated implements StudyModeState {
  const factory StudyModeSM2Calculated() = _$StudyModeSM2CalculatedImpl;
}

/// @nodoc
abstract class _$$StudyModeScoreCalculatedImplCopyWith<$Res> {
  factory _$$StudyModeScoreCalculatedImplCopyWith(
          _$StudyModeScoreCalculatedImpl value,
          $Res Function(_$StudyModeScoreCalculatedImpl) then) =
      __$$StudyModeScoreCalculatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int score});
}

/// @nodoc
class __$$StudyModeScoreCalculatedImplCopyWithImpl<$Res>
    extends _$StudyModeStateCopyWithImpl<$Res, _$StudyModeScoreCalculatedImpl>
    implements _$$StudyModeScoreCalculatedImplCopyWith<$Res> {
  __$$StudyModeScoreCalculatedImplCopyWithImpl(
      _$StudyModeScoreCalculatedImpl _value,
      $Res Function(_$StudyModeScoreCalculatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
  }) {
    return _then(_$StudyModeScoreCalculatedImpl(
      null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$StudyModeScoreCalculatedImpl implements StudyModeScoreCalculated {
  const _$StudyModeScoreCalculatedImpl(this.score);

  @override
  final int score;

  @override
  String toString() {
    return 'StudyModeState.scoreCalculated(score: $score)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyModeScoreCalculatedImpl &&
            (identical(other.score, score) || other.score == score));
  }

  @override
  int get hashCode => Object.hash(runtimeType, score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyModeScoreCalculatedImplCopyWith<_$StudyModeScoreCalculatedImpl>
      get copyWith => __$$StudyModeScoreCalculatedImplCopyWithImpl<
          _$StudyModeScoreCalculatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() sm2Calculated,
    required TResult Function(int score) scoreCalculated,
    required TResult Function(double score) scoreObtained,
    required TResult Function() testFinished,
  }) {
    return scoreCalculated(score);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? sm2Calculated,
    TResult? Function(int score)? scoreCalculated,
    TResult? Function(double score)? scoreObtained,
    TResult? Function()? testFinished,
  }) {
    return scoreCalculated?.call(score);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? sm2Calculated,
    TResult Function(int score)? scoreCalculated,
    TResult Function(double score)? scoreObtained,
    TResult Function()? testFinished,
    required TResult orElse(),
  }) {
    if (scoreCalculated != null) {
      return scoreCalculated(score);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StudyModeLoading value) loading,
    required TResult Function(StudyModeLoaded value) loaded,
    required TResult Function(StudyModeSM2Calculated value) sm2Calculated,
    required TResult Function(StudyModeScoreCalculated value) scoreCalculated,
    required TResult Function(StudyModeScoreObtained value) scoreObtained,
    required TResult Function(StudyModeTestFinished value) testFinished,
  }) {
    return scoreCalculated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudyModeLoading value)? loading,
    TResult? Function(StudyModeLoaded value)? loaded,
    TResult? Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult? Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult? Function(StudyModeScoreObtained value)? scoreObtained,
    TResult? Function(StudyModeTestFinished value)? testFinished,
  }) {
    return scoreCalculated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudyModeLoading value)? loading,
    TResult Function(StudyModeLoaded value)? loaded,
    TResult Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult Function(StudyModeScoreObtained value)? scoreObtained,
    TResult Function(StudyModeTestFinished value)? testFinished,
    required TResult orElse(),
  }) {
    if (scoreCalculated != null) {
      return scoreCalculated(this);
    }
    return orElse();
  }
}

abstract class StudyModeScoreCalculated implements StudyModeState {
  const factory StudyModeScoreCalculated(final int score) =
      _$StudyModeScoreCalculatedImpl;

  int get score;
  @JsonKey(ignore: true)
  _$$StudyModeScoreCalculatedImplCopyWith<_$StudyModeScoreCalculatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StudyModeScoreObtainedImplCopyWith<$Res> {
  factory _$$StudyModeScoreObtainedImplCopyWith(
          _$StudyModeScoreObtainedImpl value,
          $Res Function(_$StudyModeScoreObtainedImpl) then) =
      __$$StudyModeScoreObtainedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double score});
}

/// @nodoc
class __$$StudyModeScoreObtainedImplCopyWithImpl<$Res>
    extends _$StudyModeStateCopyWithImpl<$Res, _$StudyModeScoreObtainedImpl>
    implements _$$StudyModeScoreObtainedImplCopyWith<$Res> {
  __$$StudyModeScoreObtainedImplCopyWithImpl(
      _$StudyModeScoreObtainedImpl _value,
      $Res Function(_$StudyModeScoreObtainedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
  }) {
    return _then(_$StudyModeScoreObtainedImpl(
      null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$StudyModeScoreObtainedImpl implements StudyModeScoreObtained {
  const _$StudyModeScoreObtainedImpl(this.score);

  @override
  final double score;

  @override
  String toString() {
    return 'StudyModeState.scoreObtained(score: $score)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyModeScoreObtainedImpl &&
            (identical(other.score, score) || other.score == score));
  }

  @override
  int get hashCode => Object.hash(runtimeType, score);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyModeScoreObtainedImplCopyWith<_$StudyModeScoreObtainedImpl>
      get copyWith => __$$StudyModeScoreObtainedImplCopyWithImpl<
          _$StudyModeScoreObtainedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() sm2Calculated,
    required TResult Function(int score) scoreCalculated,
    required TResult Function(double score) scoreObtained,
    required TResult Function() testFinished,
  }) {
    return scoreObtained(score);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? sm2Calculated,
    TResult? Function(int score)? scoreCalculated,
    TResult? Function(double score)? scoreObtained,
    TResult? Function()? testFinished,
  }) {
    return scoreObtained?.call(score);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? sm2Calculated,
    TResult Function(int score)? scoreCalculated,
    TResult Function(double score)? scoreObtained,
    TResult Function()? testFinished,
    required TResult orElse(),
  }) {
    if (scoreObtained != null) {
      return scoreObtained(score);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StudyModeLoading value) loading,
    required TResult Function(StudyModeLoaded value) loaded,
    required TResult Function(StudyModeSM2Calculated value) sm2Calculated,
    required TResult Function(StudyModeScoreCalculated value) scoreCalculated,
    required TResult Function(StudyModeScoreObtained value) scoreObtained,
    required TResult Function(StudyModeTestFinished value) testFinished,
  }) {
    return scoreObtained(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudyModeLoading value)? loading,
    TResult? Function(StudyModeLoaded value)? loaded,
    TResult? Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult? Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult? Function(StudyModeScoreObtained value)? scoreObtained,
    TResult? Function(StudyModeTestFinished value)? testFinished,
  }) {
    return scoreObtained?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudyModeLoading value)? loading,
    TResult Function(StudyModeLoaded value)? loaded,
    TResult Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult Function(StudyModeScoreObtained value)? scoreObtained,
    TResult Function(StudyModeTestFinished value)? testFinished,
    required TResult orElse(),
  }) {
    if (scoreObtained != null) {
      return scoreObtained(this);
    }
    return orElse();
  }
}

abstract class StudyModeScoreObtained implements StudyModeState {
  const factory StudyModeScoreObtained(final double score) =
      _$StudyModeScoreObtainedImpl;

  double get score;
  @JsonKey(ignore: true)
  _$$StudyModeScoreObtainedImplCopyWith<_$StudyModeScoreObtainedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StudyModeTestFinishedImplCopyWith<$Res> {
  factory _$$StudyModeTestFinishedImplCopyWith(
          _$StudyModeTestFinishedImpl value,
          $Res Function(_$StudyModeTestFinishedImpl) then) =
      __$$StudyModeTestFinishedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StudyModeTestFinishedImplCopyWithImpl<$Res>
    extends _$StudyModeStateCopyWithImpl<$Res, _$StudyModeTestFinishedImpl>
    implements _$$StudyModeTestFinishedImplCopyWith<$Res> {
  __$$StudyModeTestFinishedImplCopyWithImpl(_$StudyModeTestFinishedImpl _value,
      $Res Function(_$StudyModeTestFinishedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StudyModeTestFinishedImpl implements StudyModeTestFinished {
  const _$StudyModeTestFinishedImpl();

  @override
  String toString() {
    return 'StudyModeState.testFinished()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyModeTestFinishedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() loaded,
    required TResult Function() sm2Calculated,
    required TResult Function(int score) scoreCalculated,
    required TResult Function(double score) scoreObtained,
    required TResult Function() testFinished,
  }) {
    return testFinished();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? loaded,
    TResult? Function()? sm2Calculated,
    TResult? Function(int score)? scoreCalculated,
    TResult? Function(double score)? scoreObtained,
    TResult? Function()? testFinished,
  }) {
    return testFinished?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? loaded,
    TResult Function()? sm2Calculated,
    TResult Function(int score)? scoreCalculated,
    TResult Function(double score)? scoreObtained,
    TResult Function()? testFinished,
    required TResult orElse(),
  }) {
    if (testFinished != null) {
      return testFinished();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StudyModeLoading value) loading,
    required TResult Function(StudyModeLoaded value) loaded,
    required TResult Function(StudyModeSM2Calculated value) sm2Calculated,
    required TResult Function(StudyModeScoreCalculated value) scoreCalculated,
    required TResult Function(StudyModeScoreObtained value) scoreObtained,
    required TResult Function(StudyModeTestFinished value) testFinished,
  }) {
    return testFinished(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(StudyModeLoading value)? loading,
    TResult? Function(StudyModeLoaded value)? loaded,
    TResult? Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult? Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult? Function(StudyModeScoreObtained value)? scoreObtained,
    TResult? Function(StudyModeTestFinished value)? testFinished,
  }) {
    return testFinished?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StudyModeLoading value)? loading,
    TResult Function(StudyModeLoaded value)? loaded,
    TResult Function(StudyModeSM2Calculated value)? sm2Calculated,
    TResult Function(StudyModeScoreCalculated value)? scoreCalculated,
    TResult Function(StudyModeScoreObtained value)? scoreObtained,
    TResult Function(StudyModeTestFinished value)? testFinished,
    required TResult orElse(),
  }) {
    if (testFinished != null) {
      return testFinished(this);
    }
    return orElse();
  }
}

abstract class StudyModeTestFinished implements StudyModeState {
  const factory StudyModeTestFinished() = _$StudyModeTestFinishedImpl;
}
