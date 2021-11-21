import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_boards/screens/cards_board/cards_board_creen.dart';
import 'package:kanban_boards/screens/login/login_event.dart';
import 'package:kanban_boards/wdgets/continue_button.dart';
import 'package:kanban_boards/wdgets/headline_Widget.dart';
import 'package:kanban_boards/wdgets/richText_Widget.dart';
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
                  body: Stack(children: [
            SingleChildScrollView(
              child: _renderMainOnScreen(state),
            ),
            HeadlineWidget(
              text: "Log_In",
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
          _renderTextForgotPass(),
        ],
      ),
    );
  }

  Widget _renderTxtFieldForScreenEmail(LoginState state) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: TxtFieldForScreen(
            label: "USERNAME_OR_EMAIL",
            // .localizations(context),
            obscure: false,
            validator: (_) {
              return state is InvalidLoginName
                  ? "Enter_a_email"
                  // .localizations(context)
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
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: TxtFieldForScreen(
            label: "PASSWORD",
            // .localizations(context),
            obscure: _isObscure,
            suffixIcon: _renderSeeIcon(),
            validator: (_) {
              return state is InvalidPassword
                  ? "password_must_be_8+_characters"
                  // .localizations(context)
                  : null;
            },
            onChange: (val) => _onChange(val, false)));
  }

  Widget _renderTextForgotPass() {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: RichTextWidget(
          text: "Forgot_your_password?",
          color: Colors.blue,
        ));
  }

  Widget _renderButtonLogin(LoginState state) {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsetsDirectional.only(bottom: 10),
        child: ContinueButton(
          color: state is LoginPasswordValidated ? Colors.blue : Colors.grey,
          text: "Log_In",
          // .localizations(context),
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
      // _loginError = state.errorMessage.split(":")[0];
      showAlertDialog(context,
          title: "Login Failed ...",
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
