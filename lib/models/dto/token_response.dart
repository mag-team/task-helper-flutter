class TokenResponse {
  final String accessToken;
  final String refreshToken;

  TokenResponse.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        refreshToken = json['refresh_token'];
}
