import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/homepage/home_model.dart';
import 'package:shoppingapp/homepage/search/search_cubit.dart';
import 'package:shoppingapp/homepage/search/search_model.dart';
import 'package:shoppingapp/homepage/search/search_states.dart';
import 'package:shoppingapp/reusabaleComponents.dart';

class searchScreen extends StatelessWidget {


  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => searchCubit(),
      child: BlocConsumer<searchCubit, searchStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (String text) {
                          searchCubit.get(context).search(text);
                        },
                        validator: (String? text) {
                          if (text!.isEmpty) {
                            return "Cannot be Empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            suffixIcon: Icon(Icons.search_rounded),
                            labelText: "Search"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is searchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is searchSuccessState)
                      Container(
                        height: 1000,
                        child: ListView.separated(
                          itemBuilder: (context, index) => listBuilderWidget(
                              searchCubit
                                  .get(context)
                                  .sModel
                                  ?.data
                                  ?.data?[index],
                              context),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                          itemCount: searchCubit
                                  .get(context)
                                  .sModel
                                  ?.data
                                  ?.data
                                  ?.length ??
                              0,
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, Object? state) {},
      ),
    );
  }
}

Widget listBuilderWidget(model, context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                color: Colors.blueAccent.withOpacity(0.2),
                height: 150,
                width: 155,
                child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage("${model?.image}")),
              ),
              SizedBox(
                width: 25,
              ),
              Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model?.name}',
                      style:
                          TextStyle(fontFamily: myfontName, fontSize: 15),
                      maxLines: 3,
                      softWrap: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${model?.price} EGP',
                      style: TextStyle(
                          backgroundColor: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
