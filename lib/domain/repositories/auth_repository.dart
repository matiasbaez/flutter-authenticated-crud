

import 'package:shop/domain/domain.dart';

abstract class AuthRepository {

  Future<User> login( String email, String password );
  Future<User> register( String fullname, String email, String password );
  Future<User> checkAuthStatus( String token );

}
