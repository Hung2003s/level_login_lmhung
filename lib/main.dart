import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:level_login_lmhung/core/hive/account_model_adapter.dart';
import 'package:level_login_lmhung/core/hive/local_account_service.dart';
import 'package:level_login_lmhung/core/utils/app_theme.dart';

import 'core/di/app_binding.dart';
import 'navigation/app_routers.dart';
import 'navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(AccountModelAdapter());

  // Initialize LocalAccountService
  final localAccountService = LocalAccountService();
  await localAccountService.init();

  runApp(MyApp(localAccountService: localAccountService));
}

class MyApp extends StatelessWidget {
  final LocalAccountService localAccountService;

  const MyApp({super.key, required this.localAccountService});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      initialRoute: Routes.login,
      getPages: AppRouter.pages,
      initialBinding: AppBinding(localAccountService: localAccountService),
    );
  }
}