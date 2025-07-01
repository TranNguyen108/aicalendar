# AI Calendar - Ứng dụng Lịch Thông Minh

AI Calendar là một ứng dụng Flutter quản lý thời gian thông minh với tích hợp AI, giúp người dùng tổ chức công việc, theo dõi thói quen và tối ưu hóa năng suất.

## � Tình Trạng Dự Án

### ✅ Đã Hoàn Thành
- **Cấu trúc dự án**: Thiết kế kiến trúc modular hoàn chỉnh ✨
- **Navigation**: Bottom navigation với 5 tabs chính đã hoạt động ✨
- **UI Components**: Tất cả shared components đã được implement ✨
- **Models**: Data models với JSON serialization hoàn chỉnh ✨
- **Services**: Notification service, Database service đã sẵn sàng ✨
- **Theming**: Light/Dark theme support ✨
- **Code Generation**: Build runner setup và hoạt động tốt ✨
- **Build System**: Dự án build thành công cho Web platform ✨
- **Code Quality**: Không có lỗi Flutter analyze ✨
- **Dependencies**: Tất cả 21 packages được cài đặt và hoạt động ✨

### 🔄 Đang Phát Triển
- **AI Integration**: Chat AI screen đã có UI, cần tích hợp AI service thật
- **Database**: Schema đã thiết kế, cần implement CRUD operations đầy đủ
- **Real-time Features**: Weather integration, notifications nâng cao
- **Cross-platform**: Chuẩn bị build cho Android và iOS

### 📋 Sắp Tới
- **Cloud Sync**: Đồng bộ dữ liệu đám mây
- **Advanced AI**: Tính năng AI phân tích và gợi ý thông minh
- **Floating Widget**: Widget overlay cho Android
- **Testing**: Unit tests và Integration tests
- **Performance**: Tối ưu hóa hiệu suất

## �🚀 Tính năng chính

### 📱 Core Modules

1. **Homepage (Trang chủ)**
   - Hiển thị thời gian thực
   - Widget chat AI nổi
   - Nhiệm vụ tiếp theo
   - Widget thời tiết
   - Tổng quan thống kê

2. **Calendar (Lịch)**
   - Xem lịch dạng ngày/tuần/tháng
   - Tương tác nhanh với sự kiện
   - Màu sắc phân loại
   - Tính năng lặp lại
   - Nhắc nhở thông minh

3. **Tasks (Nhiệm vụ + Ghi chú)**
   - Quản lý nhiệm vụ với priority
   - Hệ thống tag phân loại
   - Deadline và nhắc nhở
   - Ghi chú có cấu trúc
   - Subtasks support

4. **Quick Add (Thêm nhanh)**
   - Modal thêm nhanh sự kiện
   - Tạo todo với đầy đủ options
   - Note-taking nhanh
   - Hỗ trợ nhắc nhở và lặp lại

5. **Habits & Challenges (Thói quen)**
   - Theo dõi thói quen hàng ngày
   - Thử thách dài hạn
   - Streak tracking
   - Biểu đồ tiến độ

6. **Chat AI (Trợ lý AI)**
   - Nhập lệnh bằng ngôn ngữ tự nhiên
   - Tự động tạo lịch từ text
   - Phân tích và gợi ý thông minh
   - Chat history

7. **Reminder (Nhắc nhở)**
   - Notification system
   - Âm thanh tùy chỉnh
   - Popup alerts
   - AI reminder suggestions

8. **Statistics (Thống kê)**
   - Biểu đồ năng suất
   - Tỷ lệ hoàn thành tasks
   - Habit completion rate
   - Weekly/Monthly reports

9. **Focus Mode (Chế độ tập trung)**
   - Pomodoro timer
   - Chặn phân tâm
   - Background music
   - Focus statistics

10. **Goal-based Scheduling**
    - Nhập mục tiêu bằng AI
    - Tự động chia nhỏ timeline
    - Smart scheduling
    - Progress tracking

11. **Offline Mode**
    - Local database caching
    - Sync khi online
    - Core functionality available

12. **Floating Widget**
    - Overlay window trên màn hình
    - Quick access to AI chat
    - Next task display
    - Draggable interface

13. **Weather Analysis**
    - Tích hợp weather API
    - AI analysis cho planning
    - Gợi ý hoạt động theo thời tiết

14. **Settings**
    - Theme customization
    - Language selection
    - Data management
    - Privacy controls

## 🏗️ Cấu trúc dự án

