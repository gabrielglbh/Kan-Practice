// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alter_specific_data_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AlterSpecificDataState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AlterSpecificData data, Tests test) testRetrieved,
    required TResult Function(AlterSpecificData data, WordCategory category)
        categoryRetrieved,
    required TResult Function() initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AlterSpecificData data, Tests test)? testRetrieved,
    TResult? Function(AlterSpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult? Function()? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AlterSpecificData data, Tests test)? testRetrieved,
    TResult Function(AlterSpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult Function()? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlterSpecificDataTestRetrieved value)
        testRetrieved,
    required TResult Function(AlterSpecificDataCategoryRetrieved value)
        categoryRetrieved,
    required TResult Function(AlterSpecificDataInitial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlterSpecificDataTestRetrieved value)? testRetrieved,
    TResult? Function(AlterSpecificDataCategoryRetrieved value)?
        categoryRetrieved,
    TResult? Function(AlterSpecificDataInitial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlterSpecificDataTestRetrieved value)? testRetrieved,
    TResult Function(AlterSpecificDataCategoryRetrieved value)?
        categoryRetrieved,
    TResult Function(AlterSpecificDataInitial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlterSpecificDataStateCopyWith<$Res> {
  factory $AlterSpecificDataStateCopyWith(AlterSpecificDataState value,
          $Res Function(AlterSpecificDataState) then) =
      _$AlterSpecificDataStateCopyWithImpl<$Res, AlterSpecificDataState>;
}

/// @nodoc
class _$AlterSpecificDataStateCopyWithImpl<$Res,
        $Val extends AlterSpecificDataState>
    implements $AlterSpecificDataStateCopyWith<$Res> {
  _$AlterSpecificDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlterSpecificDataState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AlterSpecificDataTestRetrievedImplCopyWith<$Res> {
  factory _$$AlterSpecificDataTestRetrievedImplCopyWith(
          _$AlterSpecificDataTestRetrievedImpl value,
          $Res Function(_$AlterSpecificDataTestRetrievedImpl) then) =
      __$$AlterSpecificDataTestRetrievedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AlterSpecificData data, Tests test});
}

/// @nodoc
class __$$AlterSpecificDataTestRetrievedImplCopyWithImpl<$Res>
    extends _$AlterSpecificDataStateCopyWithImpl<$Res,
        _$AlterSpecificDataTestRetrievedImpl>
    implements _$$AlterSpecificDataTestRetrievedImplCopyWith<$Res> {
  __$$AlterSpecificDataTestRetrievedImplCopyWithImpl(
      _$AlterSpecificDataTestRetrievedImpl _value,
      $Res Function(_$AlterSpecificDataTestRetrievedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlterSpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? test = null,
  }) {
    return _then(_$AlterSpecificDataTestRetrievedImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AlterSpecificData,
      null == test
          ? _value.test
          : test // ignore: cast_nullable_to_non_nullable
              as Tests,
    ));
  }
}

/// @nodoc

