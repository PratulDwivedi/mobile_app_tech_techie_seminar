import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_config.dart';
import '../../../config/app_constants.dart';
import '../../common/models/screen_args_model.dart';
import '../../common/services/navigation_service.dart';
import '../providers/event_service_provider.dart';

class DGMessageCard extends ConsumerWidget {
  const DGMessageCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(eventSummaryCountProvider);
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFBBF24), // yellow-400
            Color(0xFFF97316), // orange-500
            Color(0xFFEC4899), // pink-500
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFBBF24).withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          summaryAsync.when(
            loading: () => const SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(),
            ),
            error: (err, _) =>
                const SizedBox(width: 80, height: 80, child: Icon(Icons.error)),
            data: (response) {
              if (!response.isSuccess || response.data.isEmpty) {
                return const SizedBox(
                  width: 80,
                  height: 80,
                  child: Icon(Icons.person),
                );
              }
              final summaryData = response.data.first;
              final dgPhoto = summaryData['dg_photo']?.toString();
              return Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 4,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: dgPhoto != null && dgPhoto.isNotEmpty
                          ? Image.network(
                              '${appConfig.storageUrl}/$dgPhoto',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFD1D5DB),
                                          Color(0xFF9CA3AF),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFD1D5DB),
                                    Color(0xFF9CA3AF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'From the DG\'s Desk',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'A special message for all attendees',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    ScreenArgsModel screenArgsModel = ScreenArgsModel(
                      routeName: "webview",
                      name: "From the DG's Desk",
                      data: {"page_id": AppPageIds.fromDgDesk},
                    );

                    NavigationService.navigateTo(
                      screenArgsModel.routeName,
                      arguments: screenArgsModel,
                    );
                  },
                  icon: const Icon(Icons.book, size: 16),
                  label: const Text('Read Full Message'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
