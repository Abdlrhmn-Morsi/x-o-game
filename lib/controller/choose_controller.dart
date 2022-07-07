import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChooseController extends GetxController {
  final _box = GetStorage();
  final _key = 'isTrue';

  bool getFromStorage() => _box.read(_key) ?? true;
  _saveInStorage(isTrue) => _box.write(_key, isTrue);

  change() {
    _saveInStorage(!getFromStorage());
  }

  @override
  void onInit() {
    super.onInit();
  }
}
