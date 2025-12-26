import 'package:flutter/material.dart';

class ActionTilesSection extends StatelessWidget {
  const ActionTilesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ActionTile(
          icon: Icons.museum,
          title: 'Exhibition',
          subtitle: 'Exhibition Details',
          badge: '250+ Photos',
          gradientColors: [
            Color.fromARGB(255, 220, 242, 97),
            Color(0xFFF43F5E),
          ],
        ),
        SizedBox(height: 12),
        ActionTile(
          icon: Icons.music_note,
          title: 'Curtual Program',
          subtitle: 'Curtual Program Details',
          badge: 'Scan to enter',
          gradientColors: [Color(0xFF6366F1), Color(0xFF9333EA)],
        ),
        SizedBox(height: 12),
        ActionTile(
          icon: Icons.photo_library,
          title: 'Gallery',
          subtitle: 'Photos & videos',
          badge: '250+ Photos',
          gradientColors: [Color(0xFFEC4899), Color(0xFFF43F5E)],
        ),

        SizedBox(height: 12),
        ActionTile(
          icon: Icons.download,
          title: 'Resources',
          subtitle: 'Presentations & documents',
          badge: '15 Files',
          gradientColors: [Color(0xFF14B8A6), Color(0xFF06B6D4)],
        ),
      ],
    );
  }
}

class ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String badge;
  final List<Color> gradientColors;

  const ActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF374151),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Icon(Icons.chevron_right, color: Color(0xFF6B7280)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
