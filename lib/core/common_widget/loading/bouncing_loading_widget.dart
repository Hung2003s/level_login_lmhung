import 'package:flutter/material.dart';

class BouncingLoadingWidget extends StatefulWidget {
  final Color color;
  const BouncingLoadingWidget({super.key, required this.color});

  @override
  State<BouncingLoadingWidget> createState() => _BouncingLoadingWidgetState();
}

class _BouncingLoadingWidgetState extends State<BouncingLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Danh sách các animation lệch nhau cho 3 dấu chấm
  final List<Animation<double>> _animations = [];

  // Khoảng cách nhảy lên (Pixel)
  final double _bounceHeight = 15.0;

  @override
  void initState() { // initState
    super.initState();

    _controller = AnimationController(
      // Thời gian cho một chu kỳ nhảy của cả 3 chấm
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(); // Lặp lại vô tận


    for (int i = 0; i < 3; i++) {

      _animations.add(
        TweenSequence<double>([
          // 1. Nhảy lên
          TweenSequenceItem(
            tween: Tween<double>(begin: 0.0, end: -_bounceHeight)
                .chain(CurveTween(curve: Curves.easeOutCubic)),
            weight: 50, // Chiếm 50% thời gian của interval này
          ),
          // 2. Rơi xuống lại
          TweenSequenceItem(
            tween: Tween<double>(begin: -_bounceHeight, end: 0.0)
                .chain(CurveTween(curve: Curves.easeInCubic)),
            weight: 50, // Chiếm 50% thời gian của interval này
          ),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              // Chia interval so le nhau: 0.0-0.4, 0.2-0.6, 0.4-0.8
              (i * 0.2),
              (i * 0.2 + 0.4) > 1.0 ? 1.0 : (i * 0.2 + 0.4),
              curve: Curves.linear,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              // Sử dụng animation lệch nhau để thay đổi vị trí Y
              offset: Offset(0.0, _animations[index].value),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: widget.color, // Màu cam giống ảnh
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}