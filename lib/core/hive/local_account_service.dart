import 'package:hive/hive.dart';
import 'package:level_login_lmhung/feature/auth/data/models/account_model.dart';

class LocalAccountService {
  static const String _boxName = 'accounts';

  late Box<AccountModel> _box;

  /// Initialize the Hive box for accounts
  Future<void> init() async {
    _box = await Hive.openBox<AccountModel>(_boxName);
  }

  /// Create a new account
  Future<String> createAccount(AccountModel account) async {
    final id = account.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    final newAccount = AccountModel(
      id: id,
      taxIdOrId: account.taxIdOrId,
      username: account.username,
      passwordHash: account.passwordHash,
      salt: account.salt,
      fullName: account.fullName,
      enabled: account.enabled,
      updatedAt: account.updatedAt,
    );
    await _box.put(id, newAccount);
    return id;
  }

  /// Get account by ID
  AccountModel? getAccountById(String id) {
    return _box.get(id);
  }

  /// Get account by username
  AccountModel? getAccountByUsername(String username) {
    final accounts = _box.values.where(
      (account) => account.username == username,
    );
    return accounts.isNotEmpty ? accounts.first : null;
  }

  /// Get account by taxIdOrId (MST hoặc CCCD)
  AccountModel? getAccountByTaxId(String taxIdOrId) {
    final accounts = _box.values.where(
      (account) => account.taxIdOrId == taxIdOrId,
    );
    return accounts.isNotEmpty ? accounts.first : null;
  }

  /// Update an existing account
  Future<void> updateAccount(String id, AccountModel account) async {
    await _box.put(id, account);
  }

  /// Delete an account
  Future<void> deleteAccount(String id) async {
    await _box.delete(id);
  }

  /// Check if username already exists
  bool isUsernameTaken(String username) {
    return _box.values.any((account) => account.username == username);
  }

  /// Get all enabled accounts
  List<AccountModel> getEnabledAccounts() {
    return _box.values.where((account) => account.enabled).toList();
  }

  /// Get all accounts
  List<AccountModel> getAllAccounts() {
    return _box.values.toList();
  }

  /// Clear all accounts
  Future<void> clearAll() async {
    await _box.clear();
  }
}