import 'package:flutter/material.dart';

class SecondHeader extends SliverPersistentHeaderDelegate {

  final Widget child;
  final double minHeight;
  final double maxHeight;

  const SecondHeader({required this.child, required this.minHeight, required this.maxHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild( SecondHeader oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}