class _$AlterSpecificDataTestRetrievedImpl
    implements AlterSpecificDataTestRetrieved {
  const _$AlterSpecificDataTestRetrievedImpl(this.data, this.test);

  @override
  final AlterSpecificData data;
  @override
  final Tests test;

  @override
  String toString() {
    return 'AlterSpecificDataState.testRetrieved(data: $data, test: $test)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlterSpecificDataTestRetrievedImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.test, test) || other.test == test));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, test);

  /// Create a copy of AlterSpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlterSpecificDataTestRetrievedImplCopyWith<
          _$AlterSpecificDataTestRetrievedImpl>
      get copyWith => __$$AlterSpecificDataTestRetrievedImplCopyWithImpl<
          _$AlterSpecificDataTestRetrievedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AlterSpecificData data, Tests test) testRetrieved,
    required TResult Function(AlterSpecificData data, WordCategory category)
        categoryRetrieved,
    required TResult Function() initial,
  }) {
    return testRetrieved(data, test);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AlterSpecificData data, Tests test)? testRetrieved,
    TResult? Function(AlterSpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult? Function()? initial,
  }) {
    return testRetrieved?.call(data, test);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AlterSpecificData data, Tests test)? testRetrieved,
    TResult Function(AlterSpecificData data, WordCategory category)?
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
    required TResult Function(AlterSpecificDataTestRetrieved value)
        testRetrieved,
    required TResult Function(AlterSpecificDataCategoryRetrieved value)
        categoryRetrieved,
    required TResult Function(AlterSpecificDataInitial value) initial,
  }) {
    return testRetrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlterSpecificDataTestRetrieved value)? testRetrieved,
    TResult? Function(AlterSpecificDataCategoryRetrieved value)?
        categoryRetrieved,
    TResult? Function(AlterSpecificDataInitial value)? initial,
  }) {
    return testRetrieved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlterSpecificDataTestRetrieved value)? testRetrieved,
    TResult Function(AlterSpecificDataCategoryRetrieved value)?
        categoryRetrieved,
    TResult Function(AlterSpecificDataInitial value)? initial,
    required TResult orElse(),
  }) {
    if (testRetrieved != null) {
      return testRetrieved(this);
    }
    return orElse();
  }
}

abstract class AlterSpecificDataTestRetrieved
    implements AlterSpecificDataState {
  const factory AlterSpecificDataTestRetrieved(
          final AlterSpecificData data, final Tests test) =
      _$AlterSpecificDataTestRetrievedImpl;

  AlterSpecificData get data;
  Tests get test;

  /// Create a copy of AlterSpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlterSpecificDataTestRetrievedImplCopyWith<
          _$AlterSpecificDataTestRetrievedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AlterSpecificDataCategoryRetrievedImplCopyWith<$Res> {
  factory _$$AlterSpecificDataCategoryRetrievedImplCopyWith(
          _$AlterSpecificDataCategoryRetrievedImpl value,
          $Res Function(_$AlterSpecificDataCategoryRetrievedImpl) then) =
      __$$AlterSpecificDataCategoryRetrievedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AlterSpecificData data, WordCategory category});
}

/// @nodoc
class __$$AlterSpecificDataCategoryRetrievedImplCopyWithImpl<$Res>
    extends _$AlterSpecificDataStateCopyWithImpl<$Res,
        _$AlterSpecificDataCategoryRetrievedImpl>
    implements _$$AlterSpecificDataCategoryRetrievedImplCopyWith<$Res> {
  __$$AlterSpecificDataCategoryRetrievedImplCopyWithImpl(
      _$AlterSpecificDataCategoryRetrievedImpl _value,
      $Res Function(_$AlterSpecificDataCategoryRetrievedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlterSpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? category = null,
  }) {
    return _then(_$AlterSpecificDataCategoryRetrievedImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AlterSpecificData,
      null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as WordCategory,
    ));
  }
}

/// @nodoc

