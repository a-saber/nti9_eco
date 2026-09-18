import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

}