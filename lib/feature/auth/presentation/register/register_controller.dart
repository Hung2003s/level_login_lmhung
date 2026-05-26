import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:level_login_lmhung/feature/auth/domain/usecases/register_usecase.dart';

class RegisterController extends GetxController {
  final RegisterUseCase _registerUseCase;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final taxNumberController = TextEditingController();

  final usernameError = Rxn<String>();
  final passwordError = Rxn<String>();
  final taxNumberError = Rxn<String>();
  final showError = false.obs;
  final isLoading = false.obs;

  RegisterController(this._registerUseCase);

  void validateTaxNumber(String value) {
    if (value.isEmpty) {
      taxNumberError.value = 'Vui lòng nhập mã số thuế';
    } else if (value.length < 9 || value.length > 14) {
      taxNumberError.value = 'Mã số thuế không hợp lệ';
    } else {
      taxNumberError.value = null;
    }
  }

  void validateUsername(String value) {
    if (value.isEmpty) {
      usernameError.value = 'Vui lòng nhập tài khoản';
    } else if (value.length < 3) {
      usernameError.value = 'Tài khoản phải có ít nhất 3 ký tự';
    } else {
      usernameError.value = null;
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = 'Vui lòng nhập mật khẩu';
    } else if (value.length < 6) {
      passwordError.value = 'Mật khẩu phải có ít nhất 6 ký tự';
    } else {
      passwordError.value = null;
    }
  }

  void onTaxNumberChanged(String value) {
    if (showError.value) {
      validateTaxNumber(value);
    }
  }

  void onUsernameChanged(String value) {
    if (showError.value) {
      validateUsername(value);
    }
  }

  void onPasswordChanged(String value) {
    if (showError.value) {
      validatePassword(value);
    }
  }

  Future<void> register() async {
    showError.value = true;

    validateTaxNumber(taxNumberController.text);
    validateUsername(usernameController.text);
    validatePassword(passwordController.text);

    if (taxNumberError.value != null ||
        usernameError.value != null ||
        passwordError.value != null) {
      return;
    }

    isLoading.value = true;

    try {
      // Check if username already exists
      final isTaken = await _registerUseCase.isUsernameTaken(
        usernameController.text,
      );

      if (isTaken) {
        Get.snackbar(
          'Lỗi đăng ký',
          'Tài khoản đã tồn tại',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
        );
        return;
      }

      await _registerUseCase.execute(
        taxIdOrId: taxNumberController.text,
        username: usernameController.text,
        password: passwordController.text,
      );

      Get.snackbar(
        'Thành công',
        'Đăng ký tài khoản thành công',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
      );

      Get.offAllNamed('/login');
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

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    taxNumberController.dispose();
    super.onClose();
  }
}