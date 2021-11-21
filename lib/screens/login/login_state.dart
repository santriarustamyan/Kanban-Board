import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class InvalidLoginName extends LoginState {
  @override
  List<Object> get props => [];
}

class InvalidPassword extends LoginState {
  List<Object> get props => [];
}

class LoginPasswordValidated extends LoginState {
  final String loginname;
  final String password;

  LoginPasswordValidated(this.loginname, this.password);
  @override
  List<Object> get props => [loginname, password];
}

class UserSuccessState extends LoginState {
  final String _id = Uuid().v4();
  @override
  List<Object> get props => [_id];
}

class UserFalseState extends LoginState {
  UserFalseState({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
