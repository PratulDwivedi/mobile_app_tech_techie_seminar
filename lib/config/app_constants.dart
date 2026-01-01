import 'package:flutter/material.dart';

class ApiRoutes {
  static const String signIn = 'seminar.fn_signin_mobile_delegate';
  static const String profile = 'seminar.fn_get_mobile_delegate';
  static const String updatePassword = 'seminar.fn_update_delegate_password';
  static const String htmlContent = 'seminar.fn_get_mobile_html_content';
  static const String summaryCount = 'seminar.fn_get_mobile_event_counts';
  static const String myAppointments =
      'seminar.fn_get_mobile_my_appointments'; //
  static const String nearbyPlaces = 'seminar.fn_get_mobile_nearby_places'; //
  static const String placesOfInterest =
      'seminar.fn_get_mobile_places_of_interest'; //
  static const String feedback = 'seminar.fn_get_mobile_feedback'; //
  static const String gallery = 'seminar.fn_get_mobile_gallery'; //
  static const String documents = 'seminar.fn_get_mobile_documents'; //
  static const String program = 'seminar.fn_get_mobile_event_schedule'; 
  static const String speakers = 'seminar.fn_get_mobile_speakers';
  static const String sponsors = 'seminar.fn_get_mobile_sponsors';
  static const String exhibitors = 'seminar.fn_get_mobile_exhibitors';
  static const String delegates = 'seminar.fn_get_mobile_delegates';
}

class AppPageRoute {
  static const String webview = 'webview';
  static const String signIn = 'signIn';
  static const String profile = 'profile';
  static const String updatePassword = 'updatePassword';
  static const String myAppointments = 'myAppointments';
  static const String nearbyPlaces = 'nearbyPlaces';
  static const String placesOfInterest = 'placesOfInterest';
  static const String bookCab = 'bookCab';
  static const String helpline = 'helpline';
  static const String feedback = 'feedback';
  static const String gallery = 'gallery';
  static const String documents = 'documents';
  static const String program = 'program';
  static const String speakers = 'speakers';
  static const String sponsors = 'sponsors';
  static const String exhibitors = 'exhibitors';
  static const String delegates = 'delegates';
  static const String exhibitorInfo = 'exhibitor_info';
}

class AppPageIds {
  static const int helpLine = 54;
  static const int fromDgDesk = 59;
  static const int exhibition = 60;
  static const int registration = 62;
  static const int aboutFai = 63;
  static const int seminarTheme = 220;
  static const int conferenceHotel = 222;
  static const int culturalProgramme = 237;
  static const int faqs = 249;
}

Map<String, IconData> pageIcons = {
  // Main Navigation Pages
  'program': Icons.calendar_today,
  'speaker': Icons.mic,
  'sponsor': Icons.speaker_notes,
  'exhibitor': Icons.card_membership,
  'delegate': Icons.people,
  'exhibition': Icons.museum,
  'culturalProgram': Icons.music_note,
  'gallery': Icons.photo_library,
  'document': Icons.download,
  'resource': Icons.download,
  'registration': Icons.receipt,

  // Bottom Navigation
  'profile': Icons.person,

  // Auth & Account
  'signIn': Icons.login,
  'updatePassword': Icons.lock,

  // Services & Features
  'myAppointment': Icons.schedule,
  'nearbyPlace': Icons.location_on,
  'placesOfInterest': Icons.explore,
  'bookCab': Icons.directions_car,
  'helpline': Icons.phone,
  'feedback': Icons.feedback,

  // Content Pages
  'aboutFai': Icons.business,
  'seminarTheme': Icons.lightbulb,
  'conferenceHotel': Icons.hotel,
  'faq': Icons.help,

  // Webview pages (using generic web icon)
  'webview': Icons.web,
};

// Helper function to get page icon
IconData getPageIcon(String pageKey) {
  return pageIcons[pageKey] ?? Icons.info;
}
