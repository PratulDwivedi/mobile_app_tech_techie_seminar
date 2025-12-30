import 'package:flutter/material.dart';
import 'package:mobile_app_tech_techie_seminar/features/auth/screens/login_screen.dart';
import '../../event/screens/seminar_home_screen.dart';
import '../models/screen_args_model.dart';
import '../screens/chat_screen.dart';
import '../screens/web_view_screen.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final Map<String, WidgetBuilder> _routes = {
    'login': (context) => const LoginScreen(),
    'home': (context) => const SeminarHomeScreen(),
    'chat': (context) => const ChatScreen(),
  };

  static void navigateTo(String routeName, {Object? arguments}) {
    if (_routes.containsKey(routeName)) {
      navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
    } else {
      ScreenArgsModel args;
      if (arguments is ScreenArgsModel) {
        args = arguments;
      } else if (arguments is Map<String, dynamic>) {
        args = ScreenArgsModel(
          routeName: routeName,
          name: routeName,
          data: arguments,
        );
      } else {
        args = ScreenArgsModel(routeName: routeName, name: routeName);
      }
      if (routeName == "webview") {
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (context) => WebViewScreen(args: args)),
        );
      }
    }
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final builder = _routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }
    // If route is not in map, it might be a dynamic route handled by navigateTo
    return null;
  }

  static Future<dynamic>? clearAndNavigate(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}
