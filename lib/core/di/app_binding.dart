import 'package:get/get.dart';
import 'package:level_login_lmhung/core/services/connectivity_service.dart';
import 'package:level_login_lmhung/feature/auth/data/datasources/account_local_source.dart';
import 'package:level_login_lmhung/feature/auth/data/datasources/account_remote_source.dart';
import 'package:level_login_lmhung/feature/auth/data/repositories/account_repository_impl.dart';
import 'package:level_login_lmhung/feature/auth/domain/repositories/i_account_repository.dart';
import 'package:level_login_lmhung/feature/auth/domain/usecases/login_usecase.dart';
import 'package:level_login_lmhung/feature/auth/domain/usecases/register_usecase.dart';

class AppBinding extends Bindings {
  final AccountLocalSource accountLocalSource;

  AppBinding({required this.accountLocalSource});

  @override
  void dependencies() {
    // Core - remote
    Get.put<AccountRemoteSource>(AccountRemoteSource());

    // Core - local
    Get.put<AccountLocalSource>(accountLocalSource);

    // Core - services
    Get.put<ConnectivityService>(ConnectivityService());

    // Repository (uses remote + local + services)
    Get.put<IAccountRepository>(
      AccountRepositoryImpl(
        Get.find<AccountRemoteSource>(),
        Get.find<AccountLocalSource>(),
        Get.find<ConnectivityService>(),
      ),
    );

    // Use Cases
    Get.put<LoginUseCase>(
      LoginUseCase(Get.find<IAccountRepository>()),
    );
    Get.put<RegisterUseCase>(
      RegisterUseCase(Get.find<IAccountRepository>()),
    );
  }
}