import 'package:flutter/material.dart';

import '../../../../core/common_widget/button/selected_widget.dart';

class FastFeatureCard extends StatelessWidget {
  final Color filledColor;
  final Color borderColor;
  final Widget icon;
  final String title;
  final Color textColor;
  final VoidCallback? onTap;
  final Color? rippleColor;

  const FastFeatureCard({
    super.key,
    required this.filledColor,
    required this.borderColor,
    required this.icon,
    required this.title,
    required this.textColor,
    this.onTap, this.rippleColor,
  });

  @override
  Widget build(BuildContext context) {
    return SelectedWidget(
      borderRadius: BorderRadius.circular(16),
      rippleColor: rippleColor,
      highlightColor: rippleColor,
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 3,
        child: Container(
          padding: EdgeInsets.symmetric(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: filledColor,
            border: Border.all(
              color: borderColor.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 4,),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
