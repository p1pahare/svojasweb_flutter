import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/login/login_cubit.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:svojasweb/utilities/textfield_custm.dart';
import 'package:svojasweb/utilities/validations.dart';
import 'package:svojasweb/views/dashboard_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  static const routeName = '/LoginView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'lib/assets/login_background.jpg',
                ),
                fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: BlocBuilder<LoginCubit, LoginState>(
              bloc: GetIt.I<LoginCubit>(),
              builder: (context, state) {
                if (state is LoginSuccess) {
                  Future.delayed(
                      const Duration(seconds: 1),
                      () => Navigator.pushReplacementNamed(
                          context, DashboardView.routeName));
                }
                return SizedBox(
                  width: min(MediaQuery.of(context).size.width, 480),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state is LoginFailed)
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  state.errorMessage ?? 'Something went wrong'),
                            ),
                          ),
                        ),
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage('lib/assets/profile_placeholder.png'),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (state is LoginLoading)
                        const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      if (state is LoginInitial || state is LoginFailed)
                        TextFieldCustm(
                            controller: state.controllers['username']!,
                            focusNode: state.focusNodes['username']!,
                            validate: isAtleast8Chars,
                            onDone: (str) => FocusScope.of(context)
                                .requestFocus(state.focusNodes['password']),
                            label: 'Username'),
                      const SizedBox(
                        height: 30,
                      ),
                      if (state is LoginInitial || state is LoginFailed)
                        TextFieldCustm(
                            focusNode: state.focusNodes['password']!,
                            controller: state.controllers['password']!,
                            obscure: true,
                            validate: isAtleast8Chars,
                            label: 'Password'),
                      const SizedBox(
                        height: 30,
                      ),
                      if (state is LoginInitial || state is LoginFailed)
                        ButtonCustm(
                          label: 'Login',
                          function1: () async {
                            GetIt.I<LoginCubit>().login();
                          },
                        )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
