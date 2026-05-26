import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/common_widget/input/text_input_field.dart';
import '../../../../core/constants/app_color.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool? isShowClearButton;
  final String hint;
  final String title;
  final bool? isPassword;
  final TextInputType? keyboardType;
  final String? errorText;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;

  const InputField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.isShowClearButton,
    required this.hint,
    required this.title,
    this.isPassword,
    this.keyboardType = TextInputType.text,
    this.errorText, this.onSubmitted, this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColor.gray,
          ),
        ),
        const SizedBox(height: 8),
        TextInputFields(
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600,
              color: Colors.black
          ),
          onSubmitted: onSubmitted,
          textInputAction: textInputAction ?? TextInputAction.next,
          keyboardType: keyboardType,
          passwordType: isPassword ?? false,
          onChanged: onChanged,
          controller: controller,
          isShowClearButton: isShowClearButton ?? false,
          hintText: hint,
          hintTextStyle: TextStyle(
            color: AppColor.grayLight3,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          errorText: errorText,
        ),
      ],
    );
  }
}
