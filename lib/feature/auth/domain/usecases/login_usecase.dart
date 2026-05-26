import 'package:level_login_lmhung/core/utils/password_hasher.dart';
import 'package:level_login_lmhung/feature/auth/domain/entities/account.dart';
import 'package:level_login_lmhung/feature/auth/domain/repositories/i_account_repository.dart';

class LoginUseCase {
  final IAccountRepository repository;

  LoginUseCase(this.repository);

  Future<Account?> execute(String username, String password) async {
    final account = await repository.getAccountByUsername(username);
    if (account == null) return null;

    final isValid = await PasswordHasher.verifyPassword(
      password: password,
      storedHash: account.passwordHash,
      storedSalt: account.salt,
    );

    if (!isValid) return null;

    return account;
  }
}