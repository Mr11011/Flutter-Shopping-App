import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/homepage/home_page.dart';
import 'package:shoppingapp/login/cubit/bloc.dart';
import 'package:shoppingapp/login/cubit/states.dart';
import 'package:shoppingapp/login/login_model.dart';
import 'package:shoppingapp/network/cache_helper.dart';
import 'package:shoppingapp/register/register_screen.dart';
import 'package:shoppingapp/reusabaleComponents.dart';

class loginPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => loginCubit(),
      child: BlocConsumer<loginCubit, loginStates>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Login Page",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
              body: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "LOGIN",
                            style: TextStyle(
                                fontFamily: "PoetsenOne-Regular",
                                fontWeight: FontWeight.bold,
                                fontSize: 45,
                                color: Colors.deepPurple),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Let's Start To Browse Our Great Offers 💸 ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: emailController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Cannot Be Empty";
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60)),
                                prefixIcon: Icon(Icons.email_outlined),
                                hintText:
                                    "Please Enter Your Email Address Here",
                                hoverColor: Colors.lightBlue,
                                labelText: "Email"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            obscureText: loginCubit.get(context).visibleFlag,
                            controller: passwordController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Cannot Be Empty";
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60)),
                                prefixIcon: Icon(Icons.lock),
                                hintText: "Please Enter Your Password Here",
                                labelText: "Password",
                                hoverColor: Colors.lightBlue,
                                suffixIcon: IconButton(
                                  icon:
                                      Icon(loginCubit.get(context).suffixIcon),
                                  // Correct usage of the icon parameter
                                  onPressed: () {
                                    loginCubit.get(context).changeVisibility();
                                  },
                                )),
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                loginCubit.get(context)!.userLogin(
                                    email: "${emailController.text}",
                                    password: "${passwordController.text}");
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: 20),
                          ConditionalBuilder(
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                            condition: loginStates is! loginStatesLoading,
                            builder: (context) => Center(
                                child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  loginCubit.get(context)!.userLogin(
                                      email: "${emailController.text}",
                                      password: "${passwordController.text}");

                                  // check state then navigate to HomePage
                                  // if (state is loginStatesSuccess) {
                                  //   if (state.loginModel?.status == true) {
                                  //     loginCubit.get(context).navigateTo(context, homePageScreen());
                                  //   }
                                  //
                                  // }
                                }
                              },
                              child: Text(
                                "Login 👇",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlueAccent,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(220, 50) // Background color
                                  ),
                            )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text("Don't have an account yet?",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16)),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                loginCubit
                                    .get(context)
                                    .navigateTo(context, registerScreen());
                              },
                              child: Text(
                                "Register Now!!",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
        listener: (context, state) {
          // to handle the status of the login true or false?
          if (state is loginStatesSuccess) {
            if (state.loginModel?.status == true) {
              Fluttertoast.showToast(
                  msg: "${state.loginModel?.message.toString()}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);


            } else {
              Fluttertoast.showToast(
                  msg: "${state.loginModel?.message.toString()}",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }

            CacheHelper.saveData(key: "token", value: state.loginModel?.data?.token).then((value) {
              print("Navigate");
              loginCubit.get(context).navigateFinish(context, homePageScreen());
            });
          }
        },
      ),
    );
  }
}
