import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:level_login_lmhung/feature/auth/presentation/register/register_controller.dart';
import 'package:level_login_lmhung/feature/auth/presentation/widget/input_field.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputField(
              keyboardType: TextInputType.number,
              controller: controller.taxNumberController,
              errorText: controller.taxNumberError.value,
              onChanged: controller.onTaxNumberChanged,
              hint: 'Ma so thue',
              title: 'Mã số thuế',
              isShowClearButton: true,
            ),
            InputField(
              controller: controller.usernameController,
              errorText: controller.usernameError.value,
              onChanged: controller.onUsernameChanged,
              hint: 'Tài khoản',
              title: 'Tài khoản',
              isShowClearButton: true,
            ),
            InputField(
              controller: controller.passwordController,
              errorText: controller.passwordError.value,
              isPassword: true,
              onChanged: controller.onPasswordChanged,
              hint: 'Mật khẩu',
              title: 'Mật khẩu',
            ),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.register,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Đăng ký'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
