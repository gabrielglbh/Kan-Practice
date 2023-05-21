// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchases_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PurchasesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<StoreProduct> products) loaded,
    required TResult Function() updatedToPro,
    required TResult Function() nonPro,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<StoreProduct> products)? loaded,
    TResult? Function()? updatedToPro,
    TResult? Function()? nonPro,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<StoreProduct> products)? loaded,
    TResult Function()? updatedToPro,
    TResult Function()? nonPro,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PurchasesInitial value) initial,
    required TResult Function(PurchasesLoading value) loading,
    required TResult Function(PurchasesError value) error,
    required TResult Function(PurchasesLoaded value) loaded,
    required TResult Function(PurchasesUpdatedToPro value) updatedToPro,
    required TResult Function(PurchasesNonPro value) nonPro,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PurchasesInitial value)? initial,
    TResult? Function(PurchasesLoading value)? loading,
    TResult? Function(PurchasesError value)? error,
    TResult? Function(PurchasesLoaded value)? loaded,
    TResult? Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult? Function(PurchasesNonPro value)? nonPro,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PurchasesInitial value)? initial,
    TResult Function(PurchasesLoading value)? loading,
    TResult Function(PurchasesError value)? error,
    TResult Function(PurchasesLoaded value)? loaded,
    TResult Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult Function(PurchasesNonPro value)? nonPro,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchasesStateCopyWith<$Res> {
  factory $PurchasesStateCopyWith(
          PurchasesState value, $Res Function(PurchasesState) then) =
      _$PurchasesStateCopyWithImpl<$Res, PurchasesState>;
}

