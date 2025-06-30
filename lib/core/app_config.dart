import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class MyAppConfig {
  static final MyAppConfig _instance = MyAppConfig._internal();
  factory MyAppConfig() => _instance;
  MyAppConfig._internal();

  late final String _apiUrl;
  late final String _appName;

  static final Logger _logger = Logger(
    printer: PrettyPrinter(colors: true, printEmojis: true, dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart),
  );

  static Future<void> load() async {
    try {
      await dotenv.load(fileName: '.env');

      // Initialize variables
      _instance._appName = _get('APP_NAME');
      _instance._apiUrl = _get('API_URL');

      _logger.i('✅ AppConfig loaded successfully');
    } catch (e) {
      _logger.e('‼️ AppConfig Error', error: e);
      _logger.w('➤ Pastikan file .env ada di root project');
      _logger.w('➤ Dan berisi variable yang diperlukan');
      exit(1);
    }
  }

  static String _get(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw Exception('Env variable $key not found or value is empty');
    }
    return value;
  }

  // Static getters untuk akses mudah
  static String get appName => _instance._appName;
  static String get apiUrl => _instance._apiUrl;
}
