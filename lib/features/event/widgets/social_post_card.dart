import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app_tech_techie_seminar/features/event/providers/event_service_provider.dart';

class SocialPostCard extends ConsumerWidget {
  const SocialPostCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(socialPostProvider);

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
                      post.user,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      post.time,
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
            post.content,
            style: const TextStyle(color: Color(0xFFE5E7EB), fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              InkWell(
                onTap: () => ref.read(socialPostProvider.notifier).toggleLike(),
                child: Row(
                  children: [
                    Icon(
                      post.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: post.isLiked
                          ? const Color(0xFFEC4899)
                          : const Color(0xFF9CA3AF),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${post.likes}',
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
                    '${post.comments}',
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