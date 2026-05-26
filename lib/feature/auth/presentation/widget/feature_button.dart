import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widget/button/selected_widget.dart';

class FeatureButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Widget icons;

  const FeatureButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 2.2,
        child: Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SelectedWidget(
            backgroundColor: Colors.white,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icons,
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
