import 'package:flutter/material.dart';
import 'package:shoppingapp/login/login_page.dart';
import 'package:shoppingapp/network/cache_helper.dart';
import 'package:shoppingapp/reusabaleComponents.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingScreen extends StatefulWidget {
  onBoardingScreen({super.key});

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  List<onBoardingPagesModel> models = [
    onBoardingPagesModel(
        imageView: "assets/images11.png", title: "title1", body: "body1"),
    onBoardingPagesModel(
        imageView: "assets/images2.png", title: "title2", body: "body2"),
    onBoardingPagesModel(
        imageView: "assets/download.png", title: "title3", body: "body3"),
  ];

  var onBoardController = PageController();

  bool islAST = false;

  // this method will save shared preferences after skip or navigate from onBoarding screen
  void saveOnBoardingPreferences() {
    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      if (value) {
        navigateTo(context, loginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                saveOnBoardingPreferences();
              },
              child: Text(
                "SKIP",
                style:
                    TextStyle(fontFamily: "PoetsenOne-Regular", fontSize: 18),
              ))
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: onBoardController,
                  onPageChanged: (int index) {
                    setState(() {
                      if (index == models.length - 1) {
                        islAST = true;
                      } else {
                        islAST = false;
                      }
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnBoardingItems(models[index]);
                  },
                  itemCount: models.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                        controller: onBoardController, // PageController
                        count: models.length,
                        effect: JumpingDotEffect(), // your preferred effect
                        onDotClicked: (index) {}),
                    Spacer(),
                    FloatingActionButton(
                        onPressed: () {
                          if (islAST == true) {
                            saveOnBoardingPreferences();
                          } else {
                            onBoardController.nextPage(
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeOutBack);
                          }
                        },
                        child: Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var image1 = "assets/images11.png";

Widget OnBoardingItems(onBoardingPagesModel model) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage("${model.imageView}"),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          "Welcome 👋🚀",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "PoetsenOne-Regular", fontSize: 20),
        ),
        SizedBox(
          height: 25,
        ),
        Text("Shop smarter, simpler & Find everything you need",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(
          height: 55,
        )
      ],
    );

class onBoardingPagesModel {
  late final String imageView;
  late final String title;
  late final String body;

  onBoardingPagesModel({
    required this.imageView,
    required this.title,
    required this.body,
  });
}

void navigateFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
