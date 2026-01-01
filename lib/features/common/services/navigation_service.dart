import 'package:flutter/material.dart';
import '../../../config/app_constants.dart';
import '../../auth/screens/login_screen.dart';
import '../../event/screens/delegates_screen.dart';
import '../../event/screens/documents_screen.dart';
import '../../event/screens/exhibitor_info_screen.dart';
import '../../event/screens/exhibitors_screen.dart';
import '../../event/screens/gallery_screen.dart';
import '../../event/screens/program_screen.dart';
import '../../event/screens/seminar_home_screen.dart';
import '../../event/screens/speakers_screen.dart';
import '../../event/screens/sponsors_screen.dart';
import '../models/screen_args_model.dart';
import '../screens/book_cab_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/feedback_screen.dart';
import '../screens/my_appointments_screen.dart';
import '../screens/nearby_places_screen.dart';
import '../screens/places_of_interest_screen.dart';
import '../screens/profile_screen.dart';
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

      switch (routeName) {
        case AppPageRoute.webview:
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => WebViewScreen(args: args)),
          );
          break;
        case AppPageRoute.profile:
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => ProfileScreen(args: args)),
          );
          break;
        case AppPageRoute.updatePassword:
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => ProfileScreen(args: args)),
          );
          break;
        case AppPageRoute.myAppointments:
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => MyAppointmentsScreen(args: args),
            ),
          );
          break;
        case AppPageRoute.nearbyPlaces:
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => NearbyPlacesScreen(args: args),
            ),
          );
          break;
        case AppPageRoute.placesOfInterest:
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => PlacesOfInterestScreen(args: args),
            ),
          );
          break;
        case AppPageRoute.bookCab:
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => BookCabScreen(args: args)),
          );
          break;
        case AppPageRoute.feedback:
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => FeedbackScreen(args: args)),
          );
          break;
        case AppPageRoute.gallery:
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => GalleryScreen(args: args)),
          );
          break;
        case AppPageRoute.documents:
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => DocumentsScreen(args: args),
            ),
          );
          break;
        case AppPageRoute.program:
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => ProgramScreen(args: args)),
          );
          break;
        case AppPageRoute.speakers:
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => SpeakersScreen(args: args)),
          );
          break;
        case AppPageRoute.sponsors:
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => SponsorsScreen(args: args)),
          );
          break;
        case AppPageRoute.exhibitors:
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => ExhibitorsScreen(args: args),
            ),
          );
          break;
        case AppPageRoute.delegates:
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => DelegatesScreen(args: args),
            ),
          );
          break;
        case AppPageRoute.exhibitorInfo:
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => ExhibitorInfoScreen(args: args),
            ),
          );
          break;
        default:
          // Handle unknown routes or do nothing
          break;
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
