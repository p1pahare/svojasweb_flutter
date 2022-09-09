import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/repositories/basic_repository.dart';
import 'package:svojasweb/services/preferences.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  login() async {
    String? username = state.controllers['username']?.text;
    String? password = state.controllers['password']?.text;
    if (username!.isEmpty && password!.isEmpty) {
      emit(LoginFailed(errorMessage: "Please enter login credentials first"));
      return;
    }
    emit(LoginLoading());
    final ApiResponse apiResponse =
        await GetIt.I<BasicRepository>().login(username, password);
    if (apiResponse.status) {
      GetIt.I<Preferences>().saveIslogin(isLogin: true);
      emit(LoginSuccess());
    } else {
      emit(LoginFailed(errorMessage: apiResponse.message));
    }
  }
}
