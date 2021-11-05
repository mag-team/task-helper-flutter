class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        refreshToken = json['refresh_token'];
}
