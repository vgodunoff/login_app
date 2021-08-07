import 'form_submission_status.dart';

class LoginState {
  final FormSubmissionStatus formStatus;
  final String username;
  bool get isValidUsername => username.length >= 4;

  final String password;
  bool get isValidPassword => password.length >= 8;

  const LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String username,
    String password,
    FormSubmissionStatus formStatus,
  }) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
