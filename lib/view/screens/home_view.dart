import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:tictaktoe/view/screens/ai_game_view.dart';
import 'package:tictaktoe/view/screens/players_game_view.dart';
import '../../style/style.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.mainColor,
      body: Column(
        children: [
          SizedBox(height: 80.h),
          // title
          Text(
            'XO KNIGHT',
            style: Style.myFontSplach,
          ),
          const Spacer(),
          //img
          Container(
            height: 330.h,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/player-1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(),
          //btn 1
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            child: SlideAction(
              sliderButtonIconSize: 10.sp,
              height: 45.h,
              alignment: Alignment.bottomCenter,
              text: 'Two Players',
              elevation: 6,
              textStyle: GoogleFonts.pressStart2p(
                  textStyle: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
              )),
              innerColor: Colors.white,
              outerColor: Colors.grey.shade900,
              onSubmit: () {
                Get.off(() => const PlayersGameView());
              },
            ),
          ),
          SizedBox(height: 20.h),
          //btn 2
          Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            child: SlideAction(
              sliderButtonIconSize: 10.sp,
              height: 45.h,
              alignment: Alignment.bottomCenter,
              text: 'With AI',
              elevation: 6,
              textStyle: GoogleFonts.pressStart2p(
                  textStyle: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
              )),
              innerColor: Colors.white,
              outerColor: Colors.grey.shade900,
              onSubmit: () {
                Get.off(() => const AiGameView());
              },
            ),
          ),
          SizedBox(height: 50.h),
          //Author
          Text(
            'created by flutter',
            style: Style.myFontSplach2,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
