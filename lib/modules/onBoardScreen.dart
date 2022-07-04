import 'package:flutter/material.dart';
import 'package:shop/models/onBoardModel.dart';
import 'package:shop/modules/user/login_screen.dart';
import 'package:shop/modules/user/registeration_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
List <OnBoard> items = [
  OnBoard(
    body: 'Now Ask Doctors online or you can request one to come to you or you go to him',
    img: 'doctor2.png',
    title: 'Doctors Service',
  ),
  OnBoard(
    body: 'Now You Can buy every thing or sell online on our app',
    img: 'onlineShopping.png',
    title: 'Shopping Service',
  ),
  OnBoard(
    body: 'And You will be able to pay online too to give you full Online Service',
    img: 'payOnline.jpg',
    title: 'Paying Service',
  ),
  OnBoard(
    body: "What if you don't trust paying online ? you can pay offline when you receive your purchases",
    img: 'payOffline.png',
    title: 'Paying Service',
  ),
];

void submitOnBoardScreen (){
  CacheHelper.saveData(key: 'onBoard', value: true)?.then((value){
    if(value == true){
      NavToAndCancel(context, RegisterScreen());
    }
  });

}
bool isLast = false;

PageController pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: (){
              submitOnBoardScreen();
            },
            child: Text(
              'SKIP',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
        title: Text(
          'E7demny',
          style: Theme.of(context).textTheme.headline5?.copyWith(
            color: Colors.blue,
            fontWeight: FontWeight.w900,

          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index == items.length - 1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageViewController,
                itemBuilder:
                    (context, index) =>
                        onBoardItem(
                            model: items[index] , context: context),
                itemCount: items.length,
                physics: BouncingScrollPhysics(),
              ),
            ),
            height( 50.0,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller:pageViewController,
                  count: items.length,
                  effect: ExpandingDotsEffect(
                  ),
                ) ,
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submitOnBoardScreen();
                    }else{
                      pageViewController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child: Icon(
                      Icons.arrow_forward_ios
                  ),
                ),
              ],
            ),
            height(20.0,),
          ],
        ),
        ),
    );
  }
}
