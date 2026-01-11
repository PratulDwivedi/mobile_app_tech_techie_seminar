import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_tech_techie_seminar/features/event/models/delegates_provider_params.dart';
import 'package:mobile_app_tech_techie_seminar/features/event/services/event_service.dart';
import '../../common/models/response_message_model.dart';

final eventServiceProvider = Provider<EventService>((ref) {
  return EventService.instance;
});

// HTML Content Provider (for a specific page)
final htmlContentProvider = FutureProvider.family<ResponseMessageModel, int>((
  ref,
  pageId,
) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getHtmlContent(pageId);
});

final eventSummaryCountProvider = FutureProvider<ResponseMessageModel>((
  ref,
) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getSummaryCount();
});

final programDateWiseProvider = FutureProvider<ResponseMessageModel>((
  ref,
) async {
  final service = ref.watch(eventServiceProvider);

  return await service.getProgramDateWise();
});

final programSessionWiseProvider = FutureProvider<ResponseMessageModel>((
  ref,
) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getProgramSessionWise();
});

final programSpeakerWiseProvider = FutureProvider<ResponseMessageModel>((
  ref,
) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getProgramSpeakerWise();
});

final speakersProvider = FutureProvider<ResponseMessageModel>((ref) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getSpeakers();
});

final sponsorsProvider = FutureProvider<ResponseMessageModel>((ref) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getSponsors();
});

final exhibitorsProvider = FutureProvider<ResponseMessageModel>((ref) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getExhibitors();
});

final bannersProvider = FutureProvider<ResponseMessageModel>((ref) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getBanners();
});

final cabsProvider = FutureProvider<ResponseMessageModel>((ref) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getBookCabs();
});

final nearByPlacesProvider = FutureProvider<ResponseMessageModel>((ref) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getNearbyPlaces();
});

final placesOfInterestsProvider = FutureProvider<ResponseMessageModel>((
  ref,
) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getPlacesOfInterests();
});

final appointmentsProvider = FutureProvider<ResponseMessageModel>((ref) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getAppointments();
});

final feedbackParamsProvider = FutureProvider<ResponseMessageModel>((
  ref,
) async {
  final service = ref.watch(eventServiceProvider);
  return await service.getFeedbackParams();
});

final delegatesProvider =
    FutureProvider.family<ResponseMessageModel, DelegatesProviderParams>((
      ref,
      params,
    ) async {
      final service = ref.watch(eventServiceProvider);
      return await service.getDelegatesWithFilter(params.pageNo, params.filter);
    });

final selectedTabProvider = StateProvider<int>((ref) => 0);
