import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/widgets/glass_dialoge.dart';

class XoPlayerController extends GetxController {
  AudioPlayer? audioPlayer;

  final ConfettiController confettiController = ConfettiController();
  List<String> exOroText = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  bool isO = true;
  dynamic theWinner;
  int ohScore = 0;
  int exScore = 0;
  int draw = 0;
  // Game Functions
  void tapped(int index, BuildContext context) {
    if (isO && exOroText[index] == '') {
      exOroText[index] = 'O';
      isO = false;

      draw += 1;
    } else if (exOroText[index] == '') {
      exOroText[index] = 'X';
      isO = true;

      draw += 1;
    }
    _checkWinner(context);
    playTapSound();
    update();
  }

  void _checkWinner(BuildContext context) {
    bool isWin = false;
    //row 1
    if (exOroText[0] == exOroText[1] &&
        exOroText[0] == exOroText[2] &&
        exOroText[0] != '') {
      isWin = true;
      winnerParty();
      _showWinnerDialoge(exOroText[0], context);
    }
    //row 2
    if (exOroText[3] == exOroText[4] &&
        exOroText[3] == exOroText[5] &&
        exOroText[3] != '') {
      isWin = true;

      winnerParty();
      _showWinnerDialoge(exOroText[3], context);
    }
    //row 3
    if (exOroText[6] == exOroText[7] &&
        exOroText[6] == exOroText[8] &&
        exOroText[6] != '') {
      isWin = true;

      winnerParty();
      _showWinnerDialoge(exOroText[6], context);
    }
    // column 1
    if (exOroText[0] == exOroText[3] &&
        exOroText[0] == exOroText[6] &&
        exOroText[0] != '') {
      isWin = true;

      winnerParty();
      _showWinnerDialoge(exOroText[0], context);
    }
    // column 2
    if (exOroText[1] == exOroText[4] &&
        exOroText[1] == exOroText[7] &&
        exOroText[1] != '') {
      isWin = true;

      winnerParty();
      _showWinnerDialoge(exOroText[1], context);
    }
    //column 3
    if (exOroText[2] == exOroText[5] &&
        exOroText[2] == exOroText[8] &&
        exOroText[2] != '') {
      isWin = true;

      winnerParty();
      _showWinnerDialoge(exOroText[2], context);
    }
    //cross 1
    if (exOroText[0] == exOroText[4] &&
        exOroText[0] == exOroText[8] &&
        exOroText[0] != '') {
      isWin = true;

      winnerParty();
      _showWinnerDialoge(exOroText[0], context);
    }
    //cross 2
    if (exOroText[2] == exOroText[4] &&
        exOroText[2] == exOroText[6] &&
        exOroText[2] != '') {
      isWin = true;

      winnerParty();
      _showWinnerDialoge(exOroText[2], context);
    } else if (isWin == false && draw == 9) {
      _showDrawDialoge(context);
    }
    update();
  }

  void _showWinnerDialoge(winnner, BuildContext context) async {
    theWinner = winnner;
    await showDialog(
      context: context,
      barrierColor: null,
      barrierDismissible: false,
      builder: (ctx) {
        return Align(
          alignment: Alignment.center,
          child: GlassDialoge(
            winner: winnner,
            onTapped: () {
              clear();
              confettiController.stop();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
    if (winnner == 'O') {
      ohScore += 1;
    } else if (winnner == 'X') {
      exScore += 1;
    }
    update();
  }

  void _showDrawDialoge(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: null,
      barrierDismissible: false,
      builder: (ctx) {
        return Align(
          alignment: Alignment.center,
          child: GlassDialoge(
            winner: 'Draw',
            isDraw: true,
            onTapped: () {
              clear();

              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
    update();
  }

  void clear() {
    for (var i = 0; i < 9; i++) {
      exOroText[i] = '';
    }
    draw = 0;
    theWinner = '';
    audioPlayer!.stop();
    update();
  }

  void winnerParty() {
    confettiController.play();
    update();
  }

  void playTapSound() async {
    await audioPlayer!.stop();
    audioPlayer!.play(AssetSource('sounds/move.mp3'));
  }


  @override
  void dispose() {
    super.dispose();
    confettiController.dispose();
  }

  @override
  void onInit() {
    audioPlayer = AudioPlayer();
    super.onInit();
  }
}
