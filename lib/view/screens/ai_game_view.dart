import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictaktoe/controller/xo_ai_controller.dart';
import 'package:tictaktoe/style/style.dart';
import 'package:tictaktoe/view/screens/home_view.dart';

class AiGameView extends GetView<XoAiController> {
  const AiGameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var val = await Get.off(const HomeView());

        if (val != null) {
          return Future.value(true);
        } else {
          return Future.value(true);
        }
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
            backgroundColor: Style.mainColor,
            body: Column(
              children: [
                SizedBox(height: 70.h),
                // who is playing and the score
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // O player

                    GetBuilder<XoAiController>(
                      builder: (controller) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.h),
                          // who is playing
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: 'AI: ', style: Style.myFontOne),
                                TextSpan(
                                  text: 'O',
                                  style: controller.isO
                                      ? Style.PLAYNOW
                                      : Style.myFontOne,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          // the score
                          Text(
                            controller.ohScore.toString(),
                            style: Style.myFontOne,
                          ),
                        ],
                      ),
                    ),
                    // X player
                    GetBuilder<XoAiController>(
                      builder: (controller) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.h),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'PLAYER: ', style: Style.myFontOne),
                                TextSpan(
                                  text: 'X',
                                  style: controller.isO
                                      ? Style.myFontOne
                                      : Style.PLAYNOW,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            controller.exScore.toString(),
                            style: Style.myFontOne,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Spacer(),
                // the grid game
                Padding(
                  padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 9,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        return GetBuilder<XoAiController>(
                          builder: (controller) => GestureDetector(
                            onTap: () async {
                              if (controller.isPlayerBlocked &&
                                  controller.tiles[index] == 0) {
                                controller.playTapSound();
                                controller.tiles[index] = 1;
                                controller.runAi(context);
                                controller.draw += 2;
                                controller.isO = !controller.isO;
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Style.litColor, width: 2.w),
                              ),
                              child: Center(
                                  child: GetX<XoAiController>(
                                builder: (controller) => Text(
                                  controller.tiles[index] == 0
                                      ? ''
                                      : controller.tiles[index] == 1
                                          ? 'X'
                                          : 'O',
                                  style: GoogleFonts.pressStart2p(
                                      textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                  )),
                                ),
                              )),
                            ),
                          ),
                        );
                      }),
                ),
                const Spacer(),
                //bottom info
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GetBuilder<XoAiController>(
                      builder: (controller) => Text(
                        controller.isWinning(1, controller.tiles)
                            ? 'You won!'
                            : controller.isWinning(2, controller.tiles)
                                ? 'You lost!'
                                : controller.draw == 10
                                    ? 'draw'
                                    : 'Your move',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          controller.ohScore = 0;
                          controller.exScore = 0;
                          controller.clear();
                          controller.draw = 0;
                        },
                        child: const Text(
                          'Restart',
                          style: TextStyle(color: Colors.amber),
                        ))
                  ],
                ),
                //bottom title
                Text(
                  'created by flutter',
                  style: Style.myFontOne,
                ),
                SizedBox(height: 20.h)
              ],
            ),
          ),
          // winner celebration
          GetBuilder<XoAiController>(
            builder: (controller) => ConfettiWidget(
              emissionFrequency: 0.2,
              confettiController: controller.confettiController,
              blastDirection: pi / 2,
              gravity: 0.1,
              colors: const [
                Color(0xffFCD900),
                Colors.white,
                Colors.black,
              ],
            ),
          )
        ],
      ),
    );
  }
}
