import 'package:dio/dio.dart';

class AIService {
  static final Dio _dio = Dio();
  static final AIService _instance = AIService._internal();

  factory AIService() => _instance;
  AIService._internal();

  void setApiKey(String apiKey) {
    _dio.options.headers['Authorization'] = 'Bearer $apiKey';
  }

  Future<AIResponse> processNaturalLanguageInput(String input) async {
    // Mô phỏng xử lý AI - trong thực tế sẽ gọi API
    await Future.delayed(const Duration(seconds: 1));

    return _simulateAIResponse(input);
  }

  AIResponse _simulateAIResponse(String input) {
    final lowerInput = input.toLowerCase();

    // Nhận diện từ khóa để tạo response phù hợp
    if (lowerInput.contains('họp') || lowerInput.contains('meeting')) {
      return _createMeetingEvent(input);
    } else if (lowerInput.contains('nhiệm vụ') ||
        lowerInput.contains('task') ||
        lowerInput.contains('làm')) {
      return _createTask(input);
    } else if (lowerInput.contains('thói quen') ||
        lowerInput.contains('habit') ||
        lowerInput.contains('hàng ngày')) {
      return _createHabit(input);
    } else if (lowerInput.contains('mục tiêu') || lowerInput.contains('goal')) {
      return _createGoal(input);
    } else {
      return _createGeneralResponse(input);
    }
  }

  AIResponse _createMeetingEvent(String input) {
    return AIResponse(
      action: 'create_event',
      type: 'event',
      data: {
        'title': _extractTitle(input, 'Cuộc họp'),
        'description': 'Sự kiện được tạo từ AI',
        'startTime': _extractDateTime(input),
        'endTime': _calculateEndTime(_extractDateTime(input)),
        'priority': 'medium',
        'tags': ['meeting', 'work'],
        'repeat': 'none',
        'reminders': ['15min'],
        'location': _extractLocation(input),
      },
      message:
          'Tôi đã tạo sự kiện cuộc họp cho bạn! Bạn có muốn điều chỉnh gì không?',
    );
  }

  AIResponse _createTask(String input) {
    return AIResponse(
      action: 'create_task',
      type: 'task',
      data: {
        'title': _extractTitle(input, 'Nhiệm vụ mới'),
        'description': 'Nhiệm vụ được tạo từ AI',
        'dueDate': _extractDateTime(input),
        'priority': _extractPriority(input),
        'tags': ['ai-generated'],
        'repeat': 'none',
        'reminders': ['1hour'],
      },
      message: 'Tôi đã tạo nhiệm vụ cho bạn! Hãy hoàn thành đúng hạn nhé!',
    );
  }

  AIResponse _createHabit(String input) {
    return AIResponse(
      action: 'create_habit',
      type: 'habit',
      data: {
        'title': _extractTitle(input, 'Thói quen mới'),
        'description': 'Thói quen được tạo từ AI',
        'frequency': _extractFrequency(input),
        'targetValue': 1,
        'unit': 'lần',
        'tags': ['health', 'daily'],
        'reminders': ['morning'],
      },
      message:
          'Tôi đã tạo thói quen mới cho bạn! Hãy kiên trì để có kết quả tốt nhất!',
    );
  }

  AIResponse _createGoal(String input) {
    return AIResponse(
      action: 'schedule_goal',
      type: 'goal',
      data: {
        'title': _extractTitle(input, 'Mục tiêu mới'),
        'description': 'Mục tiêu được tạo từ AI',
        'deadline': _extractDateTime(input),
        'priority': 'high',
        'tags': ['goal', 'long-term'],
      },
      message:
          'Tôi đã tạo mục tiêu cho bạn! Hãy chia nhỏ thành các bước cụ thể để dễ thực hiện!',
    );
  }

  AIResponse _createGeneralResponse(String input) {
    return AIResponse(
      action: 'get_info',
      type: 'info',
      data: {},
      message: _generateHelpfulResponse(input),
    );
  }

