import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_helper/models/token.dart';

Token? _accessToken;
Token? _refreshToken;

String? get userId => _refreshToken?.userId ?? _accessToken?.userId;

Future<Token?> getAccessToken() async {
  if (_accessToken != null) return _accessToken;

  final _storage = await SharedPreferences.getInstance();

  final token = _storage.getString('access_token');
  if (token == null) return null;

  return _accessToken = Token(token);
}

Future<Token?> getRefreshToken() async {
  if (_refreshToken != null) return _refreshToken;

  final _storage = await SharedPreferences.getInstance();

  final token = _storage.getString('refresh_token');
  if (token == null) return null;

  return _refreshToken = Token(token);
}

Future<bool> setAccessToken(Token? token) async {
  _accessToken = token;

  final _storage = await SharedPreferences.getInstance();

  if (token == null) return _storage.remove('access_token');

  return _storage.setString('access_token', token.token);
}

Future<bool> setRefreshToken(Token? token) async {
  _refreshToken = token;

  final _storage = await SharedPreferences.getInstance();

  if (token == null) return _storage.remove('refresh_token');

  return _storage.setString('refresh_token', token.token);
}

Future<void> logout() async {
  setAccessToken(null);
  await setRefreshToken(null);
}
