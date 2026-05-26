import 'package:get/get.dart';
import 'package:level_login_lmhung/core/connectivity/connectivity_service.dart';
import 'package:level_login_lmhung/core/firestore/account_service.dart';
import 'package:level_login_lmhung/core/hive/local_account_service.dart';
import 'package:level_login_lmhung/feature/auth/data/repositories/account_repository_impl.dart';
import 'package:level_login_lmhung/feature/auth/domain/repositories/i_account_repository.dart';
import 'package:level_login_lmhung/feature/auth/domain/usecases/login_usecase.dart';
import 'package:level_login_lmhung/feature/auth/domain/usecases/register_usecase.dart';

class AppBinding extends Bindings {
  final LocalAccountService localAccountService;

  AppBinding({required this.localAccountService});

  @override
  void dependencies() {
    Get.put<LocalAccountService>(localAccountService);

    Get.put<AccountService>(AccountService());

    Get.put<ConnectivityService>(ConnectivityService());

    Get.put<IAccountRepository>(
      AccountRepositoryImpl(
        Get.find<AccountService>(),
        Get.find<LocalAccountService>(),
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