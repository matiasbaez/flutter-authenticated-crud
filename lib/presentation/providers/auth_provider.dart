
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop/domain/domain.dart';
import 'package:shop/infraestructure/infraestructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepositoryImpl authRepository;

  AuthNotifier({
    required this.authRepository
  }): super(AuthState());

  _setLoggedUser( User user ) {
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

  void checkAuthStatus( String token ) async {}

  Future<void> logout( [String? errorMessage = ''] ) async {
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