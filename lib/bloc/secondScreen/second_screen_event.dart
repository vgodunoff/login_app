import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_app/repository/repository.dart';

abstract class SecondScreenEvent extends Equatable {
  const SecondScreenEvent();
}

class FetchData extends SecondScreenEvent {
  final String username;
  final String password;

  FetchData({@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];
}
