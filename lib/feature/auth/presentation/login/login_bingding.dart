import 'package:get/get.dart';

import 'login_controller.dart';

class LoginBingding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(Get.find()));
  }

}