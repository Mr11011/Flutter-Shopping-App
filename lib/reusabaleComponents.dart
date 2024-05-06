import 'package:flutter/material.dart';

void navigateFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

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
