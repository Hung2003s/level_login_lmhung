import 'package:level_login_lmhung/core/utils/password_hasher.dart';
import 'package:level_login_lmhung/feature/auth/domain/entities/account.dart';
import 'package:level_login_lmhung/feature/auth/domain/repositories/i_account_repository.dart';

class RegisterUseCase {
  final IAccountRepository repository;

  RegisterUseCase(this.repository);

  Future<bool> isUsernameTaken(String username) async {
    return await repository.isUsernameTaken(username);
  }

  Future<void> execute({
    required String taxIdOrId,
    required String username,
    required String password,
  }) async {
    final hashed = await PasswordHasher.hashPassword(password);

    final account = Account(
      taxIdOrId: taxIdOrId,
      username: username,
      passwordHash: hashed.hash,
      salt: hashed.salt,
      fullName: 'demo user',
      enabled: false,
      updatedAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );

    await repository.createAccount(account);
  }
}