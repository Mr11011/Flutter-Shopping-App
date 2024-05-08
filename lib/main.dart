import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/homepage/home_page.dart';
import 'package:shoppingapp/login/login_page.dart';
import 'package:shoppingapp/network/Diohelper.dart';
import 'package:shoppingapp/onBoardingScreen.dart';
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

  print(onBoarding.toString());

  // send the onBoarding with runApp to make the app open on the sharedPreference
  // runApp(MyApp(
  //   onBoard: onBoarding,
  // ));

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  // final bool isDark;
  // final Widget  ? startingWidget; // constructor & build
  // final bool? onBoard; // constructor & build
  //
  // MyApp(
  //     {this.onBoard}); // if i want to send more than one parameter "MyApp({this.onBoarding,this.isDark})"
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: onBoardingScreen());
    // onBoard == true ? loginPage() : onBoardingScreen()

  }
}
