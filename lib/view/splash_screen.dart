import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:tictaktoe/view/game_view.dart';
import '../style/style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.mainColor,
      body: Stack(
        children: [
          // title
          Positioned(
            top: 90,
            left: Get.width / 9,
            child: Text(
              'TIC TAC TOE',
              style: Style.myFontSplach,
            ),
          ),
          //img
          Container(
            margin: const EdgeInsets.only(top: 200),
            height: 300,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/player-1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //btn
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
            child: SlideAction(
              alignment: Alignment.bottomCenter,
              text: 'Play Now',
              elevation: 6,
              textStyle: GoogleFonts.pressStart2p(
                  textStyle: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              )),
              innerColor: Colors.white,
              outerColor: Colors.grey.shade900,
              onSubmit: () {
                Get.to(() => const GameView());
              },
            ),
          ),
          //Author
          Positioned(
            left: Get.width / 4.5,
            bottom: 20,
            child: Text(
              'by @abdlrhmnmorsi',
              style: Style.myFontSplach2,
            ),
          ),
        ],
      ),
    );
  }
}