  String _extractTitle(String input, String fallback) {
    // Logic đơn giản để trích xuất tiêu đề
    final words = input.split(' ');
    if (words.length > 2) {
      return words.take(5).join(' '); // Lấy 5 từ đầu làm tiêu đề
    }
    return fallback;
  }

  String _extractDateTime(String input) {
    // Logic đơn giản để trích xuất thời gian
    final now = DateTime.now();

    if (input.contains('mai') || input.contains('tomorrow')) {
      return DateTime(now.year, now.month, now.day + 1, 9, 0).toIso8601String();
    } else if (input.contains('tuần sau') || input.contains('next week')) {
      return DateTime(now.year, now.month, now.day + 7, 9, 0).toIso8601String();
    } else if (input.contains('tháng sau') || input.contains('next month')) {
      return DateTime(now.year, now.month + 1, now.day, 9, 0).toIso8601String();
    } else {
      return DateTime(
        now.year,
        now.month,
        now.day,
        now.hour + 1,
        0,
      ).toIso8601String();
    }
  }

  String _calculateEndTime(String startTime) {
    final start = DateTime.parse(startTime);
    final end = start.add(const Duration(hours: 1));
    return end.toIso8601String();
  }

  String? _extractLocation(String input) {
    if (input.contains('văn phòng') || input.contains('office')) {
      return 'Văn phòng';
    } else if (input.contains('nhà') || input.contains('home')) {
      return 'Nhà';
    } else if (input.contains('quán café') || input.contains('cafe')) {
      return 'Quán café';
    }
    return null;
  }

  String _extractPriority(String input) {
    if (input.contains('gấp') ||
        input.contains('urgent') ||
        input.contains('quan trọng')) {
      return 'urgent';
    } else if (input.contains('cao') || input.contains('high')) {
      return 'high';
    } else if (input.contains('thấp') || input.contains('low')) {
      return 'low';
    }
    return 'medium';
  }

  String _extractFrequency(String input) {
    if (input.contains('hàng ngày') || input.contains('daily')) {
      return 'daily';
    } else if (input.contains('hàng tuần') || input.contains('weekly')) {
      return 'weekly';
    } else if (input.contains('hàng tháng') || input.contains('monthly')) {
      return 'monthly';
    }
    return 'daily';
  }

  String _generateHelpfulResponse(String input) {
    final responses = [
      'Tôi hiểu bạn muốn $input. Bạn có thể nói rõ hơn về thời gian và chi tiết không?',
      'Để tôi giúp bạn tốt hơn, hãy cho biết cụ thể bạn muốn tạo sự kiện, nhiệm vụ hay thói quen nào?',
      'Tôi có thể giúp bạn tạo lịch, nhiệm vụ, thói quen hoặc mục tiêu. Bạn muốn làm gì?',
      'Hãy cho tôi biết thêm chi tiết về yêu cầu của bạn để tôi có thể hỗ trợ tốt nhất!',
    ];
    return responses[DateTime.now().millisecond % responses.length];
  }

  Future<String> generateGoalSchedule({
    required String goal,
    required int availableHoursPerDay,
    required DateTime deadline,
  }) async {
    // Mô phỏng tạo lịch trình cho mục tiêu
    await Future.delayed(const Duration(seconds: 1));

    final daysRemaining = deadline.difference(DateTime.now()).inDays;
    final totalHours = daysRemaining * availableHoursPerDay;

    return '''
Kế hoạch thực hiện mục tiêu: $goal

Thời gian còn lại: $daysRemaining ngày
Tổng thời gian có sẵn: $totalHours giờ

Đề xuất phân chia:
- Tuần 1-2: Nghiên cứu và lập kế hoạch chi tiết (${(totalHours * 0.2).round()} giờ)
- Tuần 3-6: Thực hiện các nhiệm vụ chính (${(totalHours * 0.6).round()} giờ)  
- Tuần 7-8: Hoàn thiện và kiểm tra (${(totalHours * 0.2).round()} giờ)

Gợi ý: Chia nhỏ mục tiêu thành các nhiệm vụ cụ thể và đặt deadline cho từng phần.
''';
  }

