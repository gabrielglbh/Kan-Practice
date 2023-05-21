// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_page_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OCRPageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String translation, File? image)
        translationLoaded,
    required TResult Function(String text, File? image) imageLoaded,
    required TResult Function(File? image) imageCropped,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String translation, File? image)? translationLoaded,
    TResult? Function(String text, File? image)? imageLoaded,
    TResult? Function(File? image)? imageCropped,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String translation, File? image)? translationLoaded,
    TResult Function(String text, File? image)? imageLoaded,
    TResult Function(File? image)? imageCropped,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OCRPageInitial value) initial,
    required TResult Function(OCRPageLoading value) loading,
    required TResult Function(OCRPageTranslationLoaded value) translationLoaded,
    required TResult Function(OCRPageImageLoaded value) imageLoaded,
    required TResult Function(OCRPageImageCropped value) imageCropped,
    required TResult Function(OCRPageError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OCRPageInitial value)? initial,
    TResult? Function(OCRPageLoading value)? loading,
    TResult? Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult? Function(OCRPageImageLoaded value)? imageLoaded,
    TResult? Function(OCRPageImageCropped value)? imageCropped,
    TResult? Function(OCRPageError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OCRPageInitial value)? initial,
    TResult Function(OCRPageLoading value)? loading,
    TResult Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult Function(OCRPageImageLoaded value)? imageLoaded,
    TResult Function(OCRPageImageCropped value)? imageCropped,
    TResult Function(OCRPageError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OCRPageStateCopyWith<$Res> {
  factory $OCRPageStateCopyWith(
          OCRPageState value, $Res Function(OCRPageState) then) =
      _$OCRPageStateCopyWithImpl<$Res, OCRPageState>;
}

/// @nodoc
class _$OCRPageStateCopyWithImpl<$Res, $Val extends OCRPageState>
    implements $OCRPageStateCopyWith<$Res> {
  _$OCRPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OCRPageInitialCopyWith<$Res> {
  factory _$$OCRPageInitialCopyWith(
          _$OCRPageInitial value, $Res Function(_$OCRPageInitial) then) =
      __$$OCRPageInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OCRPageInitialCopyWithImpl<$Res>
    extends _$OCRPageStateCopyWithImpl<$Res, _$OCRPageInitial>
    implements _$$OCRPageInitialCopyWith<$Res> {
  __$$OCRPageInitialCopyWithImpl(
      _$OCRPageInitial _value, $Res Function(_$OCRPageInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OCRPageInitial implements OCRPageInitial {
  const _$OCRPageInitial();

  @override
  String toString() {
    return 'OCRPageState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OCRPageInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String translation, File? image)
        translationLoaded,
    required TResult Function(String text, File? image) imageLoaded,
    required TResult Function(File? image) imageCropped,
    required TResult Function() error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String translation, File? image)? translationLoaded,
    TResult? Function(String text, File? image)? imageLoaded,
    TResult? Function(File? image)? imageCropped,
    TResult? Function()? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String translation, File? image)? translationLoaded,
    TResult Function(String text, File? image)? imageLoaded,
    TResult Function(File? image)? imageCropped,
    TResult Function()? error,
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
    required TResult Function(OCRPageInitial value) initial,
    required TResult Function(OCRPageLoading value) loading,
    required TResult Function(OCRPageTranslationLoaded value) translationLoaded,
    required TResult Function(OCRPageImageLoaded value) imageLoaded,
    required TResult Function(OCRPageImageCropped value) imageCropped,
    required TResult Function(OCRPageError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OCRPageInitial value)? initial,
    TResult? Function(OCRPageLoading value)? loading,
    TResult? Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult? Function(OCRPageImageLoaded value)? imageLoaded,
    TResult? Function(OCRPageImageCropped value)? imageCropped,
    TResult? Function(OCRPageError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OCRPageInitial value)? initial,
    TResult Function(OCRPageLoading value)? loading,
    TResult Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult Function(OCRPageImageLoaded value)? imageLoaded,
    TResult Function(OCRPageImageCropped value)? imageCropped,
    TResult Function(OCRPageError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class OCRPageInitial implements OCRPageState {
  const factory OCRPageInitial() = _$OCRPageInitial;
}

/// @nodoc
abstract class _$$OCRPageLoadingCopyWith<$Res> {
  factory _$$OCRPageLoadingCopyWith(
          _$OCRPageLoading value, $Res Function(_$OCRPageLoading) then) =
      __$$OCRPageLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OCRPageLoadingCopyWithImpl<$Res>
    extends _$OCRPageStateCopyWithImpl<$Res, _$OCRPageLoading>
    implements _$$OCRPageLoadingCopyWith<$Res> {
  __$$OCRPageLoadingCopyWithImpl(
      _$OCRPageLoading _value, $Res Function(_$OCRPageLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OCRPageLoading implements OCRPageLoading {
  const _$OCRPageLoading();

  @override
  String toString() {
    return 'OCRPageState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OCRPageLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String translation, File? image)
        translationLoaded,
    required TResult Function(String text, File? image) imageLoaded,
    required TResult Function(File? image) imageCropped,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String translation, File? image)? translationLoaded,
    TResult? Function(String text, File? image)? imageLoaded,
    TResult? Function(File? image)? imageCropped,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String translation, File? image)? translationLoaded,
    TResult Function(String text, File? image)? imageLoaded,
    TResult Function(File? image)? imageCropped,
    TResult Function()? error,
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
    required TResult Function(OCRPageInitial value) initial,
    required TResult Function(OCRPageLoading value) loading,
    required TResult Function(OCRPageTranslationLoaded value) translationLoaded,
    required TResult Function(OCRPageImageLoaded value) imageLoaded,
    required TResult Function(OCRPageImageCropped value) imageCropped,
    required TResult Function(OCRPageError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OCRPageInitial value)? initial,
    TResult? Function(OCRPageLoading value)? loading,
    TResult? Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult? Function(OCRPageImageLoaded value)? imageLoaded,
    TResult? Function(OCRPageImageCropped value)? imageCropped,
    TResult? Function(OCRPageError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OCRPageInitial value)? initial,
    TResult Function(OCRPageLoading value)? loading,
    TResult Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult Function(OCRPageImageLoaded value)? imageLoaded,
    TResult Function(OCRPageImageCropped value)? imageCropped,
    TResult Function(OCRPageError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OCRPageLoading implements OCRPageState {
  const factory OCRPageLoading() = _$OCRPageLoading;
}

/// @nodoc
abstract class _$$OCRPageTranslationLoadedCopyWith<$Res> {
  factory _$$OCRPageTranslationLoadedCopyWith(_$OCRPageTranslationLoaded value,
          $Res Function(_$OCRPageTranslationLoaded) then) =
      __$$OCRPageTranslationLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({String translation, File? image});
}

/// @nodoc
class __$$OCRPageTranslationLoadedCopyWithImpl<$Res>
    extends _$OCRPageStateCopyWithImpl<$Res, _$OCRPageTranslationLoaded>
    implements _$$OCRPageTranslationLoadedCopyWith<$Res> {
  __$$OCRPageTranslationLoadedCopyWithImpl(_$OCRPageTranslationLoaded _value,
      $Res Function(_$OCRPageTranslationLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? translation = null,
    Object? image = freezed,
  }) {
    return _then(_$OCRPageTranslationLoaded(
      null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$OCRPageTranslationLoaded implements OCRPageTranslationLoaded {
  const _$OCRPageTranslationLoaded(this.translation, {this.image});

  @override
  final String translation;
  @override
  final File? image;

  @override
  String toString() {
    return 'OCRPageState.translationLoaded(translation: $translation, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OCRPageTranslationLoaded &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, translation, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OCRPageTranslationLoadedCopyWith<_$OCRPageTranslationLoaded>
      get copyWith =>
          __$$OCRPageTranslationLoadedCopyWithImpl<_$OCRPageTranslationLoaded>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String translation, File? image)
        translationLoaded,
    required TResult Function(String text, File? image) imageLoaded,
    required TResult Function(File? image) imageCropped,
    required TResult Function() error,
  }) {
    return translationLoaded(translation, image);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String translation, File? image)? translationLoaded,
    TResult? Function(String text, File? image)? imageLoaded,
    TResult? Function(File? image)? imageCropped,
    TResult? Function()? error,
  }) {
    return translationLoaded?.call(translation, image);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String translation, File? image)? translationLoaded,
    TResult Function(String text, File? image)? imageLoaded,
    TResult Function(File? image)? imageCropped,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (translationLoaded != null) {
      return translationLoaded(translation, image);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OCRPageInitial value) initial,
    required TResult Function(OCRPageLoading value) loading,
    required TResult Function(OCRPageTranslationLoaded value) translationLoaded,
    required TResult Function(OCRPageImageLoaded value) imageLoaded,
    required TResult Function(OCRPageImageCropped value) imageCropped,
    required TResult Function(OCRPageError value) error,
  }) {
    return translationLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OCRPageInitial value)? initial,
    TResult? Function(OCRPageLoading value)? loading,
    TResult? Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult? Function(OCRPageImageLoaded value)? imageLoaded,
    TResult? Function(OCRPageImageCropped value)? imageCropped,
    TResult? Function(OCRPageError value)? error,
  }) {
    return translationLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OCRPageInitial value)? initial,
    TResult Function(OCRPageLoading value)? loading,
    TResult Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult Function(OCRPageImageLoaded value)? imageLoaded,
    TResult Function(OCRPageImageCropped value)? imageCropped,
    TResult Function(OCRPageError value)? error,
    required TResult orElse(),
  }) {
    if (translationLoaded != null) {
      return translationLoaded(this);
    }
    return orElse();
  }
}

abstract class OCRPageTranslationLoaded implements OCRPageState {
  const factory OCRPageTranslationLoaded(final String translation,
      {final File? image}) = _$OCRPageTranslationLoaded;

  String get translation;
  File? get image;
  @JsonKey(ignore: true)
  _$$OCRPageTranslationLoadedCopyWith<_$OCRPageTranslationLoaded>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OCRPageImageLoadedCopyWith<$Res> {
  factory _$$OCRPageImageLoadedCopyWith(_$OCRPageImageLoaded value,
          $Res Function(_$OCRPageImageLoaded) then) =
      __$$OCRPageImageLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({String text, File? image});
}

/// @nodoc
class __$$OCRPageImageLoadedCopyWithImpl<$Res>
    extends _$OCRPageStateCopyWithImpl<$Res, _$OCRPageImageLoaded>
    implements _$$OCRPageImageLoadedCopyWith<$Res> {
  __$$OCRPageImageLoadedCopyWithImpl(
      _$OCRPageImageLoaded _value, $Res Function(_$OCRPageImageLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? image = freezed,
  }) {
    return _then(_$OCRPageImageLoaded(
      null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$OCRPageImageLoaded implements OCRPageImageLoaded {
  const _$OCRPageImageLoaded(this.text, {this.image});

  @override
  final String text;
  @override
  final File? image;

  @override
  String toString() {
    return 'OCRPageState.imageLoaded(text: $text, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OCRPageImageLoaded &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OCRPageImageLoadedCopyWith<_$OCRPageImageLoaded> get copyWith =>
      __$$OCRPageImageLoadedCopyWithImpl<_$OCRPageImageLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String translation, File? image)
        translationLoaded,
    required TResult Function(String text, File? image) imageLoaded,
    required TResult Function(File? image) imageCropped,
    required TResult Function() error,
  }) {
    return imageLoaded(text, image);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String translation, File? image)? translationLoaded,
    TResult? Function(String text, File? image)? imageLoaded,
    TResult? Function(File? image)? imageCropped,
    TResult? Function()? error,
  }) {
    return imageLoaded?.call(text, image);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String translation, File? image)? translationLoaded,
    TResult Function(String text, File? image)? imageLoaded,
    TResult Function(File? image)? imageCropped,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (imageLoaded != null) {
      return imageLoaded(text, image);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OCRPageInitial value) initial,
    required TResult Function(OCRPageLoading value) loading,
    required TResult Function(OCRPageTranslationLoaded value) translationLoaded,
    required TResult Function(OCRPageImageLoaded value) imageLoaded,
    required TResult Function(OCRPageImageCropped value) imageCropped,
    required TResult Function(OCRPageError value) error,
  }) {
    return imageLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OCRPageInitial value)? initial,
    TResult? Function(OCRPageLoading value)? loading,
    TResult? Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult? Function(OCRPageImageLoaded value)? imageLoaded,
    TResult? Function(OCRPageImageCropped value)? imageCropped,
    TResult? Function(OCRPageError value)? error,
  }) {
    return imageLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OCRPageInitial value)? initial,
    TResult Function(OCRPageLoading value)? loading,
    TResult Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult Function(OCRPageImageLoaded value)? imageLoaded,
    TResult Function(OCRPageImageCropped value)? imageCropped,
    TResult Function(OCRPageError value)? error,
    required TResult orElse(),
  }) {
    if (imageLoaded != null) {
      return imageLoaded(this);
    }
    return orElse();
  }
}

abstract class OCRPageImageLoaded implements OCRPageState {
  const factory OCRPageImageLoaded(final String text, {final File? image}) =
      _$OCRPageImageLoaded;

  String get text;
  File? get image;
  @JsonKey(ignore: true)
  _$$OCRPageImageLoadedCopyWith<_$OCRPageImageLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OCRPageImageCroppedCopyWith<$Res> {
  factory _$$OCRPageImageCroppedCopyWith(_$OCRPageImageCropped value,
          $Res Function(_$OCRPageImageCropped) then) =
      __$$OCRPageImageCroppedCopyWithImpl<$Res>;
  @useResult
  $Res call({File? image});
}

/// @nodoc
class __$$OCRPageImageCroppedCopyWithImpl<$Res>
    extends _$OCRPageStateCopyWithImpl<$Res, _$OCRPageImageCropped>
    implements _$$OCRPageImageCroppedCopyWith<$Res> {
  __$$OCRPageImageCroppedCopyWithImpl(
      _$OCRPageImageCropped _value, $Res Function(_$OCRPageImageCropped) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
  }) {
    return _then(_$OCRPageImageCropped(
      freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$OCRPageImageCropped implements OCRPageImageCropped {
  const _$OCRPageImageCropped(this.image);

  @override
  final File? image;

  @override
  String toString() {
    return 'OCRPageState.imageCropped(image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OCRPageImageCropped &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OCRPageImageCroppedCopyWith<_$OCRPageImageCropped> get copyWith =>
      __$$OCRPageImageCroppedCopyWithImpl<_$OCRPageImageCropped>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String translation, File? image)
        translationLoaded,
    required TResult Function(String text, File? image) imageLoaded,
    required TResult Function(File? image) imageCropped,
    required TResult Function() error,
  }) {
    return imageCropped(image);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String translation, File? image)? translationLoaded,
    TResult? Function(String text, File? image)? imageLoaded,
    TResult? Function(File? image)? imageCropped,
    TResult? Function()? error,
  }) {
    return imageCropped?.call(image);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String translation, File? image)? translationLoaded,
    TResult Function(String text, File? image)? imageLoaded,
    TResult Function(File? image)? imageCropped,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (imageCropped != null) {
      return imageCropped(image);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OCRPageInitial value) initial,
    required TResult Function(OCRPageLoading value) loading,
    required TResult Function(OCRPageTranslationLoaded value) translationLoaded,
    required TResult Function(OCRPageImageLoaded value) imageLoaded,
    required TResult Function(OCRPageImageCropped value) imageCropped,
    required TResult Function(OCRPageError value) error,
  }) {
    return imageCropped(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OCRPageInitial value)? initial,
    TResult? Function(OCRPageLoading value)? loading,
    TResult? Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult? Function(OCRPageImageLoaded value)? imageLoaded,
    TResult? Function(OCRPageImageCropped value)? imageCropped,
    TResult? Function(OCRPageError value)? error,
  }) {
    return imageCropped?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OCRPageInitial value)? initial,
    TResult Function(OCRPageLoading value)? loading,
    TResult Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult Function(OCRPageImageLoaded value)? imageLoaded,
    TResult Function(OCRPageImageCropped value)? imageCropped,
    TResult Function(OCRPageError value)? error,
    required TResult orElse(),
  }) {
    if (imageCropped != null) {
      return imageCropped(this);
    }
    return orElse();
  }
}

