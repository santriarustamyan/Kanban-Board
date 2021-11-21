import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_boards/class/user_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  UserRepository get userRepository => _userRepository;
  UserRepository _userRepository = UserRepository();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonValidationEvevt) {
      yield* mapEventValidateToState(event);
    }

    if (event is UserLoginEvent) {
      yield* mapEventIdentificationToState(event);
    }
  }

  Stream<LoginState> mapEventValidateToState(
      LoginButtonValidationEvevt? event) async* {
    String? loginname = event?.nameforlogin;
    String? password = event?.password;

    if (loginname == null || loginname.length < 1) {
      yield InvalidPassword();
    } else if (password == null || password.length < 8) {
      yield InvalidLoginName();
    } else {
      yield LoginPasswordValidated(loginname, password);
    }
  }

  Stream<LoginState> mapEventIdentificationToState(
      UserLoginEvent event) async* {
    try {
      await userRepository.login(event.identificator, event.password);

      yield UserSuccessState();
    } catch (e) {
      yield UserFalseState(errorMessage: e.toString());
    }

    yield LoginInitial();
  }
}
