// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'specific_data_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpecificDataState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SpecificData data, Tests test) testRetrieved,
    required TResult Function(SpecificData data, WordCategory category)
        categoryRetrieved,
    required TResult Function() initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SpecificData data, Tests test)? testRetrieved,
    TResult? Function(SpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult? Function()? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SpecificData data, Tests test)? testRetrieved,
    TResult Function(SpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult Function()? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SpecificDataTestRetrieved value) testRetrieved,
    required TResult Function(SpecificDataCategoryRetrieved value)
        categoryRetrieved,
    required TResult Function(SpecificDataInitial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SpecificDataTestRetrieved value)? testRetrieved,
    TResult? Function(SpecificDataCategoryRetrieved value)? categoryRetrieved,
    TResult? Function(SpecificDataInitial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SpecificDataTestRetrieved value)? testRetrieved,
    TResult Function(SpecificDataCategoryRetrieved value)? categoryRetrieved,
    TResult Function(SpecificDataInitial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpecificDataStateCopyWith<$Res> {
  factory $SpecificDataStateCopyWith(
          SpecificDataState value, $Res Function(SpecificDataState) then) =
      _$SpecificDataStateCopyWithImpl<$Res, SpecificDataState>;
}

/// @nodoc
class _$SpecificDataStateCopyWithImpl<$Res, $Val extends SpecificDataState>
    implements $SpecificDataStateCopyWith<$Res> {
  _$SpecificDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SpecificDataTestRetrievedCopyWith<$Res> {
  factory _$$SpecificDataTestRetrievedCopyWith(
          _$SpecificDataTestRetrieved value,
          $Res Function(_$SpecificDataTestRetrieved) then) =
      __$$SpecificDataTestRetrievedCopyWithImpl<$Res>;
  @useResult
  $Res call({SpecificData data, Tests test});
}

/// @nodoc
class __$$SpecificDataTestRetrievedCopyWithImpl<$Res>
    extends _$SpecificDataStateCopyWithImpl<$Res, _$SpecificDataTestRetrieved>
    implements _$$SpecificDataTestRetrievedCopyWith<$Res> {
  __$$SpecificDataTestRetrievedCopyWithImpl(_$SpecificDataTestRetrieved _value,
      $Res Function(_$SpecificDataTestRetrieved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? test = null,
  }) {
    return _then(_$SpecificDataTestRetrieved(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SpecificData,
      null == test
          ? _value.test
          : test // ignore: cast_nullable_to_non_nullable
              as Tests,
    ));
  }
}

/// @nodoc

class _$SpecificDataTestRetrieved implements SpecificDataTestRetrieved {
  const _$SpecificDataTestRetrieved(this.data, this.test);

  @override
  final SpecificData data;
  @override
  final Tests test;

  @override
  String toString() {
    return 'SpecificDataState.testRetrieved(data: $data, test: $test)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecificDataTestRetrieved &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.test, test) || other.test == test));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, test);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecificDataTestRetrievedCopyWith<_$SpecificDataTestRetrieved>
      get copyWith => __$$SpecificDataTestRetrievedCopyWithImpl<
          _$SpecificDataTestRetrieved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SpecificData data, Tests test) testRetrieved,
    required TResult Function(SpecificData data, WordCategory category)
        categoryRetrieved,
    required TResult Function() initial,
  }) {
    return testRetrieved(data, test);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SpecificData data, Tests test)? testRetrieved,
    TResult? Function(SpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult? Function()? initial,
  }) {
    return testRetrieved?.call(data, test);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SpecificData data, Tests test)? testRetrieved,
    TResult Function(SpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if (testRetrieved != null) {
      return testRetrieved(data, test);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SpecificDataTestRetrieved value) testRetrieved,
    required TResult Function(SpecificDataCategoryRetrieved value)
        categoryRetrieved,
    required TResult Function(SpecificDataInitial value) initial,
  }) {
    return testRetrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SpecificDataTestRetrieved value)? testRetrieved,
    TResult? Function(SpecificDataCategoryRetrieved value)? categoryRetrieved,
    TResult? Function(SpecificDataInitial value)? initial,
  }) {
    return testRetrieved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SpecificDataTestRetrieved value)? testRetrieved,
    TResult Function(SpecificDataCategoryRetrieved value)? categoryRetrieved,
    TResult Function(SpecificDataInitial value)? initial,
    required TResult orElse(),
  }) {
    if (testRetrieved != null) {
      return testRetrieved(this);
    }
    return orElse();
  }
}

abstract class SpecificDataTestRetrieved implements SpecificDataState {
  const factory SpecificDataTestRetrieved(
      final SpecificData data, final Tests test) = _$SpecificDataTestRetrieved;

