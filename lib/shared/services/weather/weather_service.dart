import 'package:geolocator/geolocator.dart';

class WeatherService {
  static final WeatherService _instance = WeatherService._internal();
  factory WeatherService() => _instance;
  WeatherService._internal();

  // Để demo, chúng ta sẽ mô phỏng dữ liệu thời tiết
  // Trong thực tế, bạn sẽ cần API key từ OpenWeatherMap hoặc dịch vụ tương tự

  Future<WeatherData> getCurrentWeather() async {
    try {
      // Lấy vị trí hiện tại
      Position position = await _getCurrentPosition();

      // Mô phỏng dữ liệu thời tiết
      return _generateMockWeatherData(position);

      // Trong thực tế, gọi API:
      // final response = await _dio.get(
      //   'https://api.openweathermap.org/data/2.5/weather',
      //   queryParameters: {
      //     'lat': position.latitude,
      //     'lon': position.longitude,
      //     'appid': 'YOUR_API_KEY',
      //     'units': 'metric',
      //     'lang': 'vi',
      //   },
      // );
      // return WeatherData.fromJson(response.data);
    } catch (e) {
      throw Exception('Không thể lấy dữ liệu thời tiết: $e');
    }
  }

  Future<List<WeatherForecast>> getWeatherForecast({int days = 5}) async {
    try {
      await _getCurrentPosition(); // Kiểm tra quyền vị trí

      // Mô phỏng dự báo thời tiết 5 ngày
      return _generateMockForecast(days);
    } catch (e) {
      throw Exception('Không thể lấy dự báo thời tiết: $e');
    }
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Dịch vụ vị trí đã bị tắt');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Quyền truy cập vị trí bị từ chối');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Quyền truy cập vị trí bị từ chối vĩnh viễn');
    }

    return await Geolocator.getCurrentPosition();
  }

  WeatherData _generateMockWeatherData(Position position) {
    final now = DateTime.now();
    final conditions = ['sunny', 'cloudy', 'rainy', 'partly_cloudy'];
    final condition = conditions[now.hour % conditions.length];

    int temp = 25 + (now.hour % 10);
    if (now.hour < 6 || now.hour > 20) temp -= 5;

    return WeatherData(
      temperature: temp,
      condition: condition,
      description: _getWeatherDescription(condition),
      humidity: 60 + (now.minute % 30),
      windSpeed: 5 + (now.second % 10),
      location: 'Hà Nội, Việt Nam',
      timestamp: now,
      icon: _getWeatherIcon(condition),
    );
  }

  List<WeatherForecast> _generateMockForecast(int days) {
    final forecasts = <WeatherForecast>[];
    final conditions = ['sunny', 'cloudy', 'rainy', 'partly_cloudy'];

    for (int i = 0; i < days; i++) {
      final date = DateTime.now().add(Duration(days: i));
      final condition = conditions[i % conditions.length];

      forecasts.add(
        WeatherForecast(
          date: date,
          condition: condition,
          description: _getWeatherDescription(condition),
          minTemp: 20 + (i % 5),
          maxTemp: 30 + (i % 8),
          humidity: 50 + (i % 40),
          chanceOfRain: condition == 'rainy' ? 80 : (i % 30),
          icon: _getWeatherIcon(condition),
        ),
      );
    }

    return forecasts;
  }

  String _getWeatherDescription(String condition) {
    switch (condition) {
      case 'sunny':
        return 'Nắng đẹp';
      case 'cloudy':
        return 'Nhiều mây';
      case 'rainy':
        return 'Mưa';
      case 'partly_cloudy':
        return 'Có mây';
      default:
        return 'Không xác định';
    }
  }

  String _getWeatherIcon(String condition) {
    switch (condition) {
      case 'sunny':
        return '☀️';
      case 'cloudy':
        return '☁️';
      case 'rainy':
        return '🌧️';
      case 'partly_cloudy':
        return '⛅';
      default:
        return '🌤️';
    }
  }

  // Phân tích thời tiết để đưa ra gợi ý hoạt động
  String getActivitySuggestion(WeatherData weather) {
    if (weather.temperature >= 30) {
      return 'Thời tiết nóng, nên ở trong nhà có điều hòa hoặc tập thể dục trong nhà';
    } else if (weather.temperature <= 15) {
      return 'Thời tiết lạnh, hãy mặc ấm và cân nhắc hoạt động trong nhà';
    } else if (weather.condition == 'rainy') {
      return 'Trời mưa, tốt nhất nên ở trong nhà hoặc mang theo ô';
    } else if (weather.condition == 'sunny') {
      return 'Thời tiết đẹp, thích hợp cho các hoạt động ngoài trời!';
    } else {
      return 'Thời tiết ổn định, phù hợp cho hầu hết các hoạt động';
    }
  }

  bool isSuitableForOutdoorActivity(WeatherData weather) {
    return weather.condition != 'rainy' &&
        weather.temperature >= 18 &&
        weather.temperature <= 32 &&
        weather.windSpeed < 20;
  }
}

class WeatherData {
  final int temperature;
  final String condition;
  final String description;
  final int humidity;
  final double windSpeed;
  final String location;
  final DateTime timestamp;
  final String icon;

  WeatherData({
    required this.temperature,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.location,
    required this.timestamp,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: (json['main']['temp'] as num).round(),
      condition: json['weather'][0]['main'].toString().toLowerCase(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      location: json['name'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      icon: json['weather'][0]['icon'],
    );
  }
}

class WeatherForecast {
  final DateTime date;
  final String condition;
  final String description;
  final int minTemp;
  final int maxTemp;
  final int humidity;
  final int chanceOfRain;
  final String icon;

  WeatherForecast({
    required this.date,
    required this.condition,
    required this.description,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.chanceOfRain,
    required this.icon,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      condition: json['weather'][0]['main'].toString().toLowerCase(),
      description: json['weather'][0]['description'],
      minTemp: (json['temp']['min'] as num).round(),
      maxTemp: (json['temp']['max'] as num).round(),
      humidity: json['humidity'],
      chanceOfRain: ((json['pop'] as num) * 100).round(),
      icon: json['weather'][0]['icon'],
    );
  }
}
