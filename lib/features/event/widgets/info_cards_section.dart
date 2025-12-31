import 'package:flutter/material.dart';
import '../../../config/app_constants.dart';
import '../../common/models/screen_args_model.dart';
import '../../common/services/navigation_service.dart';

class InfoCardsSection extends StatelessWidget {
  const InfoCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InfoCard(
            icon: Icons.book,
            title: 'About FAI',
            gradientColors: const [Color(0xFF3B82F6), Color(0xFF2563EB)],
            onTap: () {
              ScreenArgsModel screenArgsModel = ScreenArgsModel(
                routeName: "webview",
                name: "About FAI",
                data: {"page_id": AppPageIds.aboutFai},
              );

              NavigationService.navigateTo(
                screenArgsModel.routeName,
                arguments: screenArgsModel,
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InfoCard(
            icon: Icons.star,
            title: 'Theme & Highlights',
            gradientColors: const [Color(0xFFF59E0B), Color(0xFFF97316)],
            onTap: () {
              ScreenArgsModel screenArgsModel = ScreenArgsModel(
                routeName: "webview",
                name: "Theme & Highlights",
                data: {"page_id": AppPageIds.seminarTheme},
              );

              NavigationService.navigateTo(
                screenArgsModel.routeName,
                arguments: screenArgsModel,
              );
            },
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
