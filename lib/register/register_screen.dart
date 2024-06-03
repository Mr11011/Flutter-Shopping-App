import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/homepage/home_page.dart';
import 'package:shoppingapp/network/cache_helper.dart';
import 'package:shoppingapp/register/bloc/register_cubit.dart';
import 'package:shoppingapp/register/bloc/register_states.dart';
import 'package:shoppingapp/reusabaleComponents.dart';

class registerScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => registerCubit(),
      child: BlocConsumer<registerCubit, registerStates>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Register Page",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: darkerOrange,
              ),
              body: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Registration",
                            style: TextStyle(
                                fontFamily: myfontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 45,
                                color: darkerOrange),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "👋 Start discovering amazing deals! 🛍️🎉",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,fontFamily:myfontName ,
                                color: Colors.blueGrey,),textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: nameController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Cannot Be Empty";
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60)),
                                prefixIcon: Icon(Icons.text_format_outlined),
                                hintText: "Please Enter Your Name ",
                                hoverColor: Colors.lightBlue,
                                labelText: "Name"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 15,
                          ),
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
                                    "Please Enter Your Email Address ",
                                hoverColor: Colors.lightBlue,
                                labelText: "Email"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: phoneController,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Cannot Be Empty";
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60)),
                                prefixIcon: Icon(Icons.phone_outlined),
                                hintText:
                                    "Please Enter Your Phone Number",
                                hoverColor: Colors.lightBlue,
                                labelText: "Phone"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            obscureText: registerCubit.get(context).visibleFlag,
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
                                hintText: "Please Enter Your Password ",
                                labelText: "Password",
                                hoverColor: Colors.lightBlue,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      registerCubit.get(context).suffixIcon),
                                  // Correct usage of the icon parameter
                                  onPressed: () {
                                    registerCubit
                                        .get(context)
                                        .changeVisibility();
                                  },
                                )),
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                registerCubit.get(context).userRegister(
                                    name: "${nameController.text}",
                                    email: "${emailController.text}",
                                    phone: "${phoneController.text}",
                                    password: "${passwordController.text}");
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: 20),
                          ConditionalBuilder(
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                            condition: registerStates is! registerStatesLoading,
                            builder: (context) => Center(
                                child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  registerCubit.get(context).userRegister(
                                      name: "${nameController.text}",
                                      email: "${emailController.text}",
                                      phone: "${phoneController.text}",
                                      password: "${passwordController.text}");
                                }
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: navyBlue,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(220, 50) // Background color
                                  ),
                            )),
                          ),
                          SizedBox(
                            height: 20,
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
          if (state is registerStatesSuccess) {
            if (state.loginModel?.status == true) {
              Fluttertoast.showToast(
                  msg: "${state.loginModel?.message.toString()}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);

              CacheHelper.saveData(
                  key: "token", value: state.loginModel?.data?.token)
                  .then((value) {
                // print("Navigate");
                print(value);
                token=value;
                registerCubit
                    .get(context)
                    .navigateFinish(context, homePageScreen());
              });
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
          }
        },
      ),
    );
  }
}
