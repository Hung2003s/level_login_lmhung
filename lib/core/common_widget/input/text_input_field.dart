import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_color.dart';
import '../../constants/app_icons.dart';
import '../../text_style/app_text_style.dart';

class TextInputFields extends StatefulWidget {
  const TextInputFields({
    super.key,
    this.title,
    this.titleTextStyle,
    required this.onChanged,
    this.onEditingComplete,
    this.onValidate,
    this.onSubmitted,
    this.onFocusChange,
    this.autofocus = false,
    this.maxLength,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.keyboardAppearance = Brightness.dark,
    this.textInputAction = TextInputAction.next,
    this.passwordType = false,
    this.textAlign = TextAlign.start,
    this.isShowClearButton = false,
    this.errorText,
    this.initialValue,
    this.onFocus,
    this.maxLine = 1,
    this.hintText,
    this.shouldShowError = true,
    this.contentPadding = const EdgeInsets.only(
      left: 16,
      right: 10,
      top: 12,
      bottom: 12,
    ),
    this.textStyle,
    this.textColor,
    this.description,
    this.readOnly = false,
    this.textDescriptionStyle,
    this.onControllerCreated,
    this.hintTextStyle,
    required this.controller,
    this.contentStyle,
    this.hasPassWord = true,
    this.filled,
    this.filledColor,
    this.defaultBorderColor,
    this.errorColor,
    this.focusedColor,
    this.iconColor,
    this.autoFillHint,
  });

  final String? title;
  final TextStyle? contentStyle;
  final TextStyle? titleTextStyle;
  final ValueChanged<String> onChanged;
  final VoidCallback? onEditingComplete;
  final void Function(String? value)? onValidate;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;
  final int? maxLength;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Brightness keyboardAppearance;
  final TextInputAction textInputAction;
  final bool passwordType;
  final TextAlign textAlign;
  final bool isShowClearButton;
  final bool hasPassWord;
  final String? errorText;
  final String? initialValue;
  final VoidCallback? onFocus;
  final int? maxLine;
  final String? hintText;
  final bool shouldShowError;
  final bool? filled;
  final Color? filledColor;
  final EdgeInsets contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final Color? textColor;
  final String? description;
  final bool readOnly;
  final TextStyle? textDescriptionStyle;
  final TextEditingController controller;
  final ValueChanged<TextEditingController>? onControllerCreated;

  final Color? defaultBorderColor;
  final Color? errorColor;
  final Color? focusedColor;
  final Color? iconColor;

  final Iterable<String>?  autoFillHint;


  @override
  State<TextInputFields> createState() => _TextInputFieldsState();
}

class _TextInputFieldsState extends State<TextInputFields> {
  late final ValueNotifier<bool> _obscureTextNotifier;
  late final ValueNotifier<bool> _hasTextNotifier;
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _obscureTextNotifier = ValueNotifier<bool>(true);
    _hasTextNotifier = ValueNotifier<bool>(widget.controller.text.isNotEmpty);
    focusNode = widget.focusNode ?? FocusNode();

    if (widget.initialValue != null && widget.controller.text.isEmpty) {
      widget.controller.text = widget.initialValue!;
    }

    widget.onControllerCreated?.call(widget.controller);

    widget.controller.addListener(_onTextChanged);

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        widget.onFocus?.call();
      } else {
        widget.onValidate?.call(widget.controller.text);
      }
      widget.onFocusChange?.call(focusNode.hasFocus);
    });
  }

  void _onTextChanged() {
    final bool hasText = widget.controller.text.isNotEmpty;
    if (_hasTextNotifier.value != hasText) {
      _hasTextNotifier.value = hasText;
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    widget.controller.removeListener(_onTextChanged);
    _obscureTextNotifier.dispose();
    _hasTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.title != null) ...[buildTitle(), const SizedBox(height: 10)],
        buildTextField(),
        if (widget.shouldShowError && widget.errorText != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              widget.errorText!,
              style: AppTextStyle.title3.copyWith(
                fontSize: 12,
                color: AppColor.error,
              ),
            ),
          ),
        ] else ...[
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget buildTitle() {
    final theme = Theme.of(context);
    return Text(
      widget.title!,
      style:
          widget.titleTextStyle ??
          TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
    );
  }

  Widget buildTextField() {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextNotifier,
      builder: (context, isObscure, child) {
        final theme = Theme.of(context);
        return TextFormField(
          autofillHints: widget.autoFillHint,
          controller: widget.controller,
          focusNode: focusNode,
          obscureText: widget.passwordType ? isObscure : false,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          textAlign: widget.textAlign,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onSubmitted,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autofocus,
          style:
              widget.textStyle?.copyWith(
                color: widget.textColor ?? theme.colorScheme.onSurface,
              ) ??
              theme.textTheme.bodyMedium,
          maxLines: widget.passwordType ? 1 : widget.maxLine,
          cursorColor: theme.colorScheme.primary,
          readOnly: widget.readOnly,
          keyboardAppearance: widget.keyboardAppearance,
          decoration: getInputDecoration(isObscure),
        );
      },
    );
  }

  InputDecoration getInputDecoration(bool isObscure) {
    final theme = Theme.of(context);
    final defaultBorderColor =
        widget.defaultBorderColor ??
        theme.colorScheme.onSurface.withValues(alpha: 0.3);
    final errorColor = widget.errorColor ?? theme.colorScheme.error;
    final focusedColor = widget.focusedColor ?? theme.colorScheme.primary;

    return InputDecoration(
      fillColor: widget.filledColor ?? theme.inputDecorationTheme.fillColor,
      filled: widget.filled ?? theme.inputDecorationTheme.filled,
      hintText: widget.hintText,
      hintStyle:
          widget.hintTextStyle ??
          theme.inputDecorationTheme.hintStyle?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
      contentPadding: widget.contentPadding,
      suffixIcon: ValueListenableBuilder<bool>(
        valueListenable: _hasTextNotifier,
        builder: (context, hasText, child) {
          if (!hasText) return const SizedBox.shrink();

          if (widget.passwordType) {
            return buildPasswordSuffixIcon(isObscure);
          }
          return buildSuffixIcon() ?? const SizedBox.shrink();
        },
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: 1,
          color: widget.errorText == null ? focusedColor : errorColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: errorColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: defaultBorderColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 2, color: focusedColor),
      ),
      counterText: '',
    );
  }

  Widget buildCleanButton() {
    final theme = Theme.of(context);
    final iconColor = widget.iconColor ?? theme.colorScheme.onSurface;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.controller.clear();
        widget.onChanged('');
        widget.onValidate?.call('');
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: AppIcons.clearText(color: iconColor),
      ),
    );
  }

  Widget? buildSuffixIcon() {
    if (!widget.isShowClearButton) return null;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: buildCleanButton(),
    );
  }

  Widget buildPasswordSuffixIcon(bool isObscure) {
    final theme = Theme.of(context);
    final iconColor = widget.iconColor ?? theme.colorScheme.onSurface;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.isShowClearButton) buildCleanButton(),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _obscureTextNotifier.value = !_obscureTextNotifier.value,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: isObscure
                ? AppIcons.showPass(width: 20, height: 20, color: iconColor)
                : AppIcons.hidePass(width: 20, height: 20, color: iconColor),
          ),
        ),
      ],
    );
  }
}
