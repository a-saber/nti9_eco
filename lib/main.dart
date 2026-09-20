import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti9_eco/features/auth/presentation/views/login_view.dart';
import 'package:nti9_eco/features/cart/presentation/cubit/cart/cart_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, c) => BlocProvider(
        create: (context) => CartCubit(),
        child: MaterialApp(
          theme: ThemeData(appBarTheme: AppBarTheme(centerTitle: true)),
          home: LoginView(),
        ),
      ),
    );
  }
}
