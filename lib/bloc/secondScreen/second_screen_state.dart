import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:login_app/model/card_model.dart';

abstract class SecondScreenState extends Equatable {
  const SecondScreenState();
}

class Loading extends SecondScreenState {
  final bool isLoading;

  Loading({@required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

class Loaded extends SecondScreenState {
  final List<Cards> cards;

  Loaded({@required this.cards});
  @override
  List<Object> get props => [cards];
}

class Error extends SecondScreenState {
  @override
  List<Object> get props => [];
}
