import 'package:quiver/core.dart';

class LoginData {
  final String url;
  final String password;

  LoginData({required this.url, required this.password});

  @override
  String toString() {
    return '$runtimeType($url, $password)';
  }

  @override
  bool operator ==(Object other) {
    if (other is LoginData) {
      return url == other.url && password == other.password;
    }
    return false;
  }

  @override
  int get hashCode => hash2(url, password);
}
