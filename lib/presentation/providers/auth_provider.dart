
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop/domain/domain.dart';
import 'package:shop/infraestructure/infraestructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  final sharedPreferences = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: sharedPreferences
  );

});

class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepositoryImpl authRepository;
  final KeyValueStorageServiceImpl keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  _setLoggedUser( User user ) async {

    await keyValueStorageService.setKeyValue('token', user.token);
  
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> login( String email, String password ) async {
    try {

      final user = await authRepository.login(email, password);
      _setLoggedUser(user);

    } on WrongCredentials {
      logout('Invalid credentials');
    } on ConnectionTimeout {
      logout('Timeout');
    } catch(err) {
      logout();
    }
  }

  Future<void> register( String fullname, String email, String password ) async {
    authRepository.register(fullname, email, password);
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (err) {
      logout();
    }
  }

  Future<void> logout( [String? errorMessage = ''] ) async {

    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      user: null,
      authStatus: AuthStatus.notAuthenticated,
      errorMessage: errorMessage
    );
  }

}


enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {

  final AuthStatus authStatus;
  final User? user;
  final String? errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = ''
  });

  copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );

}