import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/homepage/home_cubit.dart';
import 'package:shoppingapp/homepage/home_page.dart';
import 'package:shoppingapp/homepage/states.dart';
import 'package:shoppingapp/login/cubit/login_cubit.dart';
import 'package:shoppingapp/login/login_page.dart';
import 'package:shoppingapp/network/Diohelper.dart';
import 'package:shoppingapp/onBoardingScreen.dart';
import 'package:shoppingapp/reusabaleComponents.dart';
import 'package:shoppingapp/theme/theme.dart';

import 'login/cubit/blocObserver.dart';
import 'network/cache_helper.dart';

void main() async {
  // check every instances created from the methods then run the app
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  dioHelper.init();
  await CacheHelper.init();

  // to save and then check the cacheHelper value and type, to know if it is work or not
  bool onBoarding = CacheHelper.getData(key: "onBoarding");
  // dynamic token = CacheHelper.getData(key: "token");
  // print(token);
  token = CacheHelper.getData(key: "token");
  print(token);

  Widget? widget;
  if (onBoarding != null) {
    if (token != false)
      widget = homePageScreen();
    else {
      widget = loginPage();
    }
  } else {
    widget = onBoardingScreen();
  }


  runApp(MyApp(
    startingWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // final bool isDark;
  final Widget? startingWidget; // constructor & build

  MyApp(
      {this.startingWidget}); // if i want to send more than one parameter "MyApp({this.onBoarding,this.isDark})"
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => homeCubit()..fetchProducts()..fetchCategory()..fetch_Fav()..getUserData(),
        child: BlocConsumer<homeCubit, homePageStates>(
          builder: (BuildContext context, homePageStates state) {
            return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                home: startingWidget);

            // onBoard == true ? loginPage() : onBoardingScreen()
          },
          listener: (BuildContext context, homePageStates state) {},
        ));
  }
}
