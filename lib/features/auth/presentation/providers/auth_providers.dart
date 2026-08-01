import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/auth_session.dart';
import '../../data/services/secure_storage_service.dart';
import '../../../../music/domain/entities/user_profile.dart';

class AuthNotifier extends StateNotifier<AuthSession> {
  AuthNotifier() : super(const AuthSession.guest()) {
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    final token = await SecureStorageService().read('session_token');
    final userId = await SecureStorageService().read('user_id');
    final providerId = await SecureStorageService().read('provider_id') ?? 'local';
    final displayName = await SecureStorageService().read('display_name') ?? 'Raaga User';

    if (token != null && userId != null) {
      state = AuthSession(
        user: UserProfile(
          userId: userId,
          displayName: displayName,
          provider: providerId,
        ),
        providerId: providerId,
        isLoggedIn: true,
      );
    }
  }

  Future<bool> login(String username, String password, {String providerId = 'local'}) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      await SecureStorageService().write('session_token', 'mock_secret_token_123');
      await SecureStorageService().write('user_id', username);
      await SecureStorageService().write('provider_id', providerId);
      await SecureStorageService().write('display_name', username);

      state = AuthSession(
        user: UserProfile(
          userId: username,
          displayName: username,
          provider: providerId,
        ),
        providerId: providerId,
        isLoggedIn: true,
      );
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await SecureStorageService().delete('session_token');
    await SecureStorageService().delete('user_id');
    await SecureStorageService().delete('provider_id');
    await SecureStorageService().delete('display_name');
    state = const AuthSession.guest();
  }
}

final authSessionProvider = StateNotifierProvider<AuthNotifier, AuthSession>((ref) {
  return AuthNotifier();
});
