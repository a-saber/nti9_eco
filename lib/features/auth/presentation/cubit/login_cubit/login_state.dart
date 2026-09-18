import 'package:nti9_eco/features/auth/data/models/login_response_model.dart';

abstract class LoginState {}

class LoginInitState extends LoginState{}
class LoginPassVisibilityChanged extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{
  final UserModel userModel;
  LoginSuccessState(this.userModel);
}
class LoginErrorState extends LoginState{
  final String errorMsg;
  LoginErrorState(this.errorMsg);
}