
import 'package:shop/domain/domain.dart';
import 'package:shop/infraestructure/infraestructure.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSource dataSource;

  AuthRepositoryImpl({
    AuthDataSource? dataSource
  }) : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus( String token ) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login( String email, String password ) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register( String fullname, String email, String password ) {
    return dataSource.register(fullname, email, password);
  }

}
