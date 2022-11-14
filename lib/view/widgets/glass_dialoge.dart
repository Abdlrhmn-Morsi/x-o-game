import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        height: 170.h,
        width: 180.w,
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
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          'THE WINNER IS',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                SizedBox(height: 10.h),
                //who is the player or drew
                Container(
                  padding: EdgeInsets.all(25.h),
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
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
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
                        fontSize: 15.sp,
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
