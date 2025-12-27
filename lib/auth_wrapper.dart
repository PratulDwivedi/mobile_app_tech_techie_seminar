import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_tech_techie_seminar/features/event/screens/seminar_home_screen.dart';
import 'package:mobile_app_tech_techie_seminar/features/user/screens/login_screen.dart';
import 'features/common/providers/riverpod/data_providers.dart';
import 'firebase/notification_service.dart';

class AuthWrapper extends ConsumerWidget {
  final NotificationServices notificationServices;

  const AuthWrapper({super.key, required this.notificationServices});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authProvider);

    // User is logged in
    if (currentUser != null) {
      notificationServices.firebaseInit(context);
      return SeminarHomeScreen();
    }

    // User is logged out
    return const LoginScreen();
  }
}
