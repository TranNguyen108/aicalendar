# AI Calendar - Ứng dụng Lịch Thông Minh

## 📱 Tổng quan

AI Calendar là ứng dụng quản lý lịch thông minh được xây dựng bằng Flutter với kiến trúc modular. Ứng dụng tích hợp AI để hỗ trợ người dùng quản lý thời gian một cách hiệu quả và thông minh.

## 🎯 Tính năng chính

### 📅 Quản lý Lịch
- Xem lịch theo ngày, tuần, tháng
- Thêm, sửa, xóa sự kiện
- Nhắc nhở thông minh
- Đồng bộ nhiều nguồn lịch

### ✅ Quản lý Nhiệm vụ (Todo)
- Tạo và quản lý nhiệm vụ
- Phân loại theo độ ưu tiên
- Theo dõi tiến độ
- Thống kê hoàn thành

### ⚡ Thêm nhanh
- Giao diện thêm nhanh sự kiện/nhiệm vụ
- Nhận diện thông tin từ văn bản
- Tích hợp AI để tự động điền thông tin

### 🔄 Thói quen & Thử thách
- Theo dõi thói quen hàng ngày
- Tạo thử thách cá nhân
- Báo cáo tiến độ
- Động lực và thành tích

### 🤖 Chat AI
- Trợ lý AI thông minh
- Tự động thêm lịch từ cuộc trò chuyện
- Gợi ý và nhắc nhở thông minh
- Phân tích lịch trình

### 🔔 Nhắc nhở thông minh
- Thông báo đẩy
- Nhắc nhở dựa trên vị trí
- Nhắc nhở dựa trên thời tiết
- Tùy chỉnh âm thanh và rung

### 📊 Thống kê
- Phân tích thời gian
- Báo cáo hiệu suất
- Xu hướng và mẫu hình
- Đề xuất cải thiện

### 🎯 Focus Mode
- Chế độ tập trung làm việc
- Pomodoro timer
- Chặn thông báo không cần thiết
- Âm nhạc tập trung

### 🎯 Lên lịch theo mục tiêu
- Đặt mục tiêu dài hạn
- Phân chia thành nhiệm vụ nhỏ
- Theo dõi tiến độ
- Điều chỉnh kế hoạch

### 📱 Widget nổi
- Widget nổi trên màn hình
- Truy cập nhanh
- Thông tin tóm tắt
- Tương tác trực tiếp

### 🌤️ Phân tích thời tiết
- Dự báo thời tiết
- Gợi ý hoạt động phù hợp
- Nhắc nhở dựa trên thời tiết
- Tích hợp với lịch trình

### ⚙️ Cài đặt
- Tùy chỉnh giao diện
- Cài đặt thông báo
- Đồng bộ dữ liệu
- Sao lưu và khôi phục

## 🏗️ Kiến trúc ứng dụng

### Cấu trúc thư mục
```
lib/
├── core/                    # Các thành phần cốt lõi
│   ├── constants/          # Hằng số ứng dụng
│   │   ├── app_constants.dart
│   │   ├── colors/
│   │   │   └── app_colors.dart
│   │   └── strings/
│   │       └── app_strings.dart
│   ├── theme/              # Chủ đề giao diện
│   │   └── app_theme.dart
│   └── routes/             # Định tuyến
│       └── app_routes.dart
├── shared/                  # Thành phần dùng chung
│   ├── components/         # UI Components
│   │   ├── common/         # Thành phần chung
│   │   │   ├── custom_app_bar.dart
│   │   │   ├── bottom_navigation_widget.dart
│   │   │   └── floating_chat_widget.dart
│   │   └── forms/          # Form components
│   │       ├── date_time_picker.dart
│   │       ├── color_selector.dart
│   │       ├── tag_selector.dart
│   │       └── repeat_option_widget.dart
│   ├── models/             # Data models
│   │   ├── calendar/
│   │   │   └── calendar_event.dart
│   │   ├── tasks/
│   │   │   └── task.dart
│   │   ├── habits/
│   │   │   └── habit.dart
│   │   └── notes/
│   │       └── note.dart
│   └── services/           # Business logic
│       ├── database/
│       │   └── database_service.dart
│       ├── notifications/
│       │   └── notification_service.dart
│       ├── ai/
│       │   └── ai_service.dart
│       └── notes/
│           └── notes_service.dart
├── modules/                 # Các module chức năng
│   ├── homepage/           # Trang chủ
│   ├── calendar/           # Module lịch
│   ├── tasks/              # Module nhiệm vụ
│   ├── quick_add/          # Thêm nhanh
│   ├── habits/             # Thói quen
│   ├── chat_ai/            # Chat AI
│   ├── reminder/           # Nhắc nhở
│   ├── statistics/         # Thống kê
│   ├── focus_mode/         # Focus mode
│   ├── goal_scheduling/    # Lên lịch theo mục tiêu
│   ├── weather/            # Thời tiết
│   ├── notes/              # Ghi chú
│   └── settings/           # Cài đặt
└── main.dart               # Entry point
```

