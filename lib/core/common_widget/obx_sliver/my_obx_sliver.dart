import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class MyObxSliver extends ObxWidget {
  final Widget Function() builder;

  const MyObxSliver({super.key, required this.builder});

  @override
  Widget build() => builder();
}