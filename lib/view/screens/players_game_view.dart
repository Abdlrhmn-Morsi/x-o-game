import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tictaktoe/model/dimensions.dart';
import 'package:tictaktoe/style/style.dart';
import 'package:tictaktoe/view/widgets/glass_dialoge.dart';

class PlayersGameView extends StatefulWidget {
  const PlayersGameView({Key? key}) : super(key: key);

  @override
  State<PlayersGameView> createState() => _PlayersGameViewState();
}

class _PlayersGameViewState extends State<PlayersGameView> {
  final ConfettiController _controller = ConfettiController();
  bool isO = true;
  dynamic theWinner;
  int ohScore = 0;
  int exScore = 0;
  int draw = 0;
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
                            TextSpan(text: 'PLAYER: ', style: Style.myFontOne),
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
                padding:  EdgeInsets.only(left: Dimensions.px5, right: Dimensions.px5),
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
                          _tapped(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Style.litColor, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              exOroText[index],
                              style:  TextStyle(
                                  color: Colors.white, fontSize: Dimensions.px40),
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
                    theWinner == "X"
                        ? 'X WON!'
                        : theWinner == "O"
                            ? 'O WON!'
                            : draw == 9
                                ? 'draw'
                                : 'Your move',
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          ohScore = 0;
                          exScore = 0;
                          _clear();
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

  // Game Functions
  void _tapped(int index) {
    setState(() {
      if (isO && exOroText[index] == '') {
        exOroText[index] = 'O';
        isO = false;

        draw += 1;
      } else if (exOroText[index] == '') {
        exOroText[index] = 'X';
        isO = true;

        draw += 1;
      }
      _checkWinner();
    });
  }

  void _checkWinner() {
    //row 1
    if (exOroText[0] == exOroText[1] &&
        exOroText[0] == exOroText[2] &&
        exOroText[0] != '') {
      _winnerParty();
      _showWinnerDialoge(exOroText[0]);
    }
    //row 2
    if (exOroText[3] == exOroText[4] &&
        exOroText[3] == exOroText[5] &&
        exOroText[3] != '') {
      _winnerParty();
      _showWinnerDialoge(exOroText[3]);
    }
    //row 3
    if (exOroText[6] == exOroText[7] &&
        exOroText[6] == exOroText[8] &&
        exOroText[6] != '') {
      _winnerParty();
      _showWinnerDialoge(exOroText[6]);
    }
    // column 1
    if (exOroText[0] == exOroText[3] &&
        exOroText[0] == exOroText[6] &&
        exOroText[0] != '') {
      _winnerParty();
      _showWinnerDialoge(exOroText[0]);
    }
    // column 2
    if (exOroText[1] == exOroText[4] &&
        exOroText[1] == exOroText[7] &&
        exOroText[1] != '') {
      _winnerParty();
      _showWinnerDialoge(exOroText[1]);
    }
    //column 3
    if (exOroText[2] == exOroText[5] &&
        exOroText[2] == exOroText[8] &&
        exOroText[2] != '') {
      _winnerParty();
      _showWinnerDialoge(exOroText[2]);
    }
    //cross 1
    if (exOroText[0] == exOroText[4] &&
        exOroText[0] == exOroText[8] &&
        exOroText[0] != '') {
      _winnerParty();
      _showWinnerDialoge(exOroText[0]);
    }
    //cross 2
    if (exOroText[2] == exOroText[4] &&
        exOroText[2] == exOroText[6] &&
        exOroText[2] != '') {
      _winnerParty();
      _showWinnerDialoge(exOroText[2]);
    } else if (draw == 9) {
      _showDrawDialoge();
    }
  }

  void _showWinnerDialoge(winnner) {
    theWinner = winnner;
    showDialog(
      context: context,
      barrierColor: null,
      barrierDismissible: false,
      builder: (ctx) {
        return Align(
          alignment: Alignment.center,
          child: GlassDialoge(
            winner: winnner,
            onTapped: () {
              _clear();
              _controller.stop();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
    if (winnner == 'O') {
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
        for (var i = 0; i < 9; i++) {
          exOroText[i] = '';
        }
        draw = 0;
        theWinner = '';
      },
    );
  }

  void _winnerParty() {
    _controller.play();
  }
}
