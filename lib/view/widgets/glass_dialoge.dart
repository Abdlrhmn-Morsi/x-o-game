// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tictaktoe/model/dimensions.dart';

// ignore: must_be_immutable
class GlassDialoge extends StatelessWidget {
  dynamic winner;
  dynamic onTapped;
  bool isDraw;
  GlassDialoge({
    Key? key,
    this.winner,
    required this.onTapped,
    this.isDraw = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: Dimensions.px220,
        width: Dimensions.px220,
        child: Stack(
          children: [
            // blur effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
            ),
            // graidain effect
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.1)
                  ],
                ),
              ),
            ),
            //content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isDraw
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(top: Dimensions.px5),
                        child: Text(
                          'THE WINNER IS',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: Dimensions.px22,
                          ),
                        ),
                      ),
                SizedBox(height: Dimensions.px10),
                //who is the player or drew
                Container(
                  padding: EdgeInsets.all(Dimensions.px30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(1),
                        Colors.grey.shade500.withOpacity(1),
                      ],
                    ),
                  ),
                  child: Text(
                    winner,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontSize: Dimensions.px35),
                  ),
                ),
                SizedBox(height: Dimensions.px10),
                // play again btn
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MaterialButton(
                    color: Colors.grey.shade900,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: onTapped,
                    child: Text(
                      'play again',
                      style: TextStyle(
                        fontSize: Dimensions.px20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
