import 'package:get/get.dart';
import 'package:tictaktoe/controller/xo_ai_controller.dart';
import 'package:tictaktoe/controller/xo_players_controller.dart';

class Inject {
  XoPlayerController xoPlayerController = Get.put(XoPlayerController());
  XoAiController xoAiController = Get.put(XoAiController());
}
