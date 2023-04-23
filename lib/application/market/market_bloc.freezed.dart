// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MarketState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Market> lists) loaded,
    required TResult Function(String message) succeeded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Market> lists)? loaded,
    TResult? Function(String message)? succeeded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Market> lists)? loaded,
    TResult Function(String message)? succeeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MarketInitial value) initial,
    required TResult Function(MarketLoading value) loading,
    required TResult Function(MarketLoaded value) loaded,
    required TResult Function(MarketSucceeded value) succeeded,
    required TResult Function(MarketError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MarketInitial value)? initial,
    TResult? Function(MarketLoading value)? loading,
    TResult? Function(MarketLoaded value)? loaded,
    TResult? Function(MarketSucceeded value)? succeeded,
    TResult? Function(MarketError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MarketInitial value)? initial,
    TResult Function(MarketLoading value)? loading,
    TResult Function(MarketLoaded value)? loaded,
    TResult Function(MarketSucceeded value)? succeeded,
    TResult Function(MarketError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketStateCopyWith<$Res> {
  factory $MarketStateCopyWith(
          MarketState value, $Res Function(MarketState) then) =
      _$MarketStateCopyWithImpl<$Res, MarketState>;
}

/// @nodoc
class _$MarketStateCopyWithImpl<$Res, $Val extends MarketState>
    implements $MarketStateCopyWith<$Res> {
  _$MarketStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MarketInitialCopyWith<$Res> {
  factory _$$MarketInitialCopyWith(
          _$MarketInitial value, $Res Function(_$MarketInitial) then) =
      __$$MarketInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MarketInitialCopyWithImpl<$Res>
    extends _$MarketStateCopyWithImpl<$Res, _$MarketInitial>
    implements _$$MarketInitialCopyWith<$Res> {
  __$$MarketInitialCopyWithImpl(
      _$MarketInitial _value, $Res Function(_$MarketInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MarketInitial implements MarketInitial {
  const _$MarketInitial();

  @override
  String toString() {
    return 'MarketState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MarketInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Market> lists) loaded,
    required TResult Function(String message) succeeded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Market> lists)? loaded,
    TResult? Function(String message)? succeeded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Market> lists)? loaded,
    TResult Function(String message)? succeeded,
    TResult Function(String message)? error,
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
    required TResult Function(MarketInitial value) initial,
    required TResult Function(MarketLoading value) loading,
    required TResult Function(MarketLoaded value) loaded,
    required TResult Function(MarketSucceeded value) succeeded,
    required TResult Function(MarketError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MarketInitial value)? initial,
    TResult? Function(MarketLoading value)? loading,
    TResult? Function(MarketLoaded value)? loaded,
    TResult? Function(MarketSucceeded value)? succeeded,
    TResult? Function(MarketError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MarketInitial value)? initial,
    TResult Function(MarketLoading value)? loading,
    TResult Function(MarketLoaded value)? loaded,
    TResult Function(MarketSucceeded value)? succeeded,
    TResult Function(MarketError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MarketInitial implements MarketState {
  const factory MarketInitial() = _$MarketInitial;
}

/// @nodoc
abstract class _$$MarketLoadingCopyWith<$Res> {
  factory _$$MarketLoadingCopyWith(
          _$MarketLoading value, $Res Function(_$MarketLoading) then) =
      __$$MarketLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MarketLoadingCopyWithImpl<$Res>
    extends _$MarketStateCopyWithImpl<$Res, _$MarketLoading>
    implements _$$MarketLoadingCopyWith<$Res> {
  __$$MarketLoadingCopyWithImpl(
      _$MarketLoading _value, $Res Function(_$MarketLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MarketLoading implements MarketLoading {
  const _$MarketLoading();

  @override
  String toString() {
    return 'MarketState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MarketLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Market> lists) loaded,
    required TResult Function(String message) succeeded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Market> lists)? loaded,
    TResult? Function(String message)? succeeded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Market> lists)? loaded,
    TResult Function(String message)? succeeded,
    TResult Function(String message)? error,
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
    required TResult Function(MarketInitial value) initial,
    required TResult Function(MarketLoading value) loading,
    required TResult Function(MarketLoaded value) loaded,
    required TResult Function(MarketSucceeded value) succeeded,
    required TResult Function(MarketError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MarketInitial value)? initial,
    TResult? Function(MarketLoading value)? loading,
    TResult? Function(MarketLoaded value)? loaded,
    TResult? Function(MarketSucceeded value)? succeeded,
    TResult? Function(MarketError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MarketInitial value)? initial,
    TResult Function(MarketLoading value)? loading,
    TResult Function(MarketLoaded value)? loaded,
    TResult Function(MarketSucceeded value)? succeeded,
    TResult Function(MarketError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MarketLoading implements MarketState {
  const factory MarketLoading() = _$MarketLoading;
}

/// @nodoc
abstract class _$$MarketLoadedCopyWith<$Res> {
  factory _$$MarketLoadedCopyWith(
          _$MarketLoaded value, $Res Function(_$MarketLoaded) then) =
      __$$MarketLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Market> lists});
}

/// @nodoc
class __$$MarketLoadedCopyWithImpl<$Res>
    extends _$MarketStateCopyWithImpl<$Res, _$MarketLoaded>
    implements _$$MarketLoadedCopyWith<$Res> {
  __$$MarketLoadedCopyWithImpl(
      _$MarketLoaded _value, $Res Function(_$MarketLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lists = null,
  }) {
    return _then(_$MarketLoaded(
      null == lists
          ? _value._lists
          : lists // ignore: cast_nullable_to_non_nullable
              as List<Market>,
    ));
  }
}

/// @nodoc

class _$MarketLoaded implements MarketLoaded {
  const _$MarketLoaded(final List<Market> lists) : _lists = lists;

  final List<Market> _lists;
  @override
  List<Market> get lists {
    if (_lists is EqualUnmodifiableListView) return _lists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lists);
  }

  @override
  String toString() {
    return 'MarketState.loaded(lists: $lists)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketLoaded &&
            const DeepCollectionEquality().equals(other._lists, _lists));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_lists));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketLoadedCopyWith<_$MarketLoaded> get copyWith =>
      __$$MarketLoadedCopyWithImpl<_$MarketLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Market> lists) loaded,
    required TResult Function(String message) succeeded,
    required TResult Function(String message) error,
  }) {
    return loaded(lists);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Market> lists)? loaded,
    TResult? Function(String message)? succeeded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(lists);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Market> lists)? loaded,
    TResult Function(String message)? succeeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(lists);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MarketInitial value) initial,
    required TResult Function(MarketLoading value) loading,
    required TResult Function(MarketLoaded value) loaded,
    required TResult Function(MarketSucceeded value) succeeded,
    required TResult Function(MarketError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MarketInitial value)? initial,
    TResult? Function(MarketLoading value)? loading,
    TResult? Function(MarketLoaded value)? loaded,
    TResult? Function(MarketSucceeded value)? succeeded,
    TResult? Function(MarketError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MarketInitial value)? initial,
    TResult Function(MarketLoading value)? loading,
    TResult Function(MarketLoaded value)? loaded,
    TResult Function(MarketSucceeded value)? succeeded,
    TResult Function(MarketError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class MarketLoaded implements MarketState {
  const factory MarketLoaded(final List<Market> lists) = _$MarketLoaded;

  List<Market> get lists;
  @JsonKey(ignore: true)
  _$$MarketLoadedCopyWith<_$MarketLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarketSucceededCopyWith<$Res> {
  factory _$$MarketSucceededCopyWith(
          _$MarketSucceeded value, $Res Function(_$MarketSucceeded) then) =
      __$$MarketSucceededCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MarketSucceededCopyWithImpl<$Res>
    extends _$MarketStateCopyWithImpl<$Res, _$MarketSucceeded>
    implements _$$MarketSucceededCopyWith<$Res> {
  __$$MarketSucceededCopyWithImpl(
      _$MarketSucceeded _value, $Res Function(_$MarketSucceeded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MarketSucceeded(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MarketSucceeded implements MarketSucceeded {
  const _$MarketSucceeded(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'MarketState.succeeded(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketSucceeded &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketSucceededCopyWith<_$MarketSucceeded> get copyWith =>
      __$$MarketSucceededCopyWithImpl<_$MarketSucceeded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Market> lists) loaded,
    required TResult Function(String message) succeeded,
    required TResult Function(String message) error,
  }) {
    return succeeded(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Market> lists)? loaded,
    TResult? Function(String message)? succeeded,
    TResult? Function(String message)? error,
  }) {
    return succeeded?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Market> lists)? loaded,
    TResult Function(String message)? succeeded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (succeeded != null) {
      return succeeded(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MarketInitial value) initial,
    required TResult Function(MarketLoading value) loading,
    required TResult Function(MarketLoaded value) loaded,
    required TResult Function(MarketSucceeded value) succeeded,
    required TResult Function(MarketError value) error,
  }) {
    return succeeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MarketInitial value)? initial,
    TResult? Function(MarketLoading value)? loading,
    TResult? Function(MarketLoaded value)? loaded,
    TResult? Function(MarketSucceeded value)? succeeded,
    TResult? Function(MarketError value)? error,
  }) {
    return succeeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MarketInitial value)? initial,
    TResult Function(MarketLoading value)? loading,
    TResult Function(MarketLoaded value)? loaded,
    TResult Function(MarketSucceeded value)? succeeded,
    TResult Function(MarketError value)? error,
    required TResult orElse(),
  }) {
    if (succeeded != null) {
      return succeeded(this);
    }
    return orElse();
  }
}

abstract class MarketSucceeded implements MarketState {
  const factory MarketSucceeded(final String message) = _$MarketSucceeded;

  String get message;
  @JsonKey(ignore: true)
  _$$MarketSucceededCopyWith<_$MarketSucceeded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarketErrorCopyWith<$Res> {
  factory _$$MarketErrorCopyWith(
          _$MarketError value, $Res Function(_$MarketError) then) =
      __$$MarketErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MarketErrorCopyWithImpl<$Res>
    extends _$MarketStateCopyWithImpl<$Res, _$MarketError>
    implements _$$MarketErrorCopyWith<$Res> {
  __$$MarketErrorCopyWithImpl(
      _$MarketError _value, $Res Function(_$MarketError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MarketError(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MarketError implements MarketError {
  const _$MarketError(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'MarketState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketErrorCopyWith<_$MarketError> get copyWith =>
      __$$MarketErrorCopyWithImpl<_$MarketError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Market> lists) loaded,
    required TResult Function(String message) succeeded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Market> lists)? loaded,
    TResult? Function(String message)? succeeded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Market> lists)? loaded,
    TResult Function(String message)? succeeded,
    TResult Function(String message)? error,
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
    required TResult Function(MarketInitial value) initial,
    required TResult Function(MarketLoading value) loading,
    required TResult Function(MarketLoaded value) loaded,
    required TResult Function(MarketSucceeded value) succeeded,
    required TResult Function(MarketError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MarketInitial value)? initial,
    TResult? Function(MarketLoading value)? loading,
    TResult? Function(MarketLoaded value)? loaded,
    TResult? Function(MarketSucceeded value)? succeeded,
    TResult? Function(MarketError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MarketInitial value)? initial,
    TResult Function(MarketLoading value)? loading,
    TResult Function(MarketLoaded value)? loaded,
    TResult Function(MarketSucceeded value)? succeeded,
    TResult Function(MarketError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MarketError implements MarketState {
  const factory MarketError(final String message) = _$MarketError;

  String get message;
  @JsonKey(ignore: true)
  _$$MarketErrorCopyWith<_$MarketError> get copyWith =>
      throw _privateConstructorUsedError;
}
