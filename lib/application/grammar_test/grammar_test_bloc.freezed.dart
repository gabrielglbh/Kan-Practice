// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grammar_test_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GrammarTestState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> grammarToReview) initial,
    required TResult Function(List<GrammarPoint> grammar, GrammarModes mode)
        loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<int> grammarToReview)? initial,
    TResult? Function(List<GrammarPoint> grammar, GrammarModes mode)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> grammarToReview)? initial,
    TResult Function(List<GrammarPoint> grammar, GrammarModes mode)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GrammarTestInitial value) initial,
    required TResult Function(GrammarTestLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GrammarTestInitial value)? initial,
    TResult? Function(GrammarTestLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GrammarTestInitial value)? initial,
    TResult Function(GrammarTestLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GrammarTestStateCopyWith<$Res> {
  factory $GrammarTestStateCopyWith(
          GrammarTestState value, $Res Function(GrammarTestState) then) =
      _$GrammarTestStateCopyWithImpl<$Res, GrammarTestState>;
}

/// @nodoc
class _$GrammarTestStateCopyWithImpl<$Res, $Val extends GrammarTestState>
    implements $GrammarTestStateCopyWith<$Res> {
  _$GrammarTestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GrammarTestInitialImplCopyWith<$Res> {
  factory _$$GrammarTestInitialImplCopyWith(_$GrammarTestInitialImpl value,
          $Res Function(_$GrammarTestInitialImpl) then) =
      __$$GrammarTestInitialImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<int> grammarToReview});
}

/// @nodoc
class __$$GrammarTestInitialImplCopyWithImpl<$Res>
    extends _$GrammarTestStateCopyWithImpl<$Res, _$GrammarTestInitialImpl>
    implements _$$GrammarTestInitialImplCopyWith<$Res> {
  __$$GrammarTestInitialImplCopyWithImpl(_$GrammarTestInitialImpl _value,
      $Res Function(_$GrammarTestInitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grammarToReview = null,
  }) {
    return _then(_$GrammarTestInitialImpl(
      null == grammarToReview
          ? _value._grammarToReview
          : grammarToReview // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$GrammarTestInitialImpl implements GrammarTestInitial {
  const _$GrammarTestInitialImpl(final List<int> grammarToReview)
      : _grammarToReview = grammarToReview;

  final List<int> _grammarToReview;
  @override
  List<int> get grammarToReview {
    if (_grammarToReview is EqualUnmodifiableListView) return _grammarToReview;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_grammarToReview);
  }

  @override
  String toString() {
    return 'GrammarTestState.initial(grammarToReview: $grammarToReview)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GrammarTestInitialImpl &&
            const DeepCollectionEquality()
                .equals(other._grammarToReview, _grammarToReview));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_grammarToReview));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GrammarTestInitialImplCopyWith<_$GrammarTestInitialImpl> get copyWith =>
      __$$GrammarTestInitialImplCopyWithImpl<_$GrammarTestInitialImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> grammarToReview) initial,
    required TResult Function(List<GrammarPoint> grammar, GrammarModes mode)
        loaded,
  }) {
    return initial(grammarToReview);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<int> grammarToReview)? initial,
    TResult? Function(List<GrammarPoint> grammar, GrammarModes mode)? loaded,
  }) {
    return initial?.call(grammarToReview);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> grammarToReview)? initial,
    TResult Function(List<GrammarPoint> grammar, GrammarModes mode)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(grammarToReview);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GrammarTestInitial value) initial,
    required TResult Function(GrammarTestLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GrammarTestInitial value)? initial,
    TResult? Function(GrammarTestLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GrammarTestInitial value)? initial,
    TResult Function(GrammarTestLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class GrammarTestInitial implements GrammarTestState {
  const factory GrammarTestInitial(final List<int> grammarToReview) =
      _$GrammarTestInitialImpl;

  List<int> get grammarToReview;
  @JsonKey(ignore: true)
  _$$GrammarTestInitialImplCopyWith<_$GrammarTestInitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GrammarTestLoadedImplCopyWith<$Res> {
  factory _$$GrammarTestLoadedImplCopyWith(_$GrammarTestLoadedImpl value,
          $Res Function(_$GrammarTestLoadedImpl) then) =
      __$$GrammarTestLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<GrammarPoint> grammar, GrammarModes mode});
}

/// @nodoc
class __$$GrammarTestLoadedImplCopyWithImpl<$Res>
    extends _$GrammarTestStateCopyWithImpl<$Res, _$GrammarTestLoadedImpl>
    implements _$$GrammarTestLoadedImplCopyWith<$Res> {
  __$$GrammarTestLoadedImplCopyWithImpl(_$GrammarTestLoadedImpl _value,
      $Res Function(_$GrammarTestLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grammar = null,
    Object? mode = null,
  }) {
    return _then(_$GrammarTestLoadedImpl(
      null == grammar
          ? _value._grammar
          : grammar // ignore: cast_nullable_to_non_nullable
              as List<GrammarPoint>,
      null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as GrammarModes,
    ));
  }
}

/// @nodoc

class _$GrammarTestLoadedImpl implements GrammarTestLoaded {
  const _$GrammarTestLoadedImpl(final List<GrammarPoint> grammar, this.mode)
      : _grammar = grammar;

  final List<GrammarPoint> _grammar;
  @override
  List<GrammarPoint> get grammar {
    if (_grammar is EqualUnmodifiableListView) return _grammar;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_grammar);
  }

  @override
  final GrammarModes mode;

  @override
  String toString() {
    return 'GrammarTestState.loaded(grammar: $grammar, mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GrammarTestLoadedImpl &&
            const DeepCollectionEquality().equals(other._grammar, _grammar) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_grammar), mode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GrammarTestLoadedImplCopyWith<_$GrammarTestLoadedImpl> get copyWith =>
      __$$GrammarTestLoadedImplCopyWithImpl<_$GrammarTestLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> grammarToReview) initial,
    required TResult Function(List<GrammarPoint> grammar, GrammarModes mode)
        loaded,
  }) {
    return loaded(grammar, mode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<int> grammarToReview)? initial,
    TResult? Function(List<GrammarPoint> grammar, GrammarModes mode)? loaded,
  }) {
    return loaded?.call(grammar, mode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> grammarToReview)? initial,
    TResult Function(List<GrammarPoint> grammar, GrammarModes mode)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(grammar, mode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GrammarTestInitial value) initial,
    required TResult Function(GrammarTestLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GrammarTestInitial value)? initial,
    TResult? Function(GrammarTestLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GrammarTestInitial value)? initial,
    TResult Function(GrammarTestLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class GrammarTestLoaded implements GrammarTestState {
  const factory GrammarTestLoaded(
          final List<GrammarPoint> grammar, final GrammarModes mode) =
      _$GrammarTestLoadedImpl;

  List<GrammarPoint> get grammar;
  GrammarModes get mode;
  @JsonKey(ignore: true)
  _$$GrammarTestLoadedImplCopyWith<_$GrammarTestLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
