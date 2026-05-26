class Constants {
  static const int connectTimeout = 30;
  static const int limit = 40;
  static const int offset = 0;

  static const commonError = 'Có lỗi xảy ra, vui lòng thử lại.';
  static const noInternet = 'Không có kết nối mạng. Vui lòng thử lại sau.';
  static const timeoutError = 'Không thể kết nối tới server';

  /// MST: 10 chữ số, tuỳ chọn hậu tố -XXX (3 số) → 10 hoặc 14 ký tự
  /// CCCD: 12 chữ số
  static final taxNumberRule = RegExp(r'^(\d{10}(-\d{3})?|\d{12})$');
}
