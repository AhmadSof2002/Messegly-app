import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messegly/modules/Login/Login_screen.dart';
import 'package:messegly/modules/register/register_screen.dart';
import 'package:messegly/shared/components/components.dart';
import 'package:messegly/shared/network/local/cache_helper.dart';
import 'package:messegly/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

List<BoardingModel> boarding = [
  BoardingModel(
      image: 'assets/images/chatting.png',
      title: 'Chat with friends ',
      body: 'Message your friends all around the world'),
  BoardingModel(
      image: 'assets/images/notification.png',
      title: 'Stay tuned',
      body:
          'You will Receieve a notifications whenever you have new messages '),
  BoardingModel(
      image: 'assets/images/vidcall.png',
      title: 'Video call',
      body: 'Enjoy video calling your friends or family at anytime!!'),
];
bool isLast = false;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    var boardController = PageController();

    void submit() {
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
        navigateAndFinish(context, LoginScreen());
      });
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 8.0),
              child: defaultTextButton(
                  onPressed: () {
                    print("im working");
                    submit();
                  },
                  text: 'SKIP',
                  color: Colors.white,
                  size: 16))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoradingItem(boarding[index]),
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                      print(isLast);
                    });
                  } else {
                    setState(() {
                      isLast = false;
                      print(isLast);
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      expansionFactor: 4.0,
                      dotWidth: 10.0,
                      spacing: 5.0,
                      activeDotColor: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black87,
                    ),
                    backgroundColor: Colors.white,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoradingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          ),
        ],
      );
}
