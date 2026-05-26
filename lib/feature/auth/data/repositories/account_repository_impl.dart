import 'package:level_login_lmhung/core/services/connectivity_service.dart';
import 'package:level_login_lmhung/feature/auth/data/datasources/account_local_source.dart';
import 'package:level_login_lmhung/feature/auth/data/datasources/account_remote_source.dart';
import 'package:level_login_lmhung/feature/auth/data/models/account_model.dart';
import 'package:level_login_lmhung/feature/auth/domain/entities/account.dart';
import 'package:level_login_lmhung/feature/auth/domain/repositories/i_account_repository.dart';

class AccountRepositoryImpl implements IAccountRepository {
  final AccountRemoteSource _remoteSource;
  final AccountLocalSource _localSource;
  final ConnectivityService _connectivityService;

  AccountRepositoryImpl(
    this._remoteSource,
    this._localSource,
    this._connectivityService,
  );

  Future<bool> get _isOnline => _connectivityService.isOnline();

  @override
  Future<Account?> getAccountByUsername(String username) async {
    // Try local first (fast)
    final localModel = _localSource.getAccountByUsername(username);
    if (localModel != null) return localModel.toEntity();

    // If not found locally, try Firebase if online
    if (await _isOnline) {
      final firebaseModel = await _remoteSource.getAccountByUsername(username);
      if (firebaseModel != null) {
        // Sync to local for offline access
        await _localSource.createAccount(firebaseModel);
        return firebaseModel.toEntity();
      }
    }

    return null;
  }

  @override
  Future<bool> isUsernameTaken(String username) async {
    // Check local first (fast)
    if (_localSource.isUsernameTaken(username)) return true;

    // Then check Firebase if online
    if (await _isOnline) {
      return await _remoteSource.isUsernameTaken(username);
    }

    return false;
  }

  @override
  Future<void> createAccount(Account account) async {
    final model = AccountModel.fromEntity(account);

    if (await _isOnline) {
      // Save to Firebase
      final firebaseId = await _remoteSource.createAccount(model);

      // Save to local with same ID
      final localModel = AccountModel(
        id: firebaseId,
        taxIdOrId: model.taxIdOrId,
        username: model.username,
        passwordHash: model.passwordHash,
        salt: model.salt,
        fullName: model.fullName,
        enabled: model.enabled,
        updatedAt: model.updatedAt,
      );
      await _localSource.createAccount(localModel);
    } else {
      // Save to local only when offline
      await _localSource.createAccount(model);
    }
  }
}