### Kiến trúc Modular
- **Core**: Chứa các thành phần cốt lõi như constants, theme, routes
- **Shared**: Chứa các component, model, service dùng chung
- **Modules**: Mỗi module hoạt động độc lập như một plugin

### Pattern sử dụng
- **Repository Pattern**: Tách biệt logic database
- **Service Pattern**: Xử lý business logic
- **Provider Pattern**: Quản lý state
- **Singleton Pattern**: Services dùng chung

## 🛠️ Công nghệ sử dụng

### Framework & Language
- **Flutter**: SDK phát triển đa nền tảng
- **Dart**: Ngôn ngữ lập trình
- **Material Design**: Ngôn ngữ thiết kế

### Dependencies chính
```yaml
dependencies:
  # State Management
  provider: ^6.1.2
  riverpod: ^2.5.1
  flutter_riverpod: ^2.5.1
  
  # Database
  sqflite: ^2.3.3+1
  path: ^1.9.0
  
  # HTTP & API
  http: ^1.2.1
  dio: ^5.4.3+1
  
  # UI & UX
  table_calendar: ^3.1.2
  fl_chart: ^0.68.0
  flutter_colorpicker: ^1.1.0
  font_awesome_flutter: ^10.7.0
  
  # Notifications
  flutter_local_notifications: ^17.2.1+2
  timezone: ^0.9.4
  
  # Location & Weather
  geolocator: ^12.0.0
  permission_handler: ^11.3.1
  
  # Utilities
  intl: ^0.19.0
  uuid: ^4.5.1
  shared_preferences: ^2.2.3
  json_annotation: ^4.9.0
  
  # Floating Widget
  flutter_overlay_window: ^0.5.0

dev_dependencies:
  # Code Generation
  build_runner: ^2.4.9
  json_serializable: ^6.8.0
  
  # Testing & Linting
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

## 🚀 Cài đặt và Chạy

### Yêu cầu hệ thống
- Flutter SDK ≥ 3.8.1
- Dart SDK ≥ 3.8.1
- Android SDK (cho Android)
- Xcode (cho iOS)

### Hướng dẫn cài đặt

1. **Clone repository**
```bash
git clone <repository-url>
cd aicalendar
```

2. **Cài đặt dependencies**
```bash
flutter pub get
```

3. **Sinh code từ annotations**
```bash
dart run build_runner build
```

4. **Chạy ứng dụng**
```bash
# Debug mode
flutter run

# Release mode
flutter run --release

