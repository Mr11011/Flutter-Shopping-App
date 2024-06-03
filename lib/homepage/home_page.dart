import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/homepage/home_cubit.dart';
import 'package:shoppingapp/homepage/search/search_screen.dart';
import 'package:shoppingapp/homepage/states.dart';
import 'package:shoppingapp/login/cubit/login_cubit.dart';
import 'package:shoppingapp/login/login_page.dart';
import 'package:shoppingapp/network/cache_helper.dart';
import 'package:shoppingapp/reusabaleComponents.dart';

import '../onBoardingScreen.dart';

class homePageScreen extends StatelessWidget {
  // const homePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit, homePageStates>(
      builder: (context, state) {
        var cubit = homeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Oootlob",
              style: TextStyle(
                  fontFamily: myfontName,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: brightOrange),
            ),
            backgroundColor: navyBlue,
            actions: [
              IconButton(
                  onPressed: () {
                    // in this IconButton we need to signOut using cacheHelper and save the sharedPreferences
                    CacheHelper.removeData(key: "token").then((value) {
                      print(value);
                      if (value) {
                        navigateFinish(context, loginPage());
                      }
                    });
                  },
                  icon: Icon(Icons.output_outlined),color: Colors.white,),
              IconButton(
                icon: Icon(Icons.search_sharp),color: Colors.white,
                onPressed: () {
                  navigateTo(context, searchScreen());
                },
              ),

            ],
          ),
          body: cubit.homeScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: "Category"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favourites"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
        );
      },
      listener: (BuildContext context, homePageStates state) {},
    );
  }
}
