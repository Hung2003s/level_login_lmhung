import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:level_login_lmhung/feature/auth/data/models/account_model.dart';

class AccountService {
  final CollectionReference _accounts =
      FirebaseFirestore.instance.collection('account');

  /// Create a new account document
  Future<String> createAccount(AccountModel account) async {
    final docRef = await _accounts.add(account.toFirestore());
    return docRef.id;
  }

  /// Get account by document ID
  Future<AccountModel?> getAccountById(String id) async {
    final doc = await _accounts.doc(id).get();
    if (!doc.exists) return null;
    return AccountModel.fromFirestore(doc);
  }

  /// Get account by username
  Future<AccountModel?> getAccountByUsername(String username) async {
    final query = await _accounts
        .where('username', isEqualTo: username)
        .limit(1)
        .get();
    if (query.docs.isEmpty) return null;
    return AccountModel.fromFirestore(query.docs.first);
  }

  /// Get account by taxIdOrId (MST hoặc CCCD)
  Future<AccountModel?> getAccountByTaxId(String taxIdOrId) async {
    final query = await _accounts
        .where('taxIdOrId', isEqualTo: taxIdOrId)
        .limit(1)
        .get();
    if (query.docs.isEmpty) return null;
    return AccountModel.fromFirestore(query.docs.first);
  }

  /// Update an existing account
  Future<void> updateAccount(String id, AccountModel account) async {
    await _accounts.doc(id).update(account.toFirestore());
  }

  /// Delete an account
  Future<void> deleteAccount(String id) async {
    await _accounts.doc(id).delete();
  }

  /// Check if username already exists
  Future<bool> isUsernameTaken(String username) async {
    final query = await _accounts
        .where('username', isEqualTo: username)
        .limit(1)
        .get();
    return query.docs.isNotEmpty;
  }

  /// Get all enabled accounts
  Future<List<AccountModel>> getEnabledAccounts() async {
    final query = await _accounts.where('enabled', isEqualTo: true).get();
    return query.docs.map((doc) => AccountModel.fromFirestore(doc)).toList();
  }
}