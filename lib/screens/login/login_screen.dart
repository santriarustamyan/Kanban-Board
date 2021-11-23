import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_boards/wdgets/cards_board_widget.dart';
import 'package:kanban_boards/screens/login/login_event.dart';
import 'package:kanban_boards/wdgets/login_button.dart';
import 'package:kanban_boards/wdgets/showAlert.dart';
import 'package:kanban_boards/wdgets/txt_field.dart';
import 'login_bloc.dart';
import 'login_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  bool _isObscure = true;
  String _loginError = "";
  late LoginBloc _loginBloc;
  double get _deviceSizeWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) {
          return _loginBloc;
        },
        child: BlocListener<LoginBloc, LoginState>(
          listener: _blocListner,
          child: _render(),
        ));
  }

  Widget _render() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.grey,
                    title: const Text('Kanban'),
                  ),
                  body: Stack(children: [
                    SingleChildScrollView(
                      child: _renderMainOnScreen(state),
                    ),
                    _renderButtonLogin(state),
                  ]))));
    });
  }

  Widget _renderMainOnScreen(LoginState state) {
    return Container(
      padding: const EdgeInsets.only(
        top: 60,
        bottom: 40,
      ),
      child: Column(
        children: [
          _renderTxtFieldForScreenEmail(state),
          _renderTxtFieldForScreenPass(state),
        ],
      ),
    );
  }

  Widget _renderTxtFieldForScreenEmail(LoginState state) {
    return Container(
        margin: EdgeInsets.only(left: _deviceSizeWidth / 10, bottom: 10),
        width: _deviceSizeWidth * 4 / 5,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color:
                  state is InvalidLoginName ? Colors.red : Colors.greenAccent,
            )),
        padding: EdgeInsets.only(top: 10),
        child: TxtFieldForScreen(
            label: "Enter your username",
            obscure: false,
            validator: (_) {
              return state is InvalidLoginName
                  ? "Minimum is 4 characters"
                  : null;
            },
            onChange: (val) {
              _onChange(val, true);
            }));
  }

  Widget _renderSeeIcon() {
    return IconButton(
        icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
        onPressed: () => _changeState());
  }

  Widget _renderTxtFieldForScreenPass(LoginState state) {
    return Container(
        margin: EdgeInsets.only(left: _deviceSizeWidth / 10),
        width: _deviceSizeWidth * 4 / 5,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: state is InvalidPassword ? Colors.red : Colors.greenAccent,
            )),
        padding: EdgeInsets.only(top: 10),
        child: TxtFieldForScreen(
            label: "Enter your password",
            obscure: _isObscure,
            suffixIcon: _renderSeeIcon(),
            validator: (_) {
              return state is InvalidPassword
                  ? "Minimum is 8 characters"
                  : null;
            },
            onChange: (val) => _onChange(val, false)));
  }

  Widget _renderButtonLogin(LoginState state) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsetsDirectional.only(bottom: 10),
        child: LoginButton(
          width: _deviceSizeWidth * 4 / 5,
          color: Colors.greenAccent,
          text: "Log In",
          onPress: () {
            if (state is LoginPasswordValidated) {
              _loginAction();
            }
          },
        ));
  }

  void _blocListner(context, state) {
    if (state is UserSuccessState) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CardsBoardScreen()));
    }
    if (state is UserFalseState) {
      _loginError = state.errorMessage;
      showAlertDialog(context,
          title: "Login Failed ",
          content: _loginError,
          onPressButton: onAlertButtonPress);
    }
  }

  void _onChange(String val, bool isEmail) {
    if (isEmail) {
      email = val;
    } else {
      password = val;
    }
    _loginEvent();
  }

  void _loginEvent() {
    _loginBloc.add(
        LoginButtonValidationEvevt(password: password, nameforlogin: email));
  }

  void _changeState() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _loginAction() {
    _loginBloc.add(UserLoginEvent(identificator: email, password: password));
  }

  void onAlertButtonPress() => Navigator.pop(context);
}
