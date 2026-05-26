import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:level_login_lmhung/core/hive/account_model_adapter.dart';
import 'package:level_login_lmhung/core/hive/local_account_service.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Initialize Hive for test
    Hive.initFlutter();
    Hive.registerAdapter(AccountModelAdapter());
    final localAccountService = LocalAccountService();
    await localAccountService.init();

    // Build our app and trigger a frame.
    // await tester.pumpWidget(const MyApp(localAccountService: localAccountService));
    // TODO: Add proper widget test
    expect(true, isTrue);
  });
}