abstract class OCRPageImageCropped implements OCRPageState {
  const factory OCRPageImageCropped(final File? image) = _$OCRPageImageCropped;

  File? get image;
  @JsonKey(ignore: true)
  _$$OCRPageImageCroppedCopyWith<_$OCRPageImageCropped> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OCRPageErrorCopyWith<$Res> {
  factory _$$OCRPageErrorCopyWith(
          _$OCRPageError value, $Res Function(_$OCRPageError) then) =
      __$$OCRPageErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OCRPageErrorCopyWithImpl<$Res>
    extends _$OCRPageStateCopyWithImpl<$Res, _$OCRPageError>
    implements _$$OCRPageErrorCopyWith<$Res> {
  __$$OCRPageErrorCopyWithImpl(
      _$OCRPageError _value, $Res Function(_$OCRPageError) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OCRPageError implements OCRPageError {
  const _$OCRPageError();

  @override
  String toString() {
    return 'OCRPageState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OCRPageError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String translation, File? image)
        translationLoaded,
    required TResult Function(String text, File? image) imageLoaded,
    required TResult Function(File? image) imageCropped,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String translation, File? image)? translationLoaded,
    TResult? Function(String text, File? image)? imageLoaded,
    TResult? Function(File? image)? imageCropped,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String translation, File? image)? translationLoaded,
    TResult Function(String text, File? image)? imageLoaded,
    TResult Function(File? image)? imageCropped,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OCRPageInitial value) initial,
    required TResult Function(OCRPageLoading value) loading,
    required TResult Function(OCRPageTranslationLoaded value) translationLoaded,
    required TResult Function(OCRPageImageLoaded value) imageLoaded,
    required TResult Function(OCRPageImageCropped value) imageCropped,
    required TResult Function(OCRPageError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OCRPageInitial value)? initial,
    TResult? Function(OCRPageLoading value)? loading,
    TResult? Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult? Function(OCRPageImageLoaded value)? imageLoaded,
    TResult? Function(OCRPageImageCropped value)? imageCropped,
    TResult? Function(OCRPageError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OCRPageInitial value)? initial,
    TResult Function(OCRPageLoading value)? loading,
    TResult Function(OCRPageTranslationLoaded value)? translationLoaded,
    TResult Function(OCRPageImageLoaded value)? imageLoaded,
    TResult Function(OCRPageImageCropped value)? imageCropped,
    TResult Function(OCRPageError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class OCRPageError implements OCRPageState {
  const factory OCRPageError() = _$OCRPageError;
}
