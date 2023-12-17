
import 'package:dio/dio.dart';

import 'package:shop/config/config.dart';
import 'package:shop/domain/domain.dart';
import 'package:shop/infraestructure/infraestructure.dart';

class AuthDataSourceImpl extends AuthDataSource {

  final _dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl
    )
  );

  @override
  Future<User> checkAuthStatus(String token) async {
    try {

      final response = await _dio.get(
        '/auth/check-status',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        )
      );

      return UserMapper.userJsonToEntity(response.data);

    } on DioException catch(err) {

      if (err.response?.statusCode == 401) throw WrongCredentials();
      if (err.type == DioExceptionType.connectionTimeout) throw ConnectionTimeout();

      throw CustomError(message: 'Something wrong happend', errorCode: err.response?.statusCode ?? 500);

    } catch(err) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {

      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });

      return UserMapper.userJsonToEntity(response.data);

    } on DioException catch(err) {

      if (err.response?.statusCode == 401) throw WrongCredentials();
      if (err.type == DioExceptionType.connectionTimeout) throw ConnectionTimeout();

      throw CustomError(message: 'Something wrong happend', errorCode: err.response?.statusCode ?? 500);

    } catch(err) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String fullname, String email, String password) async {
    try {

      final response = await _dio.post('/auth/register', data: {
        'fullname': fullname,
        'email': email,
        'password': password
      });

      return UserMapper.userJsonToEntity(response.data);

    } catch(err) {
      throw WrongCredentials();
    }
  }

}