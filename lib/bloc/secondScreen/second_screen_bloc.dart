import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:login_app/bloc/secondScreen/second_screen_event.dart';
import 'package:login_app/bloc/secondScreen/second_screen_state.dart';
import 'package:login_app/model/card_model.dart';
import 'package:login_app/repository/repository.dart';

class SecondScreenBloc extends Bloc<SecondScreenEvent, SecondScreenState> {
  UserRepository repository;
  SecondScreenBloc() : super(Loading());
  List<Cards> fetchedCards = [];
  @override
  Stream<SecondScreenState> mapEventToState(
    SecondScreenEvent event,
  ) async* {
    if (event is FetchData) {
      yield Loading(isLoading: true);
      print(fetchedCards);
      try {
        fetchedCards =
            await repository.getCards(event.username, event.password);
        print(fetchedCards);
        yield Loaded(cards: fetchedCards);
      } catch (e) {
        print('errorData: $e');
        yield Error();
      } finally {
        yield Loading(isLoading: false);
      }
    }
  }
}
