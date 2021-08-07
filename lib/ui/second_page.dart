import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/bloc/secondScreen/second_screen_bloc.dart';
import 'package:login_app/bloc/secondScreen/second_screen_state.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecondScreenBloc, SecondScreenState>(
      listener: (context, state) {
        if (state is Loading) {
          if (state.isLoading) {
            showDialog(
                context: context,
                builder: (context) {
                  return Center(child: CircularProgressIndicator());
                });
          } else {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        if (state is Loaded) {
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.grey[850],
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: 'On hold',
                    ),
                    Tab(
                      text: '2tab',
                    ),
                    Tab(
                      text: '3',
                    ),
                    Tab(
                      text: '4',
                    )
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        state.cards[index].text.toString(),
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  Text('content of 2nd tab',
                      style: TextStyle(color: Colors.white)),
                  Text('content of 3d tab',
                      style: TextStyle(color: Colors.white)),
                  Text('content of 4th tab',
                      style: TextStyle(color: Colors.white))
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