class _$AlterSpecificDataCategoryRetrievedImpl
    implements AlterSpecificDataCategoryRetrieved {
  const _$AlterSpecificDataCategoryRetrievedImpl(this.data, this.category);

  @override
  final AlterSpecificData data;
  @override
  final WordCategory category;

  @override
  String toString() {
    return 'AlterSpecificDataState.categoryRetrieved(data: $data, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlterSpecificDataCategoryRetrievedImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, category);

  /// Create a copy of AlterSpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlterSpecificDataCategoryRetrievedImplCopyWith<
          _$AlterSpecificDataCategoryRetrievedImpl>
      get copyWith => __$$AlterSpecificDataCategoryRetrievedImplCopyWithImpl<
          _$AlterSpecificDataCategoryRetrievedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AlterSpecificData data, Tests test) testRetrieved,
    required TResult Function(AlterSpecificData data, WordCategory category)
        categoryRetrieved,
    required TResult Function() initial,
  }) {
    return categoryRetrieved(data, category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AlterSpecificData data, Tests test)? testRetrieved,
    TResult? Function(AlterSpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult? Function()? initial,
  }) {
    return categoryRetrieved?.call(data, category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AlterSpecificData data, Tests test)? testRetrieved,
    TResult Function(AlterSpecificData data, WordCategory category)?
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
    required TResult Function(AlterSpecificDataTestRetrieved value)
        testRetrieved,
    required TResult Function(AlterSpecificDataCategoryRetrieved value)
        categoryRetrieved,
    required TResult Function(AlterSpecificDataInitial value) initial,
  }) {
    return categoryRetrieved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlterSpecificDataTestRetrieved value)? testRetrieved,
    TResult? Function(AlterSpecificDataCategoryRetrieved value)?
        categoryRetrieved,
    TResult? Function(AlterSpecificDataInitial value)? initial,
  }) {
    return categoryRetrieved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlterSpecificDataTestRetrieved value)? testRetrieved,
    TResult Function(AlterSpecificDataCategoryRetrieved value)?
        categoryRetrieved,
    TResult Function(AlterSpecificDataInitial value)? initial,
    required TResult orElse(),
  }) {
    if (categoryRetrieved != null) {
      return categoryRetrieved(this);
    }
    return orElse();
  }
}

abstract class AlterSpecificDataCategoryRetrieved
    implements AlterSpecificDataState {
  const factory AlterSpecificDataCategoryRetrieved(
          final AlterSpecificData data, final WordCategory category) =
      _$AlterSpecificDataCategoryRetrievedImpl;

  AlterSpecificData get data;
  WordCategory get category;

  /// Create a copy of AlterSpecificDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlterSpecificDataCategoryRetrievedImplCopyWith<
          _$AlterSpecificDataCategoryRetrievedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AlterSpecificDataInitialImplCopyWith<$Res> {
  factory _$$AlterSpecificDataInitialImplCopyWith(
          _$AlterSpecificDataInitialImpl value,
          $Res Function(_$AlterSpecificDataInitialImpl) then) =
      __$$AlterSpecificDataInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AlterSpecificDataInitialImplCopyWithImpl<$Res>
    extends _$AlterSpecificDataStateCopyWithImpl<$Res,
        _$AlterSpecificDataInitialImpl>
    implements _$$AlterSpecificDataInitialImplCopyWith<$Res> {
  __$$AlterSpecificDataInitialImplCopyWithImpl(
      _$AlterSpecificDataInitialImpl _value,
      $Res Function(_$AlterSpecificDataInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlterSpecificDataState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AlterSpecificDataInitialImpl implements AlterSpecificDataInitial {
  const _$AlterSpecificDataInitialImpl();

  @override
  String toString() {
    return 'AlterSpecificDataState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlterSpecificDataInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AlterSpecificData data, Tests test) testRetrieved,
    required TResult Function(AlterSpecificData data, WordCategory category)
        categoryRetrieved,
    required TResult Function() initial,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AlterSpecificData data, Tests test)? testRetrieved,
    TResult? Function(AlterSpecificData data, WordCategory category)?
        categoryRetrieved,
    TResult? Function()? initial,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AlterSpecificData data, Tests test)? testRetrieved,
    TResult Function(AlterSpecificData data, WordCategory category)?
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
    required TResult Function(AlterSpecificDataTestRetrieved value)
        testRetrieved,
    required TResult Function(AlterSpecificDataCategoryRetrieved value)
        categoryRetrieved,
    required TResult Function(AlterSpecificDataInitial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlterSpecificDataTestRetrieved value)? testRetrieved,
    TResult? Function(AlterSpecificDataCategoryRetrieved value)?
        categoryRetrieved,
    TResult? Function(AlterSpecificDataInitial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlterSpecificDataTestRetrieved value)? testRetrieved,
    TResult Function(AlterSpecificDataCategoryRetrieved value)?
        categoryRetrieved,
    TResult Function(AlterSpecificDataInitial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AlterSpecificDataInitial implements AlterSpecificDataState {
  const factory AlterSpecificDataInitial() = _$AlterSpecificDataInitialImpl;
}
