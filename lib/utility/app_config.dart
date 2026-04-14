class AppConfig {
  // Change this one line for localhost / ngrok / production
  static const String baseUrl = 'http://localhost:3000'; // Android emulator
// static const String baseUrl =
//     'https://3657-124-29-249-83.ngrok-free.app'; // ngrok
// static const String baseUrl = 'https://yourapi.com';   // production
}

extension ImageUrlExtension on String {
  String get fullUrl {
    if (isEmpty) return '';
    if (startsWith('http')) {
      final uri = Uri.parse(this);
      return '${AppConfig.baseUrl}${uri.path}';
    }
    return '${AppConfig.baseUrl}$this';
  }
}
