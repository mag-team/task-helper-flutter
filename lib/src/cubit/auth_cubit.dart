import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_helper/src/models/token.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _storage = SharedPreferences.getInstance();

  AuthCubit() : super(AuthInitial()) {
    _init();
  }

  void _init() async {
    emit(AuthInProgress());

    final st = await _storage;
    final access = st.getString('access_token');
    final refresh = st.getString('refresh_token');

    if (refresh == null) return emit(AuthInitial());

    final refreshToken = Token(refresh);
    final accessToken = access != null ? Token(access) : null;

    emit(AuthSuccess(accessToken: accessToken, refreshToken: refreshToken));
  }

  Future<void> refreshToken(Token accessToken) async {
    final st = await _storage;
    st.setString('access_token', accessToken.token);
    emit((state as AuthSuccess).copyWith(accessToken: accessToken));
  }

  Future<void> login(Token refreshToken, Token accessToken) async {
    final st = await _storage;
    st.setString('refresh_token', refreshToken.token);
    st.setString('access_token', accessToken.token);
    emit(AuthSuccess(accessToken: accessToken, refreshToken: refreshToken));
  }

  Future<void> logout() async {
    final st = await _storage;
    st.remove('access_token');
    st.remove('refresh_token');
    emit(AuthInitial());
  }
}
