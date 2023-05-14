import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kanpractice/domain/user/user.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final bool isPro;

  const UserDto({required this.isPro});

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  User toDomain() => User(isPro: isPro);
  factory UserDto.fromDomain(User user) => UserDto(isPro: user.isPro);
}