```
lib/
├── core/                           # Core functionality
│   ├── constants/                  # App constants
│   │   ├── app_constants.dart      # General constants
│   │   ├── colors/
│   │   │   └── app_colors.dart     # Color palette
│   │   └── strings/
│   │       └── app_strings.dart    # String resources
│   ├── theme/
│   │   └── app_theme.dart          # App theming
│   └── routes/
│       └── app_routes.dart         # Navigation routes
│
├── shared/                         # Shared components & utilities
│   ├── components/
│   │   ├── common/                 # Common UI components
│   │   │   ├── custom_app_bar.dart
│   │   │   ├── bottom_navigation_widget.dart
│   │   │   └── floating_chat_widget.dart
│   │   └── forms/                  # Form widgets
│   │       ├── date_time_picker.dart
│   │       ├── color_selector.dart
│   │       ├── tag_selector.dart
│   │       └── repeat_option_widget.dart
│   ├── models/                     # Data models
│   │   ├── calendar/
│   │   │   └── event.dart
│   │   ├── tasks/
│   │   │   └── task.dart
│   │   └── habits/
│   │       └── habit.dart
│   ├── services/                   # Business logic services
│   │   ├── database/
│   │   │   └── database_service.dart
│   │   ├── notifications/
│   │   │   └── notification_service.dart
│   │   ├── ai/
│   │   │   └── ai_service.dart
│   │   └── weather/
│   │       └── weather_service.dart
│   └── utils/                      # Utility functions
│
└── modules/                        # Feature modules
    ├── homepage/                   # Homepage module
    │   ├── homepage_screen.dart
    │   └── widgets/
    ├── calendar/                   # Calendar module
    │   ├── calendar_screen.dart
    │   └── widgets/
    ├── tasks/                      # Tasks module
    │   ├── tasks_screen.dart
    │   └── widgets/
    ├── habits/                     # Habits module
    │   ├── habits_screen.dart
    │   └── widgets/
    ├── quick_add/                  # Quick add module
    │   ├── quick_add_screen.dart
    │   └── widgets/
    ├── chat_ai/                    # AI Chat module
    │   ├── chat_ai_screen.dart
    │   └── widgets/
    ├── focus_mode/                 # Focus mode module
    │   ├── focus_mode_screen.dart
    │   └── widgets/
    ├── statistics/                 # Statistics module
    │   ├── statistics_screen.dart
    │   └── widgets/
    ├── settings/                   # Settings module
    │   ├── settings_screen.dart
    │   └── widgets/
    ├── reminder/                   # Reminder module
    │   ├── reminder_screen.dart
    │   └── widgets/
    ├── weather/                    # Weather module
    │   ├── weather_screen.dart
    │   └── widgets/
    ├── goal_scheduling/            # Goal scheduling module
    │   ├── goal_scheduling_screen.dart
    │   └── widgets/
    └── floating_widget/            # Floating widget module
        ├── floating_widget_screen.dart
        └── widgets/
```

## 🎨 Component Architecture

### Shared Components

#### Navigation Components
- **CustomAppBar**: Thanh tiêu đề thống nhất
- **BottomNavigationWidget**: Navigation với 5 tabs chính
- **FloatingChatWidget**: Widget chat AI có thể kéo thả

#### Form Components
- **DateTimePicker**: Chọn ngày giờ
- **ColorSelector**: Chọn màu sắc
- **TagSelector**: Quản lý tags
- **RepeatOptionWidget**: Tùy chọn lặp lại

### Module Independence
Mỗi module được thiết kế như một plugin độc lập:
- ✅ Self-contained logic
- ✅ Minimal dependencies
- ✅ Reusable components
- ✅ Easy to test
- ✅ Hot-swappable

## 🔧 Dependencies

### Core Dependencies
- `flutter_riverpod`: State management
- `sqflite`: Local database
- `shared_preferences`: Local storage
- `path`: File path utilities

### UI & Interactions
- `table_calendar`: Calendar widget
- `fl_chart`: Charts and graphs
- `flutter_colorpicker`: Color picker
- `font_awesome_flutter`: Icons

### Notifications & Services
- `flutter_local_notifications`: Local notifications
- `timezone`: Timezone handling
- `geolocator`: Location services
- `permission_handler`: Permissions

### AI & Network
- `dio`: HTTP client
- `http`: HTTP requests
- `json_annotation`: JSON serialization

### Special Features
- `flutter_overlay_window`: Floating widgets

### Development
- `build_runner`: Code generation
- `json_serializable`: JSON serialization
- `flutter_lints`: Code quality

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1+)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

```bash
# Clone repository
git clone https://github.com/your-username/aicalendar.git
cd aicalendar

# Cài đặt dependencies
flutter pub get

# Chạy code generation
flutter packages pub run build_runner build

# Chạy ứng dụng (Web)
flutter run -d chrome

# Build cho production
flutter build web
```

### Development Setup

1. **Environment Configuration**
   - Copy `.env.example` to `.env`
   - Add your API keys (OpenAI, Weather API)

2. **Database Setup**
   - Database sẽ tự động tạo khi chạy app lần đầu
   - Check `database_service.dart` cho schema

3. **Testing**
```bash
flutter test
```

## 📱 Usage Examples

### Thêm sự kiện bằng AI
```
User: "Tôi có cuộc họp với khách hàng lúc 9h sáng mai"
AI: ✅ Đã tạo sự kiện "Cuộc họp với khách hàng" 
     📅 Ngày mai 9:00-10:00
     🔔 Nhắc nhở trước 15 phút
```

### Quick Add Task
```
1. Nhấn nút "+" ở bottom navigation
2. Chọn tab "Nhiệm vụ"
3. Nhập title, description, priority
4. Chọn due date và reminders
5. Save
```

### Theo dõi thói quen
```
1. Vào tab "Thói quen"
2. Tạo habit mới (ví dụ: "Uống 8 ly nước")
3. Set frequency (hàng ngày)
4. Track progress hàng ngày
5. Xem streak và statistics
```

## 🔮 Roadmap

### Phase 1 (Hoàn thành ✅)
- ✅ Core architecture setup
- ✅ Basic UI components và navigation
- ✅ Database schema và models
- ✅ Code generation system
- ✅ Build system cho Web
- ✅ Dependencies integration

### Phase 2 (Đang thực hiện 🔄)
- 🔄 Complete AI service integration
- 🔄 Database CRUD operations
- 🔄 Real-time notifications
- 🔄 Cross-platform builds
- 🔄 Feature completion và testing

### Phase 3 (Tương lai 📋)
- 📋 Cloud sync và backup
- 📋 Advanced AI analytics
- 📋 Team collaboration features
- 📋 Performance optimization
- 📋 Extensive testing coverage

### Phase 3 (Tương lai)
- 📋 Cloud sync
- 📋 Team collaboration
- 📋 Advanced AI features
- 📋 Widget system
- 📋 Export/Import data

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for amazing framework
- OpenAI for AI capabilities
- Community packages contributors
- Design inspiration from modern calendar apps

---

Made with ❤️ using Flutter