/// @nodoc
class _$PurchasesStateCopyWithImpl<$Res, $Val extends PurchasesState>
    implements $PurchasesStateCopyWith<$Res> {
  _$PurchasesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PurchasesInitialCopyWith<$Res> {
  factory _$$PurchasesInitialCopyWith(
          _$PurchasesInitial value, $Res Function(_$PurchasesInitial) then) =
      __$$PurchasesInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PurchasesInitialCopyWithImpl<$Res>
    extends _$PurchasesStateCopyWithImpl<$Res, _$PurchasesInitial>
    implements _$$PurchasesInitialCopyWith<$Res> {
  __$$PurchasesInitialCopyWithImpl(
      _$PurchasesInitial _value, $Res Function(_$PurchasesInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PurchasesInitial implements PurchasesInitial {
  const _$PurchasesInitial();

  @override
  String toString() {
    return 'PurchasesState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PurchasesInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<StoreProduct> products) loaded,
    required TResult Function() updatedToPro,
    required TResult Function() nonPro,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<StoreProduct> products)? loaded,
    TResult? Function()? updatedToPro,
    TResult? Function()? nonPro,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<StoreProduct> products)? loaded,
    TResult Function()? updatedToPro,
    TResult Function()? nonPro,
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
    required TResult Function(PurchasesInitial value) initial,
    required TResult Function(PurchasesLoading value) loading,
    required TResult Function(PurchasesError value) error,
    required TResult Function(PurchasesLoaded value) loaded,
    required TResult Function(PurchasesUpdatedToPro value) updatedToPro,
    required TResult Function(PurchasesNonPro value) nonPro,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PurchasesInitial value)? initial,
    TResult? Function(PurchasesLoading value)? loading,
    TResult? Function(PurchasesError value)? error,
    TResult? Function(PurchasesLoaded value)? loaded,
    TResult? Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult? Function(PurchasesNonPro value)? nonPro,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PurchasesInitial value)? initial,
    TResult Function(PurchasesLoading value)? loading,
    TResult Function(PurchasesError value)? error,
    TResult Function(PurchasesLoaded value)? loaded,
    TResult Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult Function(PurchasesNonPro value)? nonPro,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PurchasesInitial implements PurchasesState {
  const factory PurchasesInitial() = _$PurchasesInitial;
}

/// @nodoc
abstract class _$$PurchasesLoadingCopyWith<$Res> {
  factory _$$PurchasesLoadingCopyWith(
          _$PurchasesLoading value, $Res Function(_$PurchasesLoading) then) =
      __$$PurchasesLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PurchasesLoadingCopyWithImpl<$Res>
    extends _$PurchasesStateCopyWithImpl<$Res, _$PurchasesLoading>
    implements _$$PurchasesLoadingCopyWith<$Res> {
  __$$PurchasesLoadingCopyWithImpl(
      _$PurchasesLoading _value, $Res Function(_$PurchasesLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PurchasesLoading implements PurchasesLoading {
  const _$PurchasesLoading();

  @override
  String toString() {
    return 'PurchasesState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PurchasesLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<StoreProduct> products) loaded,
    required TResult Function() updatedToPro,
    required TResult Function() nonPro,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<StoreProduct> products)? loaded,
    TResult? Function()? updatedToPro,
    TResult? Function()? nonPro,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<StoreProduct> products)? loaded,
    TResult Function()? updatedToPro,
    TResult Function()? nonPro,
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
    required TResult Function(PurchasesInitial value) initial,
    required TResult Function(PurchasesLoading value) loading,
    required TResult Function(PurchasesError value) error,
    required TResult Function(PurchasesLoaded value) loaded,
    required TResult Function(PurchasesUpdatedToPro value) updatedToPro,
    required TResult Function(PurchasesNonPro value) nonPro,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PurchasesInitial value)? initial,
    TResult? Function(PurchasesLoading value)? loading,
    TResult? Function(PurchasesError value)? error,
    TResult? Function(PurchasesLoaded value)? loaded,
    TResult? Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult? Function(PurchasesNonPro value)? nonPro,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PurchasesInitial value)? initial,
    TResult Function(PurchasesLoading value)? loading,
    TResult Function(PurchasesError value)? error,
    TResult Function(PurchasesLoaded value)? loaded,
    TResult Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult Function(PurchasesNonPro value)? nonPro,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PurchasesLoading implements PurchasesState {
  const factory PurchasesLoading() = _$PurchasesLoading;
}

/// @nodoc
abstract class _$$PurchasesErrorCopyWith<$Res> {
  factory _$$PurchasesErrorCopyWith(
          _$PurchasesError value, $Res Function(_$PurchasesError) then) =
      __$$PurchasesErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PurchasesErrorCopyWithImpl<$Res>
    extends _$PurchasesStateCopyWithImpl<$Res, _$PurchasesError>
    implements _$$PurchasesErrorCopyWith<$Res> {
  __$$PurchasesErrorCopyWithImpl(
      _$PurchasesError _value, $Res Function(_$PurchasesError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$PurchasesError(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PurchasesError implements PurchasesError {
  const _$PurchasesError(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'PurchasesState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchasesError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchasesErrorCopyWith<_$PurchasesError> get copyWith =>
      __$$PurchasesErrorCopyWithImpl<_$PurchasesError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<StoreProduct> products) loaded,
    required TResult Function() updatedToPro,
    required TResult Function() nonPro,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<StoreProduct> products)? loaded,
    TResult? Function()? updatedToPro,
    TResult? Function()? nonPro,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<StoreProduct> products)? loaded,
    TResult Function()? updatedToPro,
    TResult Function()? nonPro,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PurchasesInitial value) initial,
    required TResult Function(PurchasesLoading value) loading,
    required TResult Function(PurchasesError value) error,
    required TResult Function(PurchasesLoaded value) loaded,
    required TResult Function(PurchasesUpdatedToPro value) updatedToPro,
    required TResult Function(PurchasesNonPro value) nonPro,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PurchasesInitial value)? initial,
    TResult? Function(PurchasesLoading value)? loading,
    TResult? Function(PurchasesError value)? error,
    TResult? Function(PurchasesLoaded value)? loaded,
    TResult? Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult? Function(PurchasesNonPro value)? nonPro,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PurchasesInitial value)? initial,
    TResult Function(PurchasesLoading value)? loading,
    TResult Function(PurchasesError value)? error,
    TResult Function(PurchasesLoaded value)? loaded,
    TResult Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult Function(PurchasesNonPro value)? nonPro,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PurchasesError implements PurchasesState {
  const factory PurchasesError(final String message) = _$PurchasesError;

  String get message;
  @JsonKey(ignore: true)
  _$$PurchasesErrorCopyWith<_$PurchasesError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PurchasesLoadedCopyWith<$Res> {
  factory _$$PurchasesLoadedCopyWith(
          _$PurchasesLoaded value, $Res Function(_$PurchasesLoaded) then) =
      __$$PurchasesLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<StoreProduct> products});
}

/// @nodoc
class __$$PurchasesLoadedCopyWithImpl<$Res>
    extends _$PurchasesStateCopyWithImpl<$Res, _$PurchasesLoaded>
    implements _$$PurchasesLoadedCopyWith<$Res> {
  __$$PurchasesLoadedCopyWithImpl(
      _$PurchasesLoaded _value, $Res Function(_$PurchasesLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
  }) {
    return _then(_$PurchasesLoaded(
      null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<StoreProduct>,
    ));
  }
}

/// @nodoc

class _$PurchasesLoaded implements PurchasesLoaded {
  const _$PurchasesLoaded(final List<StoreProduct> products)
      : _products = products;

  final List<StoreProduct> _products;
  @override
  List<StoreProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'PurchasesState.loaded(products: $products)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchasesLoaded &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchasesLoadedCopyWith<_$PurchasesLoaded> get copyWith =>
      __$$PurchasesLoadedCopyWithImpl<_$PurchasesLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<StoreProduct> products) loaded,
    required TResult Function() updatedToPro,
    required TResult Function() nonPro,
  }) {
    return loaded(products);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<StoreProduct> products)? loaded,
    TResult? Function()? updatedToPro,
    TResult? Function()? nonPro,
  }) {
    return loaded?.call(products);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<StoreProduct> products)? loaded,
    TResult Function()? updatedToPro,
    TResult Function()? nonPro,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(products);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PurchasesInitial value) initial,
    required TResult Function(PurchasesLoading value) loading,
    required TResult Function(PurchasesError value) error,
    required TResult Function(PurchasesLoaded value) loaded,
    required TResult Function(PurchasesUpdatedToPro value) updatedToPro,
    required TResult Function(PurchasesNonPro value) nonPro,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PurchasesInitial value)? initial,
    TResult? Function(PurchasesLoading value)? loading,
    TResult? Function(PurchasesError value)? error,
    TResult? Function(PurchasesLoaded value)? loaded,
    TResult? Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult? Function(PurchasesNonPro value)? nonPro,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PurchasesInitial value)? initial,
    TResult Function(PurchasesLoading value)? loading,
    TResult Function(PurchasesError value)? error,
    TResult Function(PurchasesLoaded value)? loaded,
    TResult Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult Function(PurchasesNonPro value)? nonPro,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PurchasesLoaded implements PurchasesState {
  const factory PurchasesLoaded(final List<StoreProduct> products) =
      _$PurchasesLoaded;

  List<StoreProduct> get products;
  @JsonKey(ignore: true)
  _$$PurchasesLoadedCopyWith<_$PurchasesLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PurchasesUpdatedToProCopyWith<$Res> {
  factory _$$PurchasesUpdatedToProCopyWith(_$PurchasesUpdatedToPro value,
          $Res Function(_$PurchasesUpdatedToPro) then) =
      __$$PurchasesUpdatedToProCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PurchasesUpdatedToProCopyWithImpl<$Res>
    extends _$PurchasesStateCopyWithImpl<$Res, _$PurchasesUpdatedToPro>
    implements _$$PurchasesUpdatedToProCopyWith<$Res> {
  __$$PurchasesUpdatedToProCopyWithImpl(_$PurchasesUpdatedToPro _value,
      $Res Function(_$PurchasesUpdatedToPro) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PurchasesUpdatedToPro implements PurchasesUpdatedToPro {
  const _$PurchasesUpdatedToPro();

  @override
  String toString() {
    return 'PurchasesState.updatedToPro()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PurchasesUpdatedToPro);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<StoreProduct> products) loaded,
    required TResult Function() updatedToPro,
    required TResult Function() nonPro,
  }) {
    return updatedToPro();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<StoreProduct> products)? loaded,
    TResult? Function()? updatedToPro,
    TResult? Function()? nonPro,
  }) {
    return updatedToPro?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<StoreProduct> products)? loaded,
    TResult Function()? updatedToPro,
    TResult Function()? nonPro,
    required TResult orElse(),
  }) {
    if (updatedToPro != null) {
      return updatedToPro();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PurchasesInitial value) initial,
    required TResult Function(PurchasesLoading value) loading,
    required TResult Function(PurchasesError value) error,
    required TResult Function(PurchasesLoaded value) loaded,
    required TResult Function(PurchasesUpdatedToPro value) updatedToPro,
    required TResult Function(PurchasesNonPro value) nonPro,
  }) {
    return updatedToPro(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PurchasesInitial value)? initial,
    TResult? Function(PurchasesLoading value)? loading,
    TResult? Function(PurchasesError value)? error,
    TResult? Function(PurchasesLoaded value)? loaded,
    TResult? Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult? Function(PurchasesNonPro value)? nonPro,
  }) {
    return updatedToPro?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PurchasesInitial value)? initial,
    TResult Function(PurchasesLoading value)? loading,
    TResult Function(PurchasesError value)? error,
    TResult Function(PurchasesLoaded value)? loaded,
    TResult Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult Function(PurchasesNonPro value)? nonPro,
    required TResult orElse(),
  }) {
    if (updatedToPro != null) {
      return updatedToPro(this);
    }
    return orElse();
  }
}

