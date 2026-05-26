import 'package:flutter/material.dart';


class BaseView extends StatelessWidget {
  const BaseView({
    super.key,
    required this.buildBody,
    this.buildAppBar,
    this.resizeToAvoidBottomInset = true,
    this.tapOutsideToDismissKeyboard = false,
    this.extendBodyBehindAppBar = false,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.canPop = true,
    this.background,
    this.backgroundColor,
    this.buildBottomAppBar,
    this.floatingActionButton,
  });
  /// Mặc định là `true` để tránh việc bàn phím đẩy giao diện lên.
  final bool resizeToAvoidBottomInset;
  /// Tự động đóng bàn phím khi người dùng chạm ra bên ngoài.
  /// Nếu là `true`, toàn bộ `body` sẽ được bọc trong `GestureDetector`.
  final bool tapOutsideToDismissKeyboard;
  /// Cho phép `body` của màn hình có thể hiển thị phía sau `AppBar`.
  final bool extendBodyBehindAppBar;
  /// Áp dụng `SafeArea` cho phần đỉnh màn hình (tránh tai thỏ, camera).
  final bool safeAreaTop;
  /// Áp dụng `SafeArea` cho phần đáy màn hình .
  final bool safeAreaBottom;
  /// Kiểm soát việc người dùng có thể quay lại màn hình trước đó hay không.
  /// Nếu là `false`, màn hình sẽ được bọc trong `WillPopScope`.
  final bool canPop;
  final Widget buildBody;
  final PreferredSizeWidget? buildAppBar;
  final Widget? buildBottomAppBar;
  final Widget? background;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  void dismissKeyboard(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
  @override
  Widget build(BuildContext context) {
    // Widget body chính, được bọc trong một Column
    return Scaffold(
      floatingActionButton: floatingActionButton,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar,
      bottomNavigationBar: buildBottomAppBar,
      body: Stack(
        children: [
          Positioned(child: _buildBackground(context)),
          SafeArea(
            // top: extendBodyBehindAppBar ? false : safeAreaTop,
            bottom: safeAreaBottom,
            child: PopScope(
              canPop: canPop,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (tapOutsideToDismissKeyboard) {
                    dismissKeyboard(context);
                  }
                },
                child: buildBody,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    if (backgroundColor != null) return Container(color: backgroundColor);
    return background ?? Container();
  }
}