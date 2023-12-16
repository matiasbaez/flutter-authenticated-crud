
import 'package:formz/formz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop/infraestructure/inputs/inputs.dart';

// State
class LoginFormState {

  final bool isLoading;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isLoading = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure()
  });

  copyWith({
    bool? isLoading,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    isLoading: isLoading ?? this.isLoading,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );
}

// Notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {

  LoginFormNotifier() : super(LoginFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([ newEmail, state.password ])
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([ newPassword, state.email ])
    );
  }

  onFormSubmit() {
    _touchEveryField();
    if (!state.isValid) return;
  }

  _touchEveryField() {

    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      email: email,
      password: password,
      isFormPosted: true,
      isValid: Formz.validate([ password, email ])
    );

  }

}

// Provider
final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier();
});