  Future<List<String>> getSuggestions({
    required String context,
    required DateTime dateTime,
  }) async {
    // Mô phỏng gợi ý từ AI
    await Future.delayed(const Duration(milliseconds: 500));

    final hour = dateTime.hour;
    final isWeekend = dateTime.weekday >= 6;

    List<String> suggestions = [];

    if (hour >= 6 && hour < 12) {
      suggestions.addAll([
        'Tập thể dục buổi sáng',
        'Đọc sách 30 phút',
        'Kiểm tra email và kế hoạch ngày',
        'Ăn sáng dinh dưỡng',
      ]);
    } else if (hour >= 12 && hour < 18) {
      suggestions.addAll([
        'Tập trung làm việc quan trọng',
        'Họp nhóm dự án',
        'Nghỉ giải lao 15 phút',
        'Cập nhật tiến độ công việc',
      ]);
    } else {
      suggestions.addAll([
        'Thư giãn và nghỉ ngơi',
        'Dành thời gian cho gia đình',
        'Xem phim hoặc giải trí',
        'Chuẩn bị cho ngày mai',
      ]);
    }

    if (isWeekend) {
      suggestions.addAll([
        'Dọn dẹp nhà cửa',
        'Tham gia hoạt động ngoài trời',
        'Nấu ăn cho gia đình',
        'Học kỹ năng mới',
      ]);
    }

    return suggestions.take(4).toList();
  }

  Future<Map<String, dynamic>> analyzeScheduleHealth({
    required List<Map<String, dynamic>> events,
    required List<Map<String, dynamic>> tasks,
  }) async {
    // Mô phỏng phân tích sức khỏe lịch trình
    await Future.delayed(const Duration(seconds: 1));

    final totalEvents = events.length;
    final totalTasks = tasks.length;
    final busyLevel = totalEvents + totalTasks;

    String healthStatus;
    String recommendation;
    double score;

    if (busyLevel <= 3) {
      healthStatus = 'Nhàn rỗi';
      recommendation =
          'Bạn có thể thêm một số hoạt động productive hoặc thư giãn.';
      score = 60.0;
    } else if (busyLevel <= 6) {
      healthStatus = 'Cân bằng';
      recommendation = 'Lịch trình của bạn khá hợp lý. Hãy duy trì!';
      score = 85.0;
    } else if (busyLevel <= 10) {
      healthStatus = 'Bận rộn';
      recommendation =
          'Lịch trình khá dày đặc. Hãy đảm bảo có thời gian nghỉ ngơi.';
      score = 70.0;
    } else {
      healthStatus = 'Quá tải';
      recommendation =
          'Lịch trình quá dày đặc! Hãy cân nhắc hoãn một số việc không quan trọng.';
      score = 40.0;
    }

    return {
      'healthStatus': healthStatus,
      'score': score,
      'recommendation': recommendation,
      'totalEvents': totalEvents,
      'totalTasks': totalTasks,
      'busyLevel': busyLevel,
    };
  }
}

class AIResponse {
  final String action;
  final String type;
  final Map<String, dynamic> data;
  final String message;

  AIResponse({
    required this.action,
    required this.type,
    required this.data,
    required this.message,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      action: json['action'] ?? 'get_info',
      type: json['type'] ?? 'info',
      data: json['data'] ?? {},
      message: json['message'] ?? 'Xin chào! Tôi có thể giúp gì cho bạn?',
    );
  }

  Map<String, dynamic> toJson() {
    return {'action': action, 'type': type, 'data': data, 'message': message};
  }
}
