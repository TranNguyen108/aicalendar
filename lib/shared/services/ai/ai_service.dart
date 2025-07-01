import 'package:dio/dio.dart';
import 'dart:convert';

class AIService {
  static final Dio _dio = Dio();
  static final AIService _instance = AIService._internal();

  factory AIService() => _instance;
  AIService._internal();

  String? _apiKey;

  void setApiKey(String apiKey) {
    _apiKey = apiKey;
    _dio.options.headers['Authorization'] = 'Bearer $apiKey';
  }

  Future<AIResponse> processNaturalLanguageInput(String input) async {
    if (_apiKey == null) {
      throw Exception('API key not set');
    }

    try {
      final response = await _dio.post(
        'https://api.openai.com/v1/chat/completions',
        data: {
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'system', 'content': _getSystemPrompt()},
            {'role': 'user', 'content': input},
          ],
          'max_tokens': 500,
          'temperature': 0.7,
        },
      );

      final content = response.data['choices'][0]['message']['content'];
      return _parseAIResponse(content);
    } catch (e) {
      throw Exception('Lỗi khi xử lý yêu cầu AI: $e');
    }
  }

  String _getSystemPrompt() {
    return '''
Bạn là trợ lý AI cho ứng dụng lịch thông minh. Nhiệm vụ của bạn là phân tích yêu cầu của người dùng bằng tiếng Việt và trả về JSON với định dạng sau:

{
  "action": "create_event|create_task|create_habit|schedule_goal|get_info",
  "type": "event|task|habit|goal|info",
  "data": {
    "title": "string",
    "description": "string",
    "startTime": "YYYY-MM-DD HH:mm" (nếu có),
    "endTime": "YYYY-MM-DD HH:mm" (nếu có),
    "dueDate": "YYYY-MM-DD HH:mm" (nếu có),
    "priority": "low|medium|high|urgent",
    "tags": ["tag1", "tag2"],
    "repeat": "none|daily|weekly|monthly",
    "reminders": ["5min", "15min", "30min", "1hour", "1day"],
    "location": "string" (nếu có)
  },
  "message": "Phản hồi thân thiện cho người dùng"
}

Ví dụ input: "Tôi có cuộc họp với khách hàng lúc 9h sáng mai"
Ví dụ output: Tạo sự kiện với thời gian phù hợp.

Luôn trả về JSON hợp lệ và phản hồi bằng tiếng Việt.
''';
  }

  AIResponse _parseAIResponse(String content) {
    try {
      final json = jsonDecode(content);
      return AIResponse.fromJson(json);
    } catch (e) {
      // Fallback nếu AI không trả về JSON hợp lệ
      return AIResponse(
        action: 'get_info',
        type: 'info',
        data: {},
        message: content,
      );
    }
  }

  Future<String> generateGoalSchedule({
    required String goal,
    required int availableHoursPerDay,
    required DateTime deadline,
  }) async {
    if (_apiKey == null) {
      throw Exception('API key not set');
    }

    final prompt =
        '''
Tôi có mục tiêu: "$goal"
Thời gian có sẵn mỗi ngày: $availableHoursPerDay giờ
Deadline: ${deadline.toIso8601String()}

Hãy tạo một kế hoạch học tập/thực hiện chi tiết với:
1. Chia nhỏ mục tiêu thành các cột mốc
2. Phân bổ thời gian hợp lý
3. Gợi ý lịch trình hàng ngày
4. Đề xuất các nhiệm vụ cụ thể

Trả về JSON với format:
{
  "schedule": [
    {
      "week": 1,
      "tasks": [
        {
          "title": "string",
          "description": "string",
          "estimatedHours": number,
          "priority": "low|medium|high",
          "dueDate": "YYYY-MM-DD"
        }
      ]
    }
  ],
  "tips": ["tip1", "tip2"],
  "milestones": [
    {
      "title": "string",
      "deadline": "YYYY-MM-DD",
      "description": "string"
    }
  ]
}
''';

    try {
      final response = await _dio.post(
        'https://api.openai.com/v1/chat/completions',
        data: {
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
          'max_tokens': 1500,
          'temperature': 0.7,
        },
      );

      return response.data['choices'][0]['message']['content'];
    } catch (e) {
      throw Exception('Lỗi khi tạo lịch trình mục tiêu: $e');
    }
  }

  Future<String> analyzeProductivity({
    required int completedTasks,
    required int totalTasks,
    required int focusMinutes,
    required List<String> habitCompletions,
  }) async {
    if (_apiKey == null) {
      throw Exception('API key not set');
    }

    final prompt =
        '''
Phân tích năng suất làm việc của tôi:
- Nhiệm vụ hoàn thành: $completedTasks/$totalTasks
- Thời gian tập trung: $focusMinutes phút
- Thói quen hoàn thành: ${habitCompletions.join(', ')}

Hãy đưa ra:
1. Đánh giá tổng quan
2. Điểm mạnh và điểm cần cải thiện
3. Gợi ý cụ thể để nâng cao hiệu suất
4. Mục tiêu cho tuần tới

Trả về bằng tiếng Việt, dễ hiểu và động viên.
''';

    try {
      final response = await _dio.post(
        'https://api.openai.com/v1/chat/completions',
        data: {
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
          'max_tokens': 800,
          'temperature': 0.8,
        },
      );

      return response.data['choices'][0]['message']['content'];
    } catch (e) {
      throw Exception('Lỗi khi phân tích năng suất: $e');
    }
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
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'action': action, 'type': type, 'data': data, 'message': message};
  }
}
