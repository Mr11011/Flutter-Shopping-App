import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shoppingapp/homepage/categories/categoriesModel.dart';
import 'package:shoppingapp/homepage/home_cubit.dart';
import 'package:shoppingapp/homepage/home_model.dart';
import 'package:shoppingapp/homepage/states.dart';
import 'package:shoppingapp/reusabaleComponents.dart';

class productScreen extends StatelessWidget {
  // const homePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit, homePageStates>(
      builder: (BuildContext context, homePageStates state) {
        var cubit = homeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.home_model != null && cubit.categoryData != null,
          builder: (context) => homeBuilder(homeCubit.get(context).home_model!,
              homeCubit.get(context).categoryData!, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, homePageStates state) {},
    );
  }
}

Widget homeBuilder(
        homeModel model, allcategoriesModel categoryModel, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConditionalBuilder(
              condition:
                  homeCubit.get(context).home_model!.data!.banners.isNotEmpty,
              builder: (context) => CarouselSlider(
                    carouselController: CarouselController(),
                    items: model.data?.banners
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 5),
                              child: Image(
                                image: NetworkImage("${e.image}"),
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.fitWidth,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 900),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      enlargeFactor: 0.3,
                    ),
                  ),
              fallback: (context) => Center(
                      child: Container(
                    color: Colors.white,
                  ))),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: Container(
                  height: 5,
                  width: 252,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5.0, left: 10),
            child: Center(
              child: Text(
                "Categories",
                style: TextStyle(
                    fontFamily: myfontName,
                    fontSize: 25,
                    color: HexColor("0E46A3")),
              ),
            ),
          ),
          Container(
            height: 135,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  categoryWidget(categoryModel.data!.data[index]),
              separatorBuilder: (context, index) => SizedBox(
                width: 8,
              ),
              itemCount: categoryModel.data!.data.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 5.0, left: 10),
            child: Center(
              child: Text(
                "New Products",
                style: TextStyle(
                    fontFamily: myfontName,
                    fontSize: 25,
                    color: HexColor("0E46A3")),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Container(
              color: Colors.white24,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 35,
                crossAxisSpacing: 25,
                childAspectRatio: 1 / 1.44,
                children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        gridBuilder(model.data!.products[index], context)),
              ),
            ),
          )
        ],
      ),
    );

Widget gridBuilder(productsModel ModelOfProduct, context) => Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Image(
                  image: NetworkImage("${ModelOfProduct.image}"),
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.scaleDown,
                ),
                if (ModelOfProduct.discount != 0)
                  Positioned(
                    top: 10,
                    left: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      color: Colors.red,
                      child: Text(
                        "SALE",
                        style: TextStyle(
                            color: Colors.white, fontFamily: myfontName),
                      ),
                    ),
                  ),
                Positioned(
                    left: 135,
                    child: CircleAvatar(
                      backgroundColor: homeCubit
                                  .get(context)
                                  .favoritesMap[ModelOfProduct.id] ==
                              false
                          ? Colors.white.withOpacity(0.95)
                          : Colors.red.withOpacity(0.60),
                      child: IconButton(
                        onPressed: () {
                          homeCubit.get(context).changeFavs(ModelOfProduct.id!);
                        },
                        icon: Icon(Icons.favorite_outline_rounded),
                        color: homeCubit
                                    .get(context)
                                    .favoritesMap[ModelOfProduct.id] ==
                                false
                            ? Colors.grey.withOpacity(0.95)
                            : Colors.white.withOpacity(0.8),
                      ),
                    ))
              ],
            ),
            Text(
              "${ModelOfProduct.name}",
              maxLines: 2,
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Container(
                    color: Colors.amberAccent,
                    child: Text(
                      "${ModelOfProduct.price.round()}" + " EGP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: myfontName,
                          color: Colors.deepOrangeAccent),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                if (ModelOfProduct.price - ModelOfProduct.old_price != 0)
                  Text(
                    "${ModelOfProduct.old_price.round()}" + " EGP",
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontFamily: myfontName,
                        color: Colors.blueGrey,
                        fontSize: 13),
                  ),
              ],
            ),
          ],
        ),
      ),
    );

Widget categoryWidget(dataOfCategory data) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 125,
          width: 150,
          child: Image(
            image: NetworkImage(data.image!),
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
          width: 90,
          height: 25,
          color: navyBlue.withOpacity(0.5),
          child: Text(
            data.name!,
            softWrap: true,
            style: TextStyle(color: Colors.white, fontFamily: myfontName),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
      ],
    );
