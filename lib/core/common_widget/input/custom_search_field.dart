import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSortPressed; // Sự kiện khi bấm nút Sort bên phải
  final bool showSortButton; // Có muốn hiển thị nút Sort hay không
  final InputBorder? focusColor;
  const CustomSearchField({
    super.key,
    this.controller,
    this.hintText = 'Tìm kiếm...',
    this.onChanged,
    this.onSortPressed,
    this.showSortButton = true, this.focusColor, // Mặc định luôn hiện nút Sort như trong ảnh
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. Ô nhập liệu Tìm kiếm (Chiếm phần lớn hàng ngang)
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 15),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              // Kính lúp tìm kiếm ở đầu
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                size: 22,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
              // Nền theo theme
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              // Trạng thái viền bình thường
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), // Bo góc 16 mềm mại
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              // Trạng thái viền khi nhấn chọn gõ chữ
              focusedBorder: focusColor ?? OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),

        // Nếu bật thuộc tính hiển thị nút Sort thì mới vẽ khối code này
        if (showSortButton) ...[
          const SizedBox(width: 12), // Khoảng cách giữa ô tìm kiếm và nút sort
          // 2. Nút Sắp xếp (Sort Button) vuông bo góc bằng chiều cao TextField
          GestureDetector(
            onTap: onSortPressed,
            child: Container(
              width: 50,
              height: 50,
              // Chiều cao 50 khớp hoàn toàn với độ dày của TextField trên
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.swap_vert_rounded,
                // Icon mũi tên lên xuống đảo chiều giống ảnh
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                size: 24,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
