import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/network/Diohelper.dart';
import 'package:shoppingapp/onBoardingScreen.dart';
import 'package:shoppingapp/theme/theme.dart';

import 'login/cubit/blocObserver.dart';

void main()async {
  Bloc.observer = MyBlocObserver();
  dioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: onBoardingScreen(),
    );
  }
}
