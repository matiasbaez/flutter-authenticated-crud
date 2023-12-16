
class User {

  final String id;
  final String fullname;
  final String email;
  final List<String> roles;
  final String token;

  User({
    required this.id,
    required this.fullname,
    required this.email,
    required this.token,
    required this.roles
  });

  bool get isAdmin {
    return roles.contains('admin');
  }

}