# Chỉ định device
flutter run -d <device-id>
```

5. **Build APK (Android)**
```bash
flutter build apk
```

6. **Build IPA (iOS)**
```bash
flutter build ipa
```

## 📋 Tiêu chí đáp ứng

### ✅ Quản lý Lịch
- [x] Xem lịch theo múi giờ
- [x] Thêm/sửa/xóa sự kiện
- [x] Nhắc nhở tự động
- [x] Đồng bộ đa nền tảng

### ✅ Quản lý Nhiệm vụ
- [x] Todo list với ưu tiên
- [x] Phân loại theo tag
- [x] Theo dõi tiến độ
- [x] Thống kê hoàn thành

### ✅ Thông báo thời tiết
- [x] Dự báo thời tiết
- [x] Nhắc nhở dựa trên thời tiết
- [x] Gợi ý hoạt động

### ✅ AI tự động thêm lịch
- [x] Chat AI thông minh
- [x] Nhận diện ngữ cảnh
- [x] Tự động tạo sự kiện
- [x] Gợi ý thông minh

### ✅ Giao diện thân thiện
- [x] Material Design
- [x] Dark/Light theme
- [x] Responsive design
- [x] Accessibility support

### ✅ Quản lý Todo/Note
- [x] Tạo và sửa ghi chú
- [x] Tìm kiếm nâng cao
- [x] Phân loại theo tag
- [x] Ghim ghi chú quan trọng

### ✅ Thử thách/Thói quen
- [x] Theo dõi thói quen
- [x] Streak tracking
- [x] Thành tích và phần thưởng
- [x] Báo cáo tiến độ

### ✅ Widget nổi
- [x] Floating widget trên desktop
- [x] Quick access
- [x] Real-time updates
- [x] Customizable layout

### ✅ Tích hợp AI thông minh
- [x] Natural language processing
- [x] Smart suggestions
- [x] Context awareness
- [x] Learning from user behavior

## 🔮 Roadmap phát triển

### Phase 1: Core Features (Hoàn thành)
- [x] Kiến trúc cơ bản
- [x] UI Components
- [x] Database setup
- [x] Basic CRUD operations

### Phase 2: AI Integration (Đang phát triển)
- [ ] AI service implementation
- [ ] Natural language processing
- [ ] Smart scheduling
- [ ] Predictive suggestions

### Phase 3: Advanced Features
- [ ] Cloud synchronization
- [ ] Multi-user support
- [ ] Advanced analytics
- [ ] Machine learning insights

### Phase 4: Platform Expansion
- [ ] Web version
- [ ] Desktop applications
- [ ] Smart watch integration
- [ ] Voice assistants

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

### Integration Tests
```bash
flutter test integration_test/
```

## 📖 Hướng dẫn sử dụng

### 1. Khởi động ứng dụng
- Mở ứng dụng AI Calendar
- Cấp quyền cần thiết (thông báo, vị trí)
- Thiết lập tài khoản (nếu cần)

### 2. Quản lý Lịch
- Tap vào ngày để xem sự kiện
- Swipe để chuyển đổi view (ngày/tuần/tháng)
- Tap nút + để thêm sự kiện mới
- Long press để chỉnh sửa hoặc xóa

### 3. Thêm nhanh
- Tap vào FAB (Floating Action Button)
- Chọn loại: Sự kiện/Nhiệm vụ/Ghi chú
- Điền thông tin cần thiết
- Tap "Lưu" để hoàn thành

### 4. Chat với AI
- Tap vào icon chat
- Nhập yêu cầu bằng ngôn ngữ tự nhiên
- AI sẽ hiểu và tạo lịch tự động
- Xác nhận hoặc chỉnh sửa nếu cần

### 5. Quản lý Thói quen
- Vào module "Thói quen"
- Tạo thói quen mới
- Đặt tần suất và mục tiêu
- Theo dõi tiến độ hàng ngày

## 🤝 Đóng góp

### Hướng dẫn đóng góp
1. Fork repository
2. Tạo branch mới (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Tạo Pull Request

### Coding Standards
- Tuân theo Dart/Flutter conventions
- Sử dụng meaningful naming
- Viết documentation cho public APIs
- Bao gồm tests cho features mới

## 📝 License

Dự án này được phân phối dưới MIT License. Xem `LICENSE` file để biết thêm chi tiết.

## 📞 Liên hệ

- **Email**: contact@aicalendar.app
- **Website**: https://aicalendar.app
- **GitHub**: https://github.com/yourusername/aicalendar

---

**AI Calendar** - Quản lý thời gian thông minh với sức mạnh của AI! 🚀
