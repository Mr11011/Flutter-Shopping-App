import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shoppingapp/homepage/favourites/favorites_model.dart';
import 'package:shoppingapp/login/cubit/states.dart';
import 'package:shoppingapp/login/login_page.dart';
import 'package:shoppingapp/network/cache_helper.dart';
import 'package:shoppingapp/onBoardingScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// CONSTANTS:
void signOut(context) {
  CacheHelper.removeData(key: "token").then((value) {
    if (value) {
      navigateFinish(context, loginPage());
    }
  });
}

void navigateFinish2(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void navigateTo2(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

var myfontName = "PoetsenOne-Regular";
dynamic token = '';
var darkerOrange = HexColor("#de6600");
var brightOrange = HexColor("#fea02f");
var navyBlue = HexColor("#201658");
var saturatedBlue = HexColor("1D24CA");
var lightBlue = HexColor("525CEB");
var aqua = HexColor("ebd9c8");

Widget defaultTxtBtn({required Function function, required String text}) =>
    TextButton(
      onPressed: () {},
      child: Text(
        "Register Now!!",
        style: TextStyle(
            color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );

// function that return Toast Message based on its status
void showToast({required String textMessage, required toastState}) {
  Fluttertoast.showToast(
      msg: textMessage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: changeColor(toastState),
      textColor: Colors.white,
      fontSize: 16.0);
}

// states for toast message
enum toastStates { SUCCESS, ERROR, WARNING }

// based on the states the color will be choosed
Color changeColor(toastStates states) {
  Color color;
  switch (states) {
    case toastStates.SUCCESS:
      color = Colors.green;
    case toastStates.ERROR:
      color = Colors.red;
    case toastStates.WARNING:
      color = Colors.amber;
  }
  return color;
}

Widget smoothIndicator({PageController? controller, int? count}) =>
    SmoothPageIndicator(
        controller: controller!, // PageController
        count: count!,
        effect: JumpingDotEffect(), // your preferred effect
        onDotClicked: (index) {});
