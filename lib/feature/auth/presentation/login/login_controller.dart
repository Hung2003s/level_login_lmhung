import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:level_login_lmhung/core/constants/constants.dart';
import 'package:level_login_lmhung/feature/auth/domain/usecases/login_usecase.dart';

import '../../../../navigation/routes.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final taxNumberController = TextEditingController();

  final usernameError = Rxn<String>();
  final passwordError = Rxn<String>();
  final taxNumberError = Rxn<String>();
  final showError = false.obs;
  final isLoading = false.obs;

  LoginController(this._loginUseCase);

  String? _validateTaxNumber(String value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập mã số thuế/CCCD';
    }
    if (!Constants.taxNumberRule.hasMatch(value)) {
      return 'MST (10 số + tuỳ chọn -XXX) hoặc CCCD (12 số)';
    }
    return null;
  }

  String? _validateUsername(String value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập tài khoản';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    if (value.length > 50) {
      return 'Mật khẩu tối đa 50 ký tự';
    }
    return null;
  }

  /// Trả về error text nếu `showError == true`, ngược lại trả về `null`
  String? get taxNumberErrorText {
    if (!showError.value) return null;
    return taxNumberError.value;
  }

  String? get usernameErrorText {
    if (!showError.value) return null;
    return usernameError.value;
  }

  String? get passwordErrorText {
    if (!showError.value) return null;
    return passwordError.value;
  }

  void onTaxNumberChanged(String value) {
    taxNumberError.value = _validateTaxNumber(value);
  }

  void onUsernameChanged(String value) {
    usernameError.value = _validateUsername(value);
  }

  void onPasswordChanged(String value) {
    passwordError.value = _validatePassword(value);
  }

  Future<void> login() async {
    showError.value = true;

    taxNumberError.value = _validateTaxNumber(taxNumberController.text);
    usernameError.value = _validateUsername(usernameController.text);
    passwordError.value = _validatePassword(passwordController.text);

    if (taxNumberError.value != null ||
        usernameError.value != null ||
        passwordError.value != null) {
      return;
    }

    isLoading.value = true;

    try {
      final account = await _loginUseCase.execute(
        usernameController.text,
        passwordController.text,
      );

      if (account == null) {
        Get.snackbar(
          'Lỗi đăng nhập',
          'Tài khoản hoặc mật khẩu không đúng',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
        );
        return;
      }

      Get.snackbar(
        'Thành công',
        'Đăng nhập thành công',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
      );

      Get.offAllNamed(Routes.home);
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToRegister() {
    Get.toNamed(Routes.register);
  }



  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    taxNumberController.dispose();
    super.onClose();
  }


}