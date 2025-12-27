import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

// Service providers
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService.instance;
});
