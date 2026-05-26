# level_login_lmhung

Flutter project sử dụng **Clean Architecture** + **GetX** + **Firebase** + **Hive** với hỗ trợ offline login.

## Architecture

Project được tổ chức theo mô hình **core-feature** kết hợp **Clean Architecture**:

- **core/**: Thành phần dùng chung cho toàn bộ ứng dụng (widgets, constants, services, DI)
- **feature/**: Mỗi feature là một module độc lập, chia làm 3 layer:
  - **data**: Data sources (remote/local), models, repositories implementation
  - **domain**: Entities, repositories interfaces, use cases
  - **presentation**: Controllers (GetX), pages, widgets

## Cấu trúc thư mục

```
lib/
├── core/                                  # Thành phần dùng chung
│   ├── common_widget/                     # Widget tái sử dụng
│   │   ├── base_view/                     # Base scaffold view
│   │   ├── button/                        # Các loại button
│   │   ├── input/                         # Text input fields
│   │   ├── loading/                       # Loading indicators
│   │   ├── navigation_bar/               # Custom navigation bars
│   │   ├── obx_sliver/                   # Obx sliver widgets
│   │   └── pined_header/                 # Pinned header widget
│   ├── config/
│   ├── constants/                         # Hằng số
│   │   ├── app_color.dart
│   │   ├── app_icons.dart
│   │   ├── app_image.dart
│   │   ├── constants.dart
│   │   └── string_constant.dart
│   ├── di/                                # Dependency Injection
│   │   └── app_binding.dart
│   ├── services/                          # Service dùng chung
│   │   └── connectivity_service.dart      # Kiểm tra online/offline
│   ├── text_style/                        # Text styles
│   │   └── app_text_style.dart
│   └── utils/                             # Tiện ích
│       ├── app_theme.dart
│       └── password_hasher.dart
│
├── feature/                               # Các feature modules
│   └── auth/                              # Feature: Authentication
│       ├── data/                          # Data layer
│       │   ├── datasources/               # Data sources
│       │   │   ├── account_local_source.dart    # Hive local storage
│       │   │   ├── account_model_adapter.dart   # Hive TypeAdapter
│       │   │   ├── account_remote_source.dart   # Firebase Firestore
│       │   │   └── seed_data.dart               # Seed dữ liệu mẫu
│       │   ├── models/                    # Models (DTOs)
│       │   │   └── account_model.dart
│       │   └── repositories/              # Repository implementation
│       │       └── account_repository_impl.dart
│       ├── domain/                        # Domain layer
│       │   ├── entities/                  # Entities
│       │   │   └── account.dart
│       │   ├── repositories/              # Repository interfaces
│       │   │   └── i_account_repository.dart
│       │   └── usecases/                  # Use cases
│       │       ├── login_usecase.dart
│       │       └── register_usecase.dart
│       └── presentation/                  # Presentation layer
│           ├── login/
│           │   ├── login_controller.dart  # GetX Controller
│           │   └── login_page.dart
│           ├── register/
│           │   ├── register_controller.dart
│           │   └── register_page.dart
│           └── widget/                    # Feature-specific widgets
│               ├── feature_button.dart
│               └── input_field.dart
│
├── navigation/                            # Navigation & Routes
│   ├── app_routers.dart
│   └── routes.dart
│
├── gen/                                   # Generated code (flutter_gen)
├── main.dart                              # Entry point
└── ...
```

## Nguyên tắc

| Layer | Phụ thuộc | Mô tả |
|-------|-----------|-------|
| **Presentation** | Domain | Chỉ gọi Use Cases, không biết đến Data layer |
| **Domain** | (none) | Business logic thuần, không phụ thuộc framework |
| **Data** | Domain | Implement repository interfaces, chứa data sources |

- **core/** chỉ chứa thành phần dùng chung qua nhiều feature
- **Mỗi feature** tự quản lý data sources, models, repositories, domain logic, presentation riêng

## Offline Login

- **Online**: Firebase Firestore + sync dữ liệu xuống Hive local
- **Offline**: Kiểm tra thông tin đăng nhập từ Hive local, không cần Internet
- **ConnectivityService**: Kiểm tra trạng thái mạng trước khi gọi Firebase

## Công nghệ

- [Flutter](https://flutter.dev/) & [Dart](https://dart.dev/)
- [GetX](https://pub.dev/packages/get) - State management, DI, Navigation
- [Firebase Firestore](https://firebase.flutter.dev/) - Cloud database
- [Hive](https://pub.dev/packages/hive) - Local storage
- [Connectivity Plus](https://pub.dev/packages/connectivity_plus) - Network status
- [flutter_gen](https://pub.dev/packages/flutter_gen) - Code generation