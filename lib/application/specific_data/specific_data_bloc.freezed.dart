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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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

  /// Create a copy of SpecificDataState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SpecificDataTestRetrievedImplCopyWith<$Res> {
  factory _$$SpecificDataTestRetrievedImplCopyWith(
          _$SpecificDataTestRetrievedImpl value,
          $Res Function(_$SpecificDataTestRetrievedImpl) then) =
      __$$SpecificDataTestRetrievedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SpecificData data, Tests test});
}

/// @nodoc
class __$$SpecificDataTestRetrievedImplCopyWithImpl<$Res>
    extends _$SpecificDataStateCopyWithImpl<$Res,
        _$SpecificDataTestRetrievedImpl>
    implements _$$SpecificDataTestRetrievedImplCopyWith<$Res> {
  __$$SpecificDataTestRetrievedImplCopyWithImpl(
      _$SpecificDataTestRetrievedImpl _value,
      $Res Function(_$SpecificDataTestRetrievedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? test = null,
  }) {
    return _then(_$SpecificDataTestRetrievedImpl(
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

class _$SpecificDataTestRetrievedImpl implements SpecificDataTestRetrieved {
  const _$SpecificDataTestRetrievedImpl(this.data, this.test);

  @override
  final SpecificData data;
  @override
  final Tests test;

  @override
  String toString() {
    return 'SpecificDataState.testRetrieved(data: $data, test: $test)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecificDataTestRetrievedImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.test, test) || other.test == test));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, test);

  /// Create a copy of SpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecificDataTestRetrievedImplCopyWith<_$SpecificDataTestRetrievedImpl>
      get copyWith => __$$SpecificDataTestRetrievedImplCopyWithImpl<
          _$SpecificDataTestRetrievedImpl>(this, _$identity);

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
          final SpecificData data, final Tests test) =
      _$SpecificDataTestRetrievedImpl;

  SpecificData get data;
  Tests get test;

  /// Create a copy of SpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpecificDataTestRetrievedImplCopyWith<_$SpecificDataTestRetrievedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SpecificDataCategoryRetrievedImplCopyWith<$Res> {
  factory _$$SpecificDataCategoryRetrievedImplCopyWith(
          _$SpecificDataCategoryRetrievedImpl value,
          $Res Function(_$SpecificDataCategoryRetrievedImpl) then) =
      __$$SpecificDataCategoryRetrievedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SpecificData data, WordCategory category});
}

/// @nodoc
class __$$SpecificDataCategoryRetrievedImplCopyWithImpl<$Res>
    extends _$SpecificDataStateCopyWithImpl<$Res,
        _$SpecificDataCategoryRetrievedImpl>
    implements _$$SpecificDataCategoryRetrievedImplCopyWith<$Res> {
  __$$SpecificDataCategoryRetrievedImplCopyWithImpl(
      _$SpecificDataCategoryRetrievedImpl _value,
      $Res Function(_$SpecificDataCategoryRetrievedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? category = null,
  }) {
    return _then(_$SpecificDataCategoryRetrievedImpl(
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

class _$SpecificDataCategoryRetrievedImpl
    implements SpecificDataCategoryRetrieved {
  const _$SpecificDataCategoryRetrievedImpl(this.data, this.category);

  @override
  final SpecificData data;
  @override
  final WordCategory category;

  @override
  String toString() {
    return 'SpecificDataState.categoryRetrieved(data: $data, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecificDataCategoryRetrievedImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, category);

  /// Create a copy of SpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecificDataCategoryRetrievedImplCopyWith<
          _$SpecificDataCategoryRetrievedImpl>
      get copyWith => __$$SpecificDataCategoryRetrievedImplCopyWithImpl<
          _$SpecificDataCategoryRetrievedImpl>(this, _$identity);

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
      _$SpecificDataCategoryRetrievedImpl;

  SpecificData get data;
  WordCategory get category;

  /// Create a copy of SpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpecificDataCategoryRetrievedImplCopyWith<
          _$SpecificDataCategoryRetrievedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SpecificDataInitialImplCopyWith<$Res> {
  factory _$$SpecificDataInitialImplCopyWith(_$SpecificDataInitialImpl value,
          $Res Function(_$SpecificDataInitialImpl) then) =
      __$$SpecificDataInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SpecificDataInitialImplCopyWithImpl<$Res>
    extends _$SpecificDataStateCopyWithImpl<$Res, _$SpecificDataInitialImpl>
    implements _$$SpecificDataInitialImplCopyWith<$Res> {
  __$$SpecificDataInitialImplCopyWithImpl(_$SpecificDataInitialImpl _value,
      $Res Function(_$SpecificDataInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpecificDataState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SpecificDataInitialImpl implements SpecificDataInitial {
  const _$SpecificDataInitialImpl();

  @override
  String toString() {
    return 'SpecificDataState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecificDataInitialImpl);
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
  const factory SpecificDataInitial() = _$SpecificDataInitialImpl;
}
