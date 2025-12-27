import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/current_user.dart';
import '../services/auth_service.dart';

/// 🔐 Auth State = CurrentUser (NOT Supabase)
final authProvider = StateNotifierProvider<AuthNotifier, CurrentUser?>(
  (ref) => AuthNotifier(ref),
);

class AuthNotifier extends StateNotifier<CurrentUser?> {
  AuthNotifier(this.ref) : super(null) {
    loadUser();
  }

  final Ref ref;

  /// Load user from SharedPreferences on app start
  Future<void> loadUser() async {
    state = await ref.read(authServiceProvider).getCurrentUser();
  }
}

/// 👤 User Profile Provider (derived from CurrentUser)
final userProfileProvider = Provider<Map<String, dynamic>?>((ref) {
  final user = ref.watch(authProvider);
  return user?.toJson();
});

/// ✅ Simple boolean auth check (useful for guards)
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider) != null;
});

// Service providers
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService.instance;
});
