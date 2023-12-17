
import 'package:shop/domain/domain.dart';

class UserMapper {

  static User userJsonToEntity( Map<String, dynamic> json ) => User(
    id: json['id'],
    fullname: json['fullName'] ?? '',
    email: json['email'] ?? '',
    token: json['token'] ?? '',
    roles: List<String>.from(json['roles'].map((role) => role))
  );

}
