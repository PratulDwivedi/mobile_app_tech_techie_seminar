import 'package:flutter/material.dart';
import '../../../config/app_constants.dart';
import '../../common/models/screen_args_model.dart';
import '../../common/services/navigation_service.dart';

class QuickStatsBar extends StatelessWidget {
  final Map<String, dynamic> stats;

  const QuickStatsBar({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StatItem(
            icon: getPageIcon('delegate'),
            value: stats['delegates'] ?? 0, 
            label: 'Delegates',
            onTap: () {
              final screenArgs = ScreenArgsModel(
                routeName: AppPageRoute.delegates,
                name: "Delegates",
              );
              NavigationService.navigateTo(
                screenArgs.routeName,
                arguments: screenArgs,
              );
            },
          ),
          _divider(context),
          StatItem(
            icon: getPageIcon('speaker'),
            value: stats['speakers'] ?? 0, 
            label: 'Speakers',
            onTap: () {
              final screenArgs = ScreenArgsModel(
                routeName: AppPageRoute.speakers,
                name: "Speakers",
              );
              NavigationService.navigateTo(
                screenArgs.routeName,
                arguments: screenArgs,
              );
            },
          ),
          _divider(context),
          StatItem(
            icon: getPageIcon('exhibitor'),
            value: stats['exhibitors'] ?? 0, 
            label: 'Exhibitors',
            onTap: () {
              final screenArgs = ScreenArgsModel(
                routeName: AppPageRoute.exhibitors,
                name: "Exhibitors",
              );
              NavigationService.navigateTo(
                screenArgs.routeName,
                arguments: screenArgs,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white.withOpacity(0.2),
    );
  }
}

class StatItem extends StatelessWidget {
  final IconData icon;
  final int value; // ✅ int
  final String label;
  final VoidCallback? onTap;

  const StatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
            Text(
              value.toString(), // ✅ safe
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
