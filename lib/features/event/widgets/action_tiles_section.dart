import 'package:flutter/material.dart';
import '../../../config/app_constants.dart';
import '../../common/models/screen_args_model.dart';
import '../../common/services/navigation_service.dart';

class ActionTilesSection extends StatelessWidget {
  const ActionTilesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionTile(
          icon: getPageIcon('exhibition'),
          title: 'Exhibition',
          subtitle: 'Exhibition Details',
          gradientColors: [
            Color.fromARGB(255, 220, 242, 97),
            Color(0xFFF43F5E),
          ],
          onTap: () {
            NavigationService.navigateTo(
              "webview",
              arguments: ScreenArgsModel(
                routeName: "webview",
                name: "Exhibition",
                data: {"page_id": AppPageIds.exhibition},
              ),
            );
          },
        ),
        const SizedBox(height: 12),

        ActionTile(
          icon: getPageIcon('culturalProgram'),
          title: 'Cultural Program',
          subtitle: 'Cultural Program Details',
          gradientColors: [Color(0xFF6366F1), Color(0xFF9333EA)],
          onTap: () {
            NavigationService.navigateTo(
              "webview",
              arguments: ScreenArgsModel(
                routeName: "webview",
                name: "Cultural Program",
                data: {"page_id": AppPageIds.culturalProgramme},
              ),
            );
          },
        ),
        const SizedBox(height: 12),

        ActionTile(
          icon: getPageIcon('gallery'),
          title: 'Gallery',
          subtitle: 'Photos & videos',
          gradientColors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
          onTap: () {
            ScreenArgsModel screenArgsModel = ScreenArgsModel(
              routeName: AppPageRoute.gallery,
              name: "Gallery",
            );

            NavigationService.navigateTo(
              screenArgsModel.routeName,
              arguments: screenArgsModel,
            );
          },
        ),
        const SizedBox(height: 12),

        ActionTile(
          icon: getPageIcon('document'),
          title: 'Resources',
          subtitle: 'Presentations & documents',
          gradientColors: [Color(0xFF14B8A6), Color(0xFF06B6D4)],
          onTap: () {
            ScreenArgsModel screenArgsModel = ScreenArgsModel(
              routeName: AppPageRoute.documents,
              name: "Documents",
            );

            NavigationService.navigateTo(
              screenArgsModel.routeName,
              arguments: screenArgsModel,
            );
          },
        ),
      ],
    );
  }
}

class ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final VoidCallback onTap; // 👈 ADD THIS

  const ActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.onTap, // 👈 ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // 👈 USE IT
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF374151)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.chevron_right, color: Color(0xFF6B7280)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
