import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/bloc/login/form_submission_status.dart';
import 'package:login_app/bloc/login/login_event.dart';
import 'package:login_app/bloc/login/login_state.dart';
import 'package:login_app/repository/repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepo;

  LoginBloc({this.userRepo}) : super(LoginState());
  @override
  Stream<LoginState> mapEventToState(event) async* {
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      // yield state.copyWith(formStatus: FormSubmitting());

      try {
        bool loginIsAccepted =
            await userRepo.login(state.username, state.password, state);

        print('loginIsAccepted in bloc ${loginIsAccepted.toString()}');
        if (loginIsAccepted) {
          yield state.copyWith(formStatus: SubmitionSuccess());
        }
      } catch (e) {
        yield state.copyWith(formStatus: SubmitionFailed(exception: e));
      }
    }
  }
}
