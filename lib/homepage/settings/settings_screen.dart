import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/homepage/home_cubit.dart';
import 'package:shoppingapp/homepage/states.dart';
import 'package:shoppingapp/network/Diohelper.dart';
import 'package:shoppingapp/network/cache_helper.dart';
import 'package:shoppingapp/register/bloc/register_states.dart';
import 'package:shoppingapp/reusabaleComponents.dart';

class settingsScreen extends StatelessWidget {
  // const homePageScreen({super.key});
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit, homePageStates>(
      builder: (context, state) {
        var usermodel = homeCubit.get(context).userModel;
        nameController.text = usermodel?.data?.name ?? 'None';
        emailController.text = usermodel?.data?.email ?? 'Not Found';
        phoneController.text = usermodel?.data?.phone ?? 'Not Found';
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (state is userLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Account Data",
                    style: TextStyle(fontSize: 35, fontFamily: myfontName),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  // name txt field
                  TextFormField(
                    controller: nameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Cannot be Empty";
                      }
                    },
                    maxLines: 1,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45)),
                        prefixIcon: Icon(Icons.format_color_text),
                        hintText: "Enter Your Name",
                        labelText: "Username"),
                    // readOnly: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // email text field
                  TextFormField(
                    controller: emailController,
                    // validator: () {},
                    maxLines: 1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45)),
                        prefixIcon: Icon(Icons.email),
                        hintText: "Enter your Email",
                        labelText: "Email Address"),
                    keyboardType: TextInputType.emailAddress,
                    // readOnly: true,
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  // phone text field
                  TextFormField(
                    controller: phoneController,
                    // validator: () {},
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45)),
                        prefixIcon: Icon(Icons.phone),
                        hintText: "Enter your Phone",
                        labelText: "Phone Number"),
                    // readOnly: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        signOut(context);
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        homeCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(fontSize: 22),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: navyBlue,
                        foregroundColor: Colors.white,
                        minimumSize: Size(180, 40) // Background color
                        ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
