import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './social_post_card.dart';

class LiveUpdateSection extends ConsumerWidget {
  const LiveUpdateSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.trending_up, color: Color(0xFFEC4899), size: 20),
                SizedBox(width: 8),
                Text(
                  'Live Updates',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Text(
                    'View All',
                    style: TextStyle(
                      color: Color(0xFFEC4899),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Color(0xFFEC4899), size: 20),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const SocialPostCard(),
      ],
    );
  }
}
