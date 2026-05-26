import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:level_login_lmhung/core/utils/app_theme.dart';
import 'package:level_login_lmhung/feature/auth/data/datasources/account_local_source.dart';
import 'package:level_login_lmhung/feature/auth/data/datasources/account_model_adapter.dart';

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

  // Initialize AccountLocalSource
  final accountLocalSource = AccountLocalSource();
  await accountLocalSource.init();

  runApp(MyApp(accountLocalSource: accountLocalSource));
}

class MyApp extends StatelessWidget {
  final AccountLocalSource accountLocalSource;

  const MyApp({super.key, required this.accountLocalSource});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      initialRoute: Routes.login,
      getPages: AppRouter.pages,
      initialBinding: AppBinding(accountLocalSource: accountLocalSource),
    );
  }
}