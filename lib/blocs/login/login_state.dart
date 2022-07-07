part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  final Map<String, TextEditingController> controllers = {
    'username': TextEditingController(),
    'password': TextEditingController(),
  };
  final Map<String, FocusNode> focusNodes = {
    'username': FocusNode(),
    'password': FocusNode(),
  };
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailed extends LoginState {
  LoginFailed({this.errorMessage});
  final String? errorMessage;
}

class LoginSuccess extends LoginState {
  LoginSuccess();
}
