import 'package:flutter/material.dart';
import 'package:nti9_eco/core/components/custom_text_field.dart';
import 'package:nti9_eco/core/utils/app_paddings.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.defaultPadding,
          child: Column(
            children: [
              Text('Welcome\nBack!'),
              SizedBox(height: 40,),
              // CustomTextField(
              //   hint: 'Email',
              //     prefixIconPath: '',
              //     controller: email
              // ),
              // SizedBox(height: 20,),
              // CustomTextField(
              //     hint: 'Password',
              //     prefixIconPath: '',
              //     controller: password,
              //   suffixIconPath: '',
              //   obscureText: isPasswordSecure,
              //   onSuffixPressed: (){
              //
              //   },
              // ),
            ],

          ),
        ),
      ),
    );
  }
}
