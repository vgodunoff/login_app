// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:login_app/repository/repository.dart';
//
// part 'auth_event.dart';
// part 'auth_state.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final UserRepository userRepository;
//   AuthBloc({@required this.userRepository}) : super(AuthInitial());
//
//   @override
//   Stream<AuthState> mapEventToState(
//     AuthEvent event,
//   ) async* {
//     if (event is AppStarted) {
//       final bool hasToken = await userRepository.hasToken();
//       if (hasToken) {
//         yield AuthAuthenticated();
//       } else {
//         yield AuthUnauthenticated();
//       }
//     }
//     if (event is LoggedIn) {
//       yield AuthLoading();
//       await userRepository.persistToken(event.token);
//       yield AuthAuthenticated();
//     }
//     if (event is LoggedOut) {
//       yield AuthLoading();
//       await userRepository.deleteToken();
//       yield AuthUnauthenticated();
//     }
//   }
// }
