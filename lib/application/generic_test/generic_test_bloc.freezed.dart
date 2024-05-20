// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generic_test_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GenericTestState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> wordsToReview) initial,
    required TResult Function(List<Word> words, StudyModes mode) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<int> wordsToReview)? initial,
    TResult? Function(List<Word> words, StudyModes mode)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> wordsToReview)? initial,
    TResult Function(List<Word> words, StudyModes mode)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericTestInitial value) initial,
    required TResult Function(GenericTestLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericTestInitial value)? initial,
    TResult? Function(GenericTestLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericTestInitial value)? initial,
    TResult Function(GenericTestLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenericTestStateCopyWith<$Res> {
  factory $GenericTestStateCopyWith(
          GenericTestState value, $Res Function(GenericTestState) then) =
      _$GenericTestStateCopyWithImpl<$Res, GenericTestState>;
}

/// @nodoc
class _$GenericTestStateCopyWithImpl<$Res, $Val extends GenericTestState>
    implements $GenericTestStateCopyWith<$Res> {
  _$GenericTestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GenericTestInitialImplCopyWith<$Res> {
  factory _$$GenericTestInitialImplCopyWith(_$GenericTestInitialImpl value,
          $Res Function(_$GenericTestInitialImpl) then) =
      __$$GenericTestInitialImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<int> wordsToReview});
}

/// @nodoc
class __$$GenericTestInitialImplCopyWithImpl<$Res>
    extends _$GenericTestStateCopyWithImpl<$Res, _$GenericTestInitialImpl>
    implements _$$GenericTestInitialImplCopyWith<$Res> {
  __$$GenericTestInitialImplCopyWithImpl(_$GenericTestInitialImpl _value,
      $Res Function(_$GenericTestInitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordsToReview = null,
  }) {
    return _then(_$GenericTestInitialImpl(
      null == wordsToReview
          ? _value._wordsToReview
          : wordsToReview // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$GenericTestInitialImpl implements GenericTestInitial {
  const _$GenericTestInitialImpl(final List<int> wordsToReview)
      : _wordsToReview = wordsToReview;

  final List<int> _wordsToReview;
  @override
  List<int> get wordsToReview {
    if (_wordsToReview is EqualUnmodifiableListView) return _wordsToReview;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wordsToReview);
  }

  @override
  String toString() {
    return 'GenericTestState.initial(wordsToReview: $wordsToReview)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenericTestInitialImpl &&
            const DeepCollectionEquality()
                .equals(other._wordsToReview, _wordsToReview));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_wordsToReview));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenericTestInitialImplCopyWith<_$GenericTestInitialImpl> get copyWith =>
      __$$GenericTestInitialImplCopyWithImpl<_$GenericTestInitialImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> wordsToReview) initial,
    required TResult Function(List<Word> words, StudyModes mode) loaded,
  }) {
    return initial(wordsToReview);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<int> wordsToReview)? initial,
    TResult? Function(List<Word> words, StudyModes mode)? loaded,
  }) {
    return initial?.call(wordsToReview);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> wordsToReview)? initial,
    TResult Function(List<Word> words, StudyModes mode)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(wordsToReview);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericTestInitial value) initial,
    required TResult Function(GenericTestLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericTestInitial value)? initial,
    TResult? Function(GenericTestLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericTestInitial value)? initial,
    TResult Function(GenericTestLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class GenericTestInitial implements GenericTestState {
  const factory GenericTestInitial(final List<int> wordsToReview) =
      _$GenericTestInitialImpl;

  List<int> get wordsToReview;
  @JsonKey(ignore: true)
  _$$GenericTestInitialImplCopyWith<_$GenericTestInitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GenericTestLoadedImplCopyWith<$Res> {
  factory _$$GenericTestLoadedImplCopyWith(_$GenericTestLoadedImpl value,
          $Res Function(_$GenericTestLoadedImpl) then) =
      __$$GenericTestLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Word> words, StudyModes mode});
}

/// @nodoc
class __$$GenericTestLoadedImplCopyWithImpl<$Res>
    extends _$GenericTestStateCopyWithImpl<$Res, _$GenericTestLoadedImpl>
    implements _$$GenericTestLoadedImplCopyWith<$Res> {
  __$$GenericTestLoadedImplCopyWithImpl(_$GenericTestLoadedImpl _value,
      $Res Function(_$GenericTestLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
    Object? mode = null,
  }) {
    return _then(_$GenericTestLoadedImpl(
      null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<Word>,
      null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as StudyModes,
    ));
  }
}

/// @nodoc

class _$GenericTestLoadedImpl implements GenericTestLoaded {
  const _$GenericTestLoadedImpl(final List<Word> words, this.mode)
      : _words = words;

  final List<Word> _words;
  @override
  List<Word> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  final StudyModes mode;

  @override
  String toString() {
    return 'GenericTestState.loaded(words: $words, mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenericTestLoadedImpl &&
            const DeepCollectionEquality().equals(other._words, _words) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_words), mode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenericTestLoadedImplCopyWith<_$GenericTestLoadedImpl> get copyWith =>
      __$$GenericTestLoadedImplCopyWithImpl<_$GenericTestLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> wordsToReview) initial,
    required TResult Function(List<Word> words, StudyModes mode) loaded,
  }) {
    return loaded(words, mode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<int> wordsToReview)? initial,
    TResult? Function(List<Word> words, StudyModes mode)? loaded,
  }) {
    return loaded?.call(words, mode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> wordsToReview)? initial,
    TResult Function(List<Word> words, StudyModes mode)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(words, mode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenericTestInitial value) initial,
    required TResult Function(GenericTestLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenericTestInitial value)? initial,
    TResult? Function(GenericTestLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenericTestInitial value)? initial,
    TResult Function(GenericTestLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class GenericTestLoaded implements GenericTestState {
  const factory GenericTestLoaded(
      final List<Word> words, final StudyModes mode) = _$GenericTestLoadedImpl;

  List<Word> get words;
  StudyModes get mode;
  @JsonKey(ignore: true)
  _$$GenericTestLoadedImplCopyWith<_$GenericTestLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
