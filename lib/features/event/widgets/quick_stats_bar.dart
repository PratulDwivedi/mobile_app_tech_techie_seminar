import 'package:flutter/material.dart';
import 'package:mobile_app_tech_techie_seminar/features/event/models/model.dart';

class QuickStatsBar extends StatelessWidget {
  final EventStats stats;

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
            icon: Icons.people,
            value: stats.attendees,
            label: 'Delegates',
          ),
          Container(width: 1, height: 40, color: Colors.white.withOpacity(0.2)),
          StatItem(icon: Icons.mic, value: stats.speakers, label: 'Speakers'),
          Container(width: 1, height: 40, color: Colors.white.withOpacity(0.2)),
          StatItem(
            icon: Icons.shop,
            value: stats.days,
            label: 'Exhibitors',
          ),
        ],
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        ),
      ],
    );
  }
}
