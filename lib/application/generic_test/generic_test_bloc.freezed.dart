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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$GenericTestInitialCopyWith<$Res> {
  factory _$$GenericTestInitialCopyWith(_$GenericTestInitial value,
          $Res Function(_$GenericTestInitial) then) =
      __$$GenericTestInitialCopyWithImpl<$Res>;
  @useResult
  $Res call({List<int> wordsToReview});
}

/// @nodoc
class __$$GenericTestInitialCopyWithImpl<$Res>
    extends _$GenericTestStateCopyWithImpl<$Res, _$GenericTestInitial>
    implements _$$GenericTestInitialCopyWith<$Res> {
  __$$GenericTestInitialCopyWithImpl(
      _$GenericTestInitial _value, $Res Function(_$GenericTestInitial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wordsToReview = null,
  }) {
    return _then(_$GenericTestInitial(
      null == wordsToReview
          ? _value._wordsToReview
          : wordsToReview // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$GenericTestInitial implements GenericTestInitial {
  const _$GenericTestInitial(final List<int> wordsToReview)
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenericTestInitial &&
            const DeepCollectionEquality()
                .equals(other._wordsToReview, _wordsToReview));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_wordsToReview));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenericTestInitialCopyWith<_$GenericTestInitial> get copyWith =>
      __$$GenericTestInitialCopyWithImpl<_$GenericTestInitial>(
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
      _$GenericTestInitial;

  List<int> get wordsToReview;
  @JsonKey(ignore: true)
  _$$GenericTestInitialCopyWith<_$GenericTestInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GenericTestLoadedCopyWith<$Res> {
  factory _$$GenericTestLoadedCopyWith(
          _$GenericTestLoaded value, $Res Function(_$GenericTestLoaded) then) =
      __$$GenericTestLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Word> words, StudyModes mode});
}

/// @nodoc
class __$$GenericTestLoadedCopyWithImpl<$Res>
    extends _$GenericTestStateCopyWithImpl<$Res, _$GenericTestLoaded>
    implements _$$GenericTestLoadedCopyWith<$Res> {
  __$$GenericTestLoadedCopyWithImpl(
      _$GenericTestLoaded _value, $Res Function(_$GenericTestLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? words = null,
    Object? mode = null,
  }) {
    return _then(_$GenericTestLoaded(
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

class _$GenericTestLoaded implements GenericTestLoaded {
  const _$GenericTestLoaded(final List<Word> words, this.mode) : _words = words;

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenericTestLoaded &&
            const DeepCollectionEquality().equals(other._words, _words) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_words), mode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenericTestLoadedCopyWith<_$GenericTestLoaded> get copyWith =>
      __$$GenericTestLoadedCopyWithImpl<_$GenericTestLoaded>(this, _$identity);

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
      final List<Word> words, final StudyModes mode) = _$GenericTestLoaded;

  List<Word> get words;
  StudyModes get mode;
  @JsonKey(ignore: true)
  _$$GenericTestLoadedCopyWith<_$GenericTestLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}
