import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tictaktoe/style/style.dart';
import 'package:tictaktoe/view/widgets/glass_dialoge.dart';
import '../../model/dimensions.dart';

class AiGameView extends StatefulWidget {
  const AiGameView({Key? key}) : super(key: key);

  @override
  State<AiGameView> createState() => _AiGameViewState();
}

class _AiGameViewState extends State<AiGameView> {
  final ConfettiController _controller = ConfettiController();
  var tiles = List.filled(9, 0);
  bool isO = false;
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
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          backgroundColor: Style.mainColor,
          body: Column(
            children: [
              SizedBox(height: Dimensions.px70),
              // who is playing and the score
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // O player
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Dimensions.px20),
                      // who is playing
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: 'AI: ', style: Style.myFontOne),
                            TextSpan(
                              text: 'O',
                              style: isO ? Style.PLAYNOW : Style.myFontOne,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.px20),
                      // the score
                      Text(
                        ohScore.toString(),
                        style: Style.myFontOne,
                      ),
                    ],
                  ),
                  // X player
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Dimensions.px20),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: 'PLAYER: ', style: Style.myFontOne),
                            TextSpan(
                              text: 'X',
                              style: isO ? Style.myFontOne : Style.PLAYNOW,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.px20),
                      Text(
                        exScore.toString(),
                        style: Style.myFontOne,
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              // the grid game
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.px5, right: Dimensions.px5),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (tiles[index] == 0) {
                              draw += 2;
                              tiles[index] = 1;
                              runAi();
                              isO = !isO;
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Style.litColor, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              tiles[index] == 0
                                  ? ''
                                  : tiles[index] == 1
                                      ? 'X'
                                      : 'O',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.px40),
                            ),
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
                  Text(
                    isWinning(1, tiles)
                        ? 'You won!'
                        : isWinning(2, tiles)
                            ? 'You lost!'
                            : draw == 10
                                ? 'draw'
                                : 'Your move',
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          ohScore = 0;
                          exScore = 0;
                          tiles = List.filled(9, 0);
                          draw = 0;
                        });
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
              SizedBox(height: Dimensions.px20)
            ],
          ),
        ),
        // winner celebration
        ConfettiWidget(
          emissionFrequency: 0.2,
          confettiController: _controller,
          blastDirection: pi / 2,
          gravity: 0.1,
          colors: const [
            Color(0xffFCD900),
            Colors.white,
            Colors.black,
          ],
        )
      ],
    );
  }

  void runAi() async {
    await Future.delayed(const Duration(milliseconds: 300));

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

    if (move != null) {
      setState(() {
        tiles[move] = 2;
      });
    }
    isWinning(1, tiles)
        ? {_winnerParty(), _showWinnerDialoge('X')}
        : isWinning(2, tiles)
            ? _showWinnerDialoge('AI')
            : draw == 10
                ? _showDrawDialoge()
                : null;
  }

  bool isWinning(int who, List<int> tiles) {
    return (tiles[0] == who && tiles[1] == who && tiles[2] == who) ||
        (tiles[3] == who && tiles[4] == who && tiles[5] == who) ||
        (tiles[6] == who && tiles[7] == who && tiles[8] == who) ||
        (tiles[0] == who && tiles[4] == who && tiles[8] == who) ||
        (tiles[2] == who && tiles[4] == who && tiles[6] == who) ||
        (tiles[0] == who && tiles[3] == who && tiles[6] == who) ||
        (tiles[1] == who && tiles[4] == who && tiles[7] == who) ||
        (tiles[2] == who && tiles[5] == who && tiles[8] == who);
  }

  void _showWinnerDialoge(winnner) {
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
              _clear();
              _controller.stop();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
    if (winnner == 'AI') {
      setState(() {
        ohScore += 1;
      });
    } else if (winnner == 'X') {
      setState(() {
        exScore += 1;
      });
    }
  }

  void _showDrawDialoge() {
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
              _clear();

              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  void _clear() {
    setState(
      () {
        tiles = List.filled(9, 0);
        draw = 0;
      },
    );
  }

  void _winnerParty() {
    _controller.play();
  }
}
