
import 'package:formz/formz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shop/infraestructure/inputs/inputs.dart';

// State
class RegisterFormState {

  final bool isLoading;
  final bool isFormPosted;
  final bool isValid;
  final Text fullname;
  final Email email;
  final Password password;
  final Password repeatPassword;

  RegisterFormState({
    this.isLoading = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.fullname = const Text.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.repeatPassword = const Password.pure()
  });

  copyWith({
    bool? isLoading,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Text? fullname,
    Password? password,
    Password? repeatPassword,
  }) => RegisterFormState(
    isLoading: isLoading ?? this.isLoading,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    fullname: fullname ?? this.fullname,
    email: email ?? this.email,
    password: password ?? this.password,
    repeatPassword: repeatPassword ?? this.repeatPassword,
  );
}

// Notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {

  RegisterFormNotifier() : super(RegisterFormState());

  onFullnameChange(String value) {
    final newFullname = Text.dirty(value);
    state = state.copyWith(
      fullname: newFullname,
      isValid: Formz.validate([ newFullname, state.email, state.password, state.repeatPassword ])
    );
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([ newEmail, state.fullname, state.password, state.repeatPassword ])
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([ state.fullname, state.email, newPassword, state.repeatPassword ])
    );
  }

  onRepeatPasswordChange(String value) {
    final newRepeatPassword = Password.dirty(value);
    state = state.copyWith(
      repeatPassword: newRepeatPassword,
      isValid: Formz.validate([ state.fullname, state.email, state.password, newRepeatPassword ])
    );
  }

  onFormSubmit() {
    _touchEveryField();
    if (!state.isValid) return;
  }

  _touchEveryField() {

    final email = Email.dirty(state.email.value);
    final fullname = Text.dirty(state.fullname.value);
    final password = Password.dirty(state.password.value);
    final repeatPassword = Password.dirty(state.repeatPassword.value);

    state = state.copyWith(
      email: email,
      isFormPosted: true,
      fullname: fullname,
      password: password,
      repeatPassword: repeatPassword,
      isValid: Formz.validate([ fullname, password, email, repeatPassword ])
    );

  }

}

// Provider
final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {
  return RegisterFormNotifier();
});
