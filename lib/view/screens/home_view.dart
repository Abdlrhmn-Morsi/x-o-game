import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:tictaktoe/model/dimensions.dart';
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
           SizedBox(height: Dimensions.px80),
          // title
          Text(
            'TIC TAC TOE',
            style: Style.myFontSplach,
          ),
          const Spacer(),
          //img
          Container(
            height: Dimensions.px330,
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
            padding:  EdgeInsets.only(left: Dimensions.px20, right: Dimensions.px20,),
            child: SlideAction(
              sliderButtonIconSize: Dimensions.px10,
              height: Dimensions.px50,
              alignment: Alignment.bottomCenter,
              text: 'Two Players',
              elevation: 6,
              textStyle: GoogleFonts.pressStart2p(
                  textStyle:  TextStyle(
                fontSize: Dimensions.px12,
                color: Colors.white,
              )),
              innerColor: Colors.white,
              outerColor: Colors.grey.shade900,
              onSubmit: () {
                Get.off(() => const PlayersGameView());
              },
            ),
          ),
           SizedBox(height: Dimensions.px20),
          //btn 2
          Padding(
            padding:  EdgeInsets.only(left: Dimensions.px20, right: Dimensions.px20,),
            child: SlideAction(
              sliderButtonIconSize: Dimensions.px10,
              height: Dimensions.px50,
              alignment: Alignment.bottomCenter,
              text: 'With AI',
              elevation: 6,
              textStyle: GoogleFonts.pressStart2p(
                  textStyle:  TextStyle(
                fontSize: Dimensions.px12,
                color: Colors.white,
              )),
              innerColor: Colors.white,
              outerColor: Colors.grey.shade900,
              onSubmit: () {
                Get.off(() => const AiGameView());
              },
            ),
          ),
           SizedBox(height: Dimensions.px50),
          //Author
          Text(
            'created by flutter',
            style: Style.myFontSplach2,
          ),
           SizedBox(height: Dimensions.px20),
        ],
      ),
    );
  }
}
