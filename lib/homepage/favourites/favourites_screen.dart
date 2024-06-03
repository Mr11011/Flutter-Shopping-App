import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/homepage/favourites/favorites_model.dart';
import 'package:shoppingapp/homepage/home_cubit.dart';
import 'package:shoppingapp/homepage/home_model.dart';
import 'package:shoppingapp/homepage/states.dart';
import 'package:shoppingapp/reusabaleComponents.dart';

class favScreen extends StatelessWidget {
  productsModel? model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit, homePageStates>(
      builder: (BuildContext context, homePageStates state) {
        var cubit = homeCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is !fetch_favLoadingState ,
            fallback: (BuildContext context) =>
                Center(child: CircularProgressIndicator()),
            builder: (BuildContext context) => ListView.separated(
              itemBuilder: (context, index) =>
                  favBuilderWidget(cubit.favModel?.data?.data?[index], context),
              separatorBuilder: (context, index) => SizedBox(
                height: 5,
              ),
              itemCount: cubit.favModel?.data?.data?.length ?? 0,
            ),
          ),
        );
      },
      listener: (BuildContext context, homePageStates state) {},
    );
  }
}

Widget favBuilderWidget(Data_fav? favData, context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              IconButton(
                  onPressed: () {
                    homeCubit.get(context).changeFavs(favData?.product?.id);
                  },
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    size: 30,
                    color: homeCubit.get(context).favModel?.status ?? false
                        ? Colors.grey
                        : Colors.red,
                  )),
              Row(
                children: [
                  Container(
                    color: Colors.blueAccent.withOpacity(0.2),
                    height: 150,
                    width: 155,
                    child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage("${favData?.product?.image}")),
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
                          '${favData?.product?.name}',
                          style:
                              TextStyle(fontFamily: myfontName, fontSize: 15),
                          maxLines: 3,
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${favData?.product?.price} EGP',
                          style: TextStyle(
                              backgroundColor: Colors.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('${favData?.product?.oldPrice} EGP',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
