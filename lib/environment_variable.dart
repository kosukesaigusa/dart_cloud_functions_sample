// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

abstract final class EnvironmentVariable {
  static Environment get environment =>
      Environment.from(Platform.environment['ENVIRONMENT']);

  static String get projectName => Platform.environment['PROJECT_NAME']!;

  static String get clientId => Platform.environment['CLIENT_ID']!;

  static String get clientEmail => Platform.environment['CLIENT_EMAIL']!;

  static String get privateKey => Platform.environment['PRIVATE_KEY']!;
}

enum Environment {
  local,
  production,
  ;

  factory Environment.from(String? string) {
    return switch (string) {
      'local' => Environment.local,
      'production' => Environment.production,
      _ => throw ArgumentError('$string is not a valid environment'),
    };
  }
}
