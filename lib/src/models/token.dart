import 'dart:convert';

class Token {
  final String token;
  Map<String, dynamic>? _payload;
  String? _userId;
  DateTime? _exp;

  Map<String, dynamic> get payload => _payload ??= json.decode(
      utf8.decode(base64.decode(base64.normalize(token.split('.')[1]))));

  String get userId => _userId ??= payload['id'];

  DateTime get exp =>
      _exp ??= DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);

  bool get isExpired => exp.isBefore(DateTime.now());

  Token(this.token);

  @override
  String toString() => token;
}
