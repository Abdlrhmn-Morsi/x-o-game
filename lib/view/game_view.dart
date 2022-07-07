import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:tictaktoe/style/style.dart';
import 'package:tictaktoe/view/widgets/glass_dialoge.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final ConfettiController _controller = ConfettiController();
  bool isO = true;
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
              // who is playing and the score
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // O player
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      Text(
                        exScore.toString(),
                        style: Style.myFontOne,
                      ),
                    ],
                  )
                ],
              )),
              // the grid game
              Expanded(
                flex: 3,
                child: GridView.builder(
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
                            
                            border: Border.all(color: Style.litColor,width: 2),
                          ),
                          child: Center(
                            child: Text(
                              exOroText[index],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 40),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              // game name & author
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text(
                      'TIC TAC TOE',
                      style: Style.myFontOne,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'by @abdlrhmnmorsi',
                      style: Style.myFontOne,
                      
                    ),
                  ]))
            ],
          ),
        ),
        // winner celebration
        ConfettiWidget(
          emissionFrequency: 0.2,
          confettiController: _controller,
          blastDirection: pi / 2,
          gravity: 0.1,
          colors:const [
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

        draw += 1;
      } else if (exOroText[index] == '') {
        exOroText[index] = 'X';
        draw += 1;
      }
      isO = !isO;
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
      },
    );
  }

  void _winnerParty() {
    _controller.play();
  }
}
