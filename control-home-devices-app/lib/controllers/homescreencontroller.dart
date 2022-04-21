import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  int index =-1;

  void setIndex(int index) {
    this.index = index;
    update();
  }
}
