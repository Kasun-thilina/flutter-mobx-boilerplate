import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment {
  dev,
  qa,
  prod,
}

class EnvironmentUtils {
  static final EnvironmentUtils _instance = EnvironmentUtils._();
  static Environment? _environment;

  EnvironmentUtils._();

  static EnvironmentUtils get instance => _instance;

  static Future load({required Environment env}) async {
    _environment = env;
    switch (env) {
      case Environment.dev:
        await dotenv.load(fileName: 'env/.env.dev');
        break;
      case Environment.prod:
        await dotenv.load(fileName: 'env/.env.prod');
        break;
      case Environment.qa:
        await dotenv.load(fileName: 'env/.env.qa');
        break;
      default:
        await dotenv.load(fileName: 'env/.env.dev');
        break;
    }
  }

  static String getEnvName()  {
    switch (_environment) {
      case Environment.dev:
        return "Dev Server";
      case Environment.prod:
        return "";
      case Environment.qa:
        return "QA Server";
      default:
        return "";
    }
  }

  static Environment get environment {
    return _environment!;
  }

  static String get apiBaseURL {
    return dotenv.get('API_URL');
  }

  static String get sendBirdAppID {
    return dotenv.get('SENDBIRD_APP_ID');
  }

  static String get apiClientID {
    return dotenv.get('CLIENT_ID');
  }

  static String get apiClientSecret {
    return dotenv.get('CLIENT_SECRET');
  }
}