abstract class PurchasesUpdatedToPro implements PurchasesState {
  const factory PurchasesUpdatedToPro() = _$PurchasesUpdatedToPro;
}

/// @nodoc
abstract class _$$PurchasesNonProCopyWith<$Res> {
  factory _$$PurchasesNonProCopyWith(
          _$PurchasesNonPro value, $Res Function(_$PurchasesNonPro) then) =
      __$$PurchasesNonProCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PurchasesNonProCopyWithImpl<$Res>
    extends _$PurchasesStateCopyWithImpl<$Res, _$PurchasesNonPro>
    implements _$$PurchasesNonProCopyWith<$Res> {
  __$$PurchasesNonProCopyWithImpl(
      _$PurchasesNonPro _value, $Res Function(_$PurchasesNonPro) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PurchasesNonPro implements PurchasesNonPro {
  const _$PurchasesNonPro();

  @override
  String toString() {
    return 'PurchasesState.nonPro()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PurchasesNonPro);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<StoreProduct> products) loaded,
    required TResult Function() updatedToPro,
    required TResult Function() nonPro,
  }) {
    return nonPro();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<StoreProduct> products)? loaded,
    TResult? Function()? updatedToPro,
    TResult? Function()? nonPro,
  }) {
    return nonPro?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<StoreProduct> products)? loaded,
    TResult Function()? updatedToPro,
    TResult Function()? nonPro,
    required TResult orElse(),
  }) {
    if (nonPro != null) {
      return nonPro();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PurchasesInitial value) initial,
    required TResult Function(PurchasesLoading value) loading,
    required TResult Function(PurchasesError value) error,
    required TResult Function(PurchasesLoaded value) loaded,
    required TResult Function(PurchasesUpdatedToPro value) updatedToPro,
    required TResult Function(PurchasesNonPro value) nonPro,
  }) {
    return nonPro(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PurchasesInitial value)? initial,
    TResult? Function(PurchasesLoading value)? loading,
    TResult? Function(PurchasesError value)? error,
    TResult? Function(PurchasesLoaded value)? loaded,
    TResult? Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult? Function(PurchasesNonPro value)? nonPro,
  }) {
    return nonPro?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PurchasesInitial value)? initial,
    TResult Function(PurchasesLoading value)? loading,
    TResult Function(PurchasesError value)? error,
    TResult Function(PurchasesLoaded value)? loaded,
    TResult Function(PurchasesUpdatedToPro value)? updatedToPro,
    TResult Function(PurchasesNonPro value)? nonPro,
    required TResult orElse(),
  }) {
    if (nonPro != null) {
      return nonPro(this);
    }
    return orElse();
  }
}

abstract class PurchasesNonPro implements PurchasesState {
  const factory PurchasesNonPro() = _$PurchasesNonPro;
}
