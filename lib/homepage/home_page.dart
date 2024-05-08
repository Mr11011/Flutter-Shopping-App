import 'package:flutter/material.dart';
import 'package:shoppingapp/login/cubit/bloc.dart';
import 'package:shoppingapp/login/login_page.dart';
import 'package:shoppingapp/network/cache_helper.dart';

class homePageScreen extends StatelessWidget {
  // const homePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () {
                // in this IconButton we need to signOut using cacheHelper and save the sharedPreferences
                // CacheHelper.removeData(key: "token").then((value) {
                //   if (value) {
                //     loginCubit
                //         .get(context)
                //         .navigateFinish(context, loginPage());
                //   }
                // });
              },
              icon: Icon(Icons.output_outlined))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.greenAccent,
            width: double.infinity,
            height: 500,
          )
        ],
      ),
    );
  }
}
