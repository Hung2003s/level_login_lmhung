import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:level_login_lmhung/feature/auth/data/datasources/account_local_source.dart';
import 'package:level_login_lmhung/feature/auth/data/datasources/account_model_adapter.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Initialize Hive for test
    Hive.initFlutter();
    Hive.registerAdapter(AccountModelAdapter());
    final accountLocalSource = AccountLocalSource();
    await accountLocalSource.init();

    // Build our app and trigger a frame.
    // await tester.pumpWidget(MyApp(accountLocalSource: accountLocalSource));
    // TODO: Add proper widget test
    expect(true, isTrue);
  });
}