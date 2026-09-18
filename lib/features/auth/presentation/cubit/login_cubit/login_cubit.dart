import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti9_eco/features/auth/data/repo/auth_repo.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(LoginInitState());

  var email = TextEditingController();
  var password = TextEditingController();
  bool isPasswordSecure = true;
  void changePassSecure(){
      isPasswordSecure = !isPasswordSecure;
      emit(LoginPassVisibilityChanged());
  }

  login()async{
    AuthRepo repo = AuthRepo();
    emit(LoginLoadingState());
    var result = await repo.login(
      email: email.text,
      password: password.text,
    );
    result.fold(
        (errorMsg)=> emit(LoginErrorState(errorMsg)),
        (userModel)=> emit(LoginSuccessState(userModel))
    );
  }
}