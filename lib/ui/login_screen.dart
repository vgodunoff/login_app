import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/bloc/login/form_submission_status.dart';
import 'package:login_app/bloc/login/login_bloc.dart';
import 'package:login_app/bloc/login/login_event.dart';
import 'package:login_app/bloc/secondScreen/second_screen_bloc.dart';
import 'package:login_app/bloc/secondScreen/second_screen_event.dart';
import 'package:login_app/repository/repository.dart';
import 'package:login_app/bloc/login/login_state.dart';
import 'package:login_app/ui/second_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  static final keyUsername = const Key('KEY1_username');
  static final keyPassword = const Key('KEY2_password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Kanban'),
        centerTitle: false,
      ),
      body: BlocProvider(
        create: (context) =>
            LoginBloc(userRepo: context.read<UserRepository>()),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.formStatus is SubmitionSuccess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => SecondScreenBloc()
                              ..add(FetchData(
                                  username: state.username,
                                  password: state.password)),
                            child: SecondPage(),
                          )));
            }
          },
          child: ListView(children: [
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _UsernameInput(
                    usernameKey: keyUsername,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  _PasswordInput(
                    passKey: keyPassword,
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  SubmimButton()
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final passKey;

  const _PasswordInput({Key key, this.passKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          key: passKey,
          obscureText: true,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.tealAccent, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey[700], width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              hintText: 'Enter your password',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              errorText: state.isValidPassword || state.password.length == 0
                  ? null
                  : 'Minimum is 8 characters'),
          onChanged: (password) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: password)),
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  final usernameKey;

  const _UsernameInput({Key key, this.usernameKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          key: usernameKey,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          enabled: true,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey[700], width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
            hintText: 'Enter your username',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            errorText: state.isValidUsername || state.username.length == 0
                ? null
                : 'Minimum is 4 characters',
          ),
          onChanged: (userName) => context
              .read<LoginBloc>()
              .add(LoginUsernameChanged(username: userName)),
        );
      },
    );
  }
}

class SubmimButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 15.0),
              primary: Colors.cyanAccent,
              onPrimary: Colors.black),
          onPressed: () {
            context.read<LoginBloc>().add(LoginSubmitted());
          },
          child: Text('Log in'),
        );
      },
    );
  }
}
