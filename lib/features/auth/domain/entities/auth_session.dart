import '../../../../music/domain/entities/user_profile.dart';

class AuthSession {
  final UserProfile? user;
  final String providerId;
  final bool isLoggedIn;

  const AuthSession({
    this.user,
    required this.providerId,
    this.isLoggedIn = false,
  });

  const AuthSession.guest()
      : user = null,
        providerId = 'guest',
        isLoggedIn = false;
}
