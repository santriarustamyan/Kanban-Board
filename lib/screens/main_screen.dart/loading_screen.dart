import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_boards/screens/cards_board/cards_board_creen.dart';
import 'package:kanban_boards/screens/login/login_screen.dart';
import 'package:kanban_boards/screens/main_screen.dart/loading_event.dart';
import 'loading_bloc.dart';
import 'loading_state.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LoadingBloc _loadingBloc;

  @override
  void initState() {
    super.initState();
    _loadingBloc = LoadingBloc();
    _checkIsLogined();
  }

  @override
  void dispose() {
    super.dispose();
    _loadingBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoadingBloc>(
        create: (context) {
          return _loadingBloc;
        },
        child: BlocListener<LoadingBloc, LoadingState>(
            listener: (context, state) {
              if (state is UserLoded) {
                _openInformationScreen();
              }

              if (state is UserNotLoaded) {
                _openAuthencicationScreen();
              }
            },
            child: _render()));
  }

  Widget _render() {
    return BlocBuilder<LoadingBloc, LoadingState>(builder: (context, state) {
      return const Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,
          body: Center(
            child: CircularProgressIndicator(),
          ));
    });
  }

  Future<void> _openAuthencicationScreen() {
    return Navigator.push(context, MaterialPageRoute(builder: (_) {
      return LoginScreen();
    }));
  }

  Future<void> _checkIsLogined() async {
    _loadingBloc.add(UserLoadedEvent());
  }

  Future<void> _openInformationScreen() {
    return Navigator.push(context, MaterialPageRoute(builder: (_) {
      return CardsBoardScreen();
    }));
  }
}
