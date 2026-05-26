import 'package:get/get.dart';
import 'package:level_login_lmhung/feature/auth/presentation/login/login_bingding.dart';
import 'package:level_login_lmhung/feature/auth/presentation/login/login_page.dart';
import 'package:level_login_lmhung/feature/auth/presentation/register/register_binding.dart';
import 'package:level_login_lmhung/feature/auth/presentation/register/register_page.dart';
import 'package:level_login_lmhung/feature/home/presentation/home_bindings.dart';
import 'package:level_login_lmhung/feature/home/presentation/home_page.dart';

import 'routes.dart';

class AppRouter {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBingding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
  ];
}
