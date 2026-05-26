import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common_widget/base_view/base_view.dart';
import '../../../../core/common_widget/button/selected_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_image.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../navigation/routes.dart';
import '../widget/feature_button.dart';
import '../widget/input_field.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      tapOutsideToDismissKeyboard: true,
      resizeToAvoidBottomInset: false,
      buildBody: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [loginContent(), loginFooter()],
        ),
      ),
    );
  }

  Column loginContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AppImage.logo(),
        const SizedBox(height: 24),
        Obx(
          () => InputField(
            keyboardType: TextInputType.number,
            isShowClearButton: true,
            controller: controller.taxNumberController,
            onChanged: controller.onTaxNumberChanged,
            hint: 'Vui long nhap ma so thue',
            title: 'Ma so thue',
            errorText: controller.showError.value ? controller.taxNumberErrorText : null,
          ),
        ),
        const SizedBox(height: 4),
        Obx(
          () => InputField(
            isShowClearButton: true,
            controller: controller.usernameController,
            onChanged: controller.onUsernameChanged,
            hint: 'Tài khoản',
            title: 'Tài khoản',
            errorText: controller.showError.value ? controller.usernameErrorText : null,
          ),
        ),
        const SizedBox(height: 4),
        Obx(
          () => InputField(
            isPassword: true,
            controller: controller.passwordController,
            onChanged: controller.onPasswordChanged,
            hint: 'Mật khẩu',
            title: 'Mật khẩu',
            textInputAction: TextInputAction.done,
            errorText: controller.showError.value ? controller.passwordErrorText : null,
            onSubmitted: (value) {},
          ),
        ),
        const SizedBox(height: 24),
        SelectedWidget(
          onTap: () => controller.login(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Đăng nhập',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SelectedWidget(
          onTap: () => controller.navigateToRegister(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Đăng ký',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row loginFooter() {
    return Row(
      children: [
        FeatureButton(
          onTap: () {},
          title: 'Trợ giúp',
          icons: AppIcons.headphone(),
        ),
        const SizedBox(width: 8),
        FeatureButton(
          onTap: () {},
          title: 'Group',
          icons: AppIcons.icon(),
        ),
        const SizedBox(width: 8),
        FeatureButton(
          onTap: () {},
          title: 'Tra cứu',
          icons: AppIcons.search(),
        ),
      ],
    );
  }
}