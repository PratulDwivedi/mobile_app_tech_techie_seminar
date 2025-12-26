
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_tech_techie_seminar/features/event/models/model.dart';


final eventStatsProvider = Provider<EventStats>((ref) {
  return EventStats(
    attendees: '1,250+',   speakers: '25',
    days: '3',
  );
});

final notificationCountProvider = StateProvider<int>((ref) => 3);

final activeTabProvider = StateProvider<int>((ref) => 0);

final socialPostProvider = StateNotifierProvider<SocialPostNotifier, SocialPost>((ref) {
  return SocialPostNotifier();
});

class SocialPostNotifier extends StateNotifier<SocialPost> {
  SocialPostNotifier()
      : super(
          SocialPost(
            user: 'FAI Official',
            time: '2 min ago',
            content: 'Welcome to Day 2 of our annual seminar! Today\'s theme: Innovation in Food Safety 🎉',
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
