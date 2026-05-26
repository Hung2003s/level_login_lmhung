import 'package:get/get.dart';
import 'package:level_login_lmhung/feature/auth/presentation/register/register_controller.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut<RegisterController>(() => RegisterController(Get.find()));
  }

}