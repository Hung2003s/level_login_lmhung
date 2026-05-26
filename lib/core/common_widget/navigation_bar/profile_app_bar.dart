import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_color.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String? greetingText;
  final VoidCallback? onNotificationPressed;
  final bool hasNotification;
  final Color? backgroundColor;

  const ProfileAppBar({
    super.key,
    required this.username,
    this.greetingText,
    this.onNotificationPressed,
    this.hasNotification = true,
    this.backgroundColor,
  });

  String _getGreeting() {
    if (greetingText != null) return greetingText!;
    final hour = DateTime.now().hour;
    if (hour < 12) return 'greeting_morning'.tr;
    if (hour < 18) return 'greeting_afternoon'.tr;
    return 'greeting_evening'.tr;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.scaffoldBackgroundColor;
    return AppBar(
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.3),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Icon(
              Icons.person_rounded,
              color: theme.colorScheme.onPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getGreeting(),
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  username,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: onNotificationPressed,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.notifications_none_rounded,
                    color: theme.colorScheme.primary,
                    size: 22,
                  ),
                ),
                if (hasNotification)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: AppColor.error,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: bgColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(76);
}