  SpecificData get data;
  Tests get test;
  @JsonKey(ignore: true)
  _$$SpecificDataTestRetrievedCopyWith<_$SpecificDataTestRetrieved>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SpecificDataCategoryRetrievedCopyWith<$Res> {
  factory _$$SpecificDataCategoryRetrievedCopyWith(
          _$SpecificDataCategoryRetrieved value,
          $Res Function(_$SpecificDataCategoryRetrieved) then) =
      __$$SpecificDataCategoryRetrievedCopyWithImpl<$Res>;
  @useResult
  $Res call({SpecificData data, WordCategory category});
}

/// @nodoc
class __$$SpecificDataCategoryRetrievedCopyWithImpl<$Res>
    extends _$SpecificDataStateCopyWithImpl<$Res,
        _$SpecificDataCategoryRetrieved>
    implements _$$SpecificDataCategoryRetrievedCopyWith<$Res> {
  __$$SpecificDataCategoryRetrievedCopyWithImpl(
      _$SpecificDataCategoryRetrieved _value,
      $Res Function(_$SpecificDataCategoryRetrieved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? category = null,
  }) {
    return _then(_$SpecificDataCategoryRetrieved(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SpecificData,
      null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as WordCategory,
    ));
  }
}

/// @nodoc

class _$SpecificDataCategoryRetrieved implements SpecificDataCategoryRetrieved {
  const _$SpecificDataCategoryRetrieved(this.data, this.category);

  @override
  final SpecificData data;
  @override
  final WordCategory category;

  @override
  String toString() {
    return 'SpecificDataState.categoryRetrieved(data: $data, category: $category)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecificDataCategoryRetrieved &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecificDataCategoryRetrievedCopyWith<_$SpecificDataCategoryRetrieved>
      get copyWith => __$$SpecificDataCategoryRetrievedCopyWithImpl<
          _$SpecificDataCategoryRetrieved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SpecificData data, Tests test) testRetrieved,
    required TResult Function(SpecificData data, WordCategory category)
        categoryRetrieved,
    required TResult Function() initial,
  }) {
    return categoryRetrieved(data, category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SpecificData data, Tests test)? testRetrieved,
    TResult? Function(SpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult? Function()? initial,
  }) {
    return categoryRetrieved?.call(data, category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SpecificData data, Tests test)? testRetrieved,
    TResult Function(SpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult Function()? initial,
    required TResult orElse(),
  }) {
    if (categoryRetrieved != null) {
      return categoryRetrieved(data, category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SpecificDataTestRetrieved value) testRetrieved,
    required TResult Function(SpecificDataCategoryRetrieved value)
        categoryRetrieved,
    required TResult Function(SpecificDataInitial value) initial,
  }) {
    return categoryRetrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SpecificDataTestRetrieved value)? testRetrieved,
    TResult? Function(SpecificDataCategoryRetrieved value)? categoryRetrieved,
    TResult? Function(SpecificDataInitial value)? initial,
  }) {
    return categoryRetrieved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SpecificDataTestRetrieved value)? testRetrieved,
    TResult Function(SpecificDataCategoryRetrieved value)? categoryRetrieved,
    TResult Function(SpecificDataInitial value)? initial,
    required TResult orElse(),
  }) {
    if (categoryRetrieved != null) {
      return categoryRetrieved(this);
    }
    return orElse();
  }
}

abstract class SpecificDataCategoryRetrieved implements SpecificDataState {
  const factory SpecificDataCategoryRetrieved(
          final SpecificData data, final WordCategory category) =
      _$SpecificDataCategoryRetrieved;

  SpecificData get data;
  WordCategory get category;
  @JsonKey(ignore: true)
  _$$SpecificDataCategoryRetrievedCopyWith<_$SpecificDataCategoryRetrieved>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SpecificDataInitialCopyWith<$Res> {
  factory _$$SpecificDataInitialCopyWith(_$SpecificDataInitial value,
          $Res Function(_$SpecificDataInitial) then) =
      __$$SpecificDataInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SpecificDataInitialCopyWithImpl<$Res>
    extends _$SpecificDataStateCopyWithImpl<$Res, _$SpecificDataInitial>
    implements _$$SpecificDataInitialCopyWith<$Res> {
  __$$SpecificDataInitialCopyWithImpl(
      _$SpecificDataInitial _value, $Res Function(_$SpecificDataInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SpecificDataInitial implements SpecificDataInitial {
  const _$SpecificDataInitial();

  @override
  String toString() {
    return 'SpecificDataState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SpecificDataInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SpecificData data, Tests test) testRetrieved,
    required TResult Function(SpecificData data, WordCategory category)
        categoryRetrieved,
    required TResult Function() initial,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SpecificData data, Tests test)? testRetrieved,
    TResult? Function(SpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult? Function()? initial,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SpecificData data, Tests test)? testRetrieved,
    TResult Function(SpecificData data, WordCategory category)?
        categoryRetrieved,
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
    required TResult Function(SpecificDataTestRetrieved value) testRetrieved,
    required TResult Function(SpecificDataCategoryRetrieved value)
        categoryRetrieved,
    required TResult Function(SpecificDataInitial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SpecificDataTestRetrieved value)? testRetrieved,
    TResult? Function(SpecificDataCategoryRetrieved value)? categoryRetrieved,
    TResult? Function(SpecificDataInitial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SpecificDataTestRetrieved value)? testRetrieved,
    TResult Function(SpecificDataCategoryRetrieved value)? categoryRetrieved,
    TResult Function(SpecificDataInitial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SpecificDataInitial implements SpecificDataState {
  const factory SpecificDataInitial() = _$SpecificDataInitial;
}
