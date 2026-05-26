import 'package:level_login_lmhung/core/firestore/account_service.dart';
import 'package:level_login_lmhung/core/utils/password_hasher.dart';

import '../../feature/auth/data/models/account_model.dart';

/// Run this function once to seed demo data into Firestore
/// Cau truc collection "account":
///
///   taxIdOrId: "0105987432-098"   (MST hoac CCCD)
///   username: "demo"
///   passwordHash: "<hash>" (PBKDF2-HMAC-SHA256 derived key, base64)
///   salt: "<random-base64>"
///   fullName: "Demo User"
///   enabled: true
///   updatedAt: 1690000000
///
Future<void> seedFirestoreData() async {
  try {
    // Only proceed if we have Firestore
    final accountService = AccountService();

    // Check if demo account already exists
    final existing = await accountService.getAccountByUsername('demo');
    if (existing != null) {
      print('✅ Demo account already exists (id: ${existing.id})');
      return;
    }

    // Create demo account using PBKDF2-HMAC-SHA256
    print('🔐 Hashing password with PBKDF2-HMAC-SHA256 (150k iterations)...');
    final demoHash = await PasswordHasher.hashPassword('password');

    final demoAccount = AccountModel(
      taxIdOrId: '0105987432-098',
      username: 'demo',
      passwordHash: demoHash.hash,
      salt: demoHash.salt,
      fullName: 'Demo User',
      enabled: true,
      updatedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );

    final docId = await accountService.createAccount(demoAccount);
    print('✅ Demo account created successfully!');
    print('   Document ID: $docId');
    print('   Username: demo');
    print('   Password: password (PBKDF2-HMAC-SHA256 hashed)');
    print('   Iterations: ${demoHash.iterations}');

    // Create a second test account
    final testHash = await PasswordHasher.hashPassword('password');

    final testAccount = AccountModel(
      taxIdOrId: '079123456789',
      username: 'testuser',
      passwordHash: testHash.hash,
      salt: testHash.salt,
      fullName: 'Test User',
      enabled: true,
      updatedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );

    final testDocId = await accountService.createAccount(testAccount);
    print('✅ Test account created successfully!');
    print('   Document ID: $testDocId');
    print('   Username: testuser');
    print('   Password: password (PBKDF2-HMAC-SHA256 hashed)');
  } catch (e) {
    print('❌ Error seeding data: $e');
  }
}