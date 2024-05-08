import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// void navigateFinish(context, widget) => Navigator.pushAndRemoveUntil(
//     context, MaterialPageRoute(builder: (context) => widget), (route) => false);
//
// void navigateTo(context, widget) =>
//     Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

var myfontName = "PoetsenOne-Regular";

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
