import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/homepage/categories/categoriesModel.dart';
import 'package:shoppingapp/homepage/home_cubit.dart';
import 'package:shoppingapp/homepage/home_model.dart';
import 'package:shoppingapp/homepage/states.dart';
import 'package:shoppingapp/reusabaleComponents.dart';

class categoriesScreen extends StatelessWidget {
  // const homePageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit, homePageStates>(
      builder: (context, state) {
        var cubit = homeCubit.get(context);
        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) =>
                categoryItems(cubit.categoryData!.data!.data[index]),
            separatorBuilder: (context, index) => Container(
              color: Colors.grey,
              height: 2,width: 100,
            ),
            itemCount: cubit.categoryData!.data!.data.length,
            physics: BouncingScrollPhysics(),
          ),
        );
      },
      listener: (context, Object? state) {},
    );
  }
}

Widget categoryItems(dataOfCategory model) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(
        children: [
          Container(
              width: 120,
              height: 140,
              child: CircleAvatar(
                child: Image(
                  image: NetworkImage(model.image!),fit: BoxFit.contain,

                ),
              )),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 150,
            child: Text(
              model.name!,
              maxLines: 2,
              softWrap: true,
              style: TextStyle(fontWeight: FontWeight.bold,fontFamily: myfontName, fontSize: 18),
            ),
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
);
