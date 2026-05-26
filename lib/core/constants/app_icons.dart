import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;

class AppIcons {
  AppIcons._();

  static Widget icon({
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return _svg.SvgPicture.asset(
      'assets/icons/Icon.svg',
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  static Widget appLogo({
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return _svg.SvgPicture.asset(
      'assets/icons/app_logo.svg',
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  static Widget clearText({
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return _svg.SvgPicture.asset(
      'assets/icons/clear_text.svg',
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  static Widget headphone({
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return _svg.SvgPicture.asset(
      'assets/icons/headphone.svg',
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  static Widget hidePass({
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return _svg.SvgPicture.asset(
      'assets/icons/hide_pass.svg',
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  static Widget search({
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return _svg.SvgPicture.asset(
      'assets/icons/search.svg',
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  static Widget showPass({
    Key? key,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return _svg.SvgPicture.asset(
      'assets/icons/show_pass.svg',
      key: key,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }
}