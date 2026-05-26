import 'package:level_login_lmhung/feature/auth/domain/entities/account.dart';

abstract class IAccountRepository {
  Future<Account?> getAccountByUsername(String username);
  Future<bool> isUsernameTaken(String username);
  Future<void> createAccount(Account account);
}