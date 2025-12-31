import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_tech_techie_seminar/features/event/models/model.dart';
import 'package:mobile_app_tech_techie_seminar/features/event/services/event_service.dart';
import '../../common/models/response_message_model.dart';

final eventServiceProvider = Provider<EventService>((ref) {
  return EventService.instance;
});

class SocialPostNotifier extends StateNotifier<SocialPost> {
  SocialPostNotifier()
    : super(
        SocialPost(
          user: 'FAI Official',
          time: '2 min ago',
          content:
              'Welcome to Day 2 of our annual seminar! Today\'s theme: Innovation in Food Safety 🎉',
          likes: 142,
          comments: 28,
        ),
      );

  void toggleLike() {
    state = state.copyWith(
      isLiked: !state.isLiked,
      likes: state.isLiked ? state.likes - 1 : state.likes + 1,
    );
  }
}

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

final activeTabProvider = StateProvider<int>((ref) => 0);

final socialPostProvider =
    StateNotifierProvider<SocialPostNotifier, SocialPost>((ref) {
      return SocialPostNotifier();
    });

final selectedTabProvider = StateProvider<int>((ref) => 0);
