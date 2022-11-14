import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import '../view/widgets/glass_dialoge.dart';

class XoAiController extends GetxController {
  AudioPlayer? audioPlayer;
  final ConfettiController confettiController = ConfettiController();
  RxList<int> tiles = List.filled(9, 0).obs;
  bool isO = false;
  bool isLose = false;
  bool isPlayerBlocked = true;
  int ohScore = 0;
  int exScore = 0;
  int draw = 0;
  List<String> exORoText = [
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

  void runAi(BuildContext context) async {
    isPlayerBlocked = false;
    await Future.delayed(const Duration(milliseconds: 700));
    int? winning;
    int? blocking;
    int? normal;

    for (var i = 0; i < 9; i++) {
      var val = tiles[i];

      if (val > 0) {
        continue;
      }

      var future = [...tiles]..[i] = 2;

      if (isWinning(2, future)) {
        winning = i;
      }

      future[i] = 1;

      if (isWinning(1, future)) {
        blocking = i;
      }

      normal = i;
    }

    var move = winning ?? blocking ?? normal;

    if (move != null) {}
    if (isWinning(1, tiles, move: move)) {
      _winnerParty();
      showWinnerDialoge('X', context);
    } else if (isWinning(1, tiles, move: move) == false &&
        isWinning(2, tiles, move: move) == false &&
        draw == 10) {
      _showDrawDialoge(context);
    } else if (move != null) {
      tiles[move] = 2;
      if (isWinning(2, tiles, move: move)) {
        showWinnerDialoge('AI', context);
      }
      playTapSound();
    }
    isPlayerBlocked = true;

    update();
  }

  bool isWinning(int who, List<int> tiles, {int? move}) {
    return (tiles[0] == who && tiles[1] == who && tiles[2] == who) ||
        (tiles[3] == who && tiles[4] == who && tiles[5] == who) ||
        (tiles[6] == who && tiles[7] == who && tiles[8] == who) ||
        (tiles[0] == who && tiles[4] == who && tiles[8] == who) ||
        (tiles[2] == who && tiles[4] == who && tiles[6] == who) ||
        (tiles[0] == who && tiles[3] == who && tiles[6] == who) ||
        (tiles[1] == who && tiles[4] == who && tiles[7] == who) ||
        (tiles[2] == who && tiles[5] == who && tiles[8] == who);
  }

  void showWinnerDialoge(winnner, BuildContext context) {
    showDialog(
      context: context,
      barrierColor: null,
      barrierDismissible: false,
      builder: (ctx) {
        return Align(
          alignment: Alignment.center,
          child: GlassDialoge(
            winner: winnner.toString(),
            onTapped: () {
              clear();
              confettiController.stop();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
    if (winnner == 'AI') {
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
    tiles = List.filled(9, 0).obs;
    draw = 0;
    isPlayerBlocked = true;
    update();
  }

  void _winnerParty() {
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
