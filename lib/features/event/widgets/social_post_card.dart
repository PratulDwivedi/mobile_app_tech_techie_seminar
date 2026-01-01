import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialPostCard extends ConsumerWidget {
  const SocialPostCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = "John Doe";
    final postTime = "2 hrs ago";
    final postContent =
        "Excited to be part of this amazing event! #TechTechie2024";
    final isLiked = false;
    final likes = 24;
    final comments = "5";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF374151)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9333EA), Color(0xFFEC4899)],
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      postTime,
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            postContent,
            style: const TextStyle(color: Color(0xFFE5E7EB), fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked
                          ? const Color(0xFFEC4899)
                          : const Color(0xFF9CA3AF),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${likes}',
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Row(
                children: [
                  const Icon(
                    Icons.chat_bubble_outline,
                    color: Color(0xFF9CA3AF),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${comments}',
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.share, color: Color(0xFF9CA3AF), size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
