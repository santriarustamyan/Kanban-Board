import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonValidationEvevt extends LoginEvent {
  final String nameforlogin;
  final String password;

  const LoginButtonValidationEvevt(
      {required this.nameforlogin, required this.password});

  @override
  List<Object> get props => [nameforlogin, password];
}

class UserLoginEvent extends LoginEvent {
  final String identificator;
  final String password;

  const UserLoginEvent({required this.identificator, required this.password});

  @override
  List<Object> get props => [identificator, password];
}
