import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti9_eco/core/components/custom_btn.dart';
import 'package:nti9_eco/core/components/custom_text_field.dart';
import 'package:nti9_eco/core/utils/app_paddings.dart';
import 'package:nti9_eco/features/auth/presentation/cubit/login_cubit/login_state.dart';

import '../../../../core/helper/my_navigator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/presentation/views/home_view.dart';
import '../cubit/login_cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMsg,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is LoginSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Welcome ${state.userModel.name}',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: AppColors.primary,
                ),
              );
              MyNavigator.goTo(
                context,
                toPage: HomeView(),
                type: NavigatorType.pushAndRemoveUntil,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: AppPaddings.defaultPadding,
                child: Column(
                  children: [
                    Text('Welcome\nBack!'),
                    SizedBox(height: 40),
                    CustomTextField(
                      hint: 'Email',
                      prefixIcon: Icon(Icons.email),
                      controller: context.read<LoginCubit>().email,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hint: 'Password',
                      prefixIcon: Icon(Icons.password),
                      controller: context.read<LoginCubit>().password,
                      suffixIcon: Icon(Icons.remove_red_eye),
                      obscureText: context.read<LoginCubit>().isPasswordSecure,
                      onSuffixPressed: context
                          .read<LoginCubit>()
                          .changePassSecure,
                    ),
                    SizedBox(height: 40),
                    if (state is LoginLoadingState)
                      CircularProgressIndicator()
                    else
                      CustomBtn(
                        text: 'Login',
                        onPressed: context.read<LoginCubit>().login,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
