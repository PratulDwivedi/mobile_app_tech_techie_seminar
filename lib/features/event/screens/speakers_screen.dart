import 'package:mobile_app_tech_techie_seminar/config/app_constants.dart';

import '../../../config/app_config.dart';
import '../../common/models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../providers/event_service_provider.dart';
import 'speaker_info_screen.dart';

class SpeakersScreen extends ConsumerStatefulWidget {
  final ScreenArgsModel args;

  const SpeakersScreen({required this.args, super.key});

  @override
  ConsumerState<SpeakersScreen> createState() => _SpeakersScreenState();
}

class _SpeakersScreenState extends ConsumerState<SpeakersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final speakersAsync = ref.watch(speakersProvider);
    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: widget.args.name,
            onRefresh: () {
              ref.invalidate(programSpeakerWiseProvider);
            },
          ),

          // Speakers Content
          Expanded(
            child: speakersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (response) {
                if (!response.isSuccess) {
                  return Center(child: Text(response.message));
                }

                final speakersData = (response.data as List?) ?? [];

                if (speakersData.isEmpty) {
                  return const Center(child: Text('No speakers available'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: speakersData.length,
                  itemBuilder: (context, index) {
                    final speaker = speakersData[index] as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SpeakerInfoScreen(speaker: speaker),
                          ),
                        );
                      },
                      child: SpeakerCard(speaker: speaker),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SpeakerCard extends StatelessWidget {
  final Map<String, dynamic> speaker;

  const SpeakerCard({super.key, required this.speaker});

  @override
  Widget build(BuildContext context) {
    final speakerName =
        speaker['speaker_name']?.toString() ?? 'Unknown Speaker';
    final designation = speaker['designation']?.toString() ?? '';
    final profilePic = speaker['profile_pic']?.toString();
    final biography = speaker['biography']?.toString() ?? '';
    final abstract_paper_title =
        speaker['abstract_paper_title']?.toString() ?? '';
    final themeDate = speaker['theme_date']?.toString() ?? '';
    final companyName = speaker['company_name']?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Speaker Header with Photo and Basic Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 40,

                  backgroundImage: profilePic != null
                      ? NetworkImage(
                          '${appConfig.storageUrl}/${profilePic}',
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                // Speaker Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        speakerName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      if (designation.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          designation,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      if (companyName.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          companyName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF888888),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            // Presenting Information
            if (themeDate.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.event,
                          size: 16,
                          color: Color(0xFF4CAF50),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            themeDate,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF4CAF50),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            abstract_paper_title,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF4CAF50),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Biography
            if (biography.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                'Biography',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                biography,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF666666),
                  height: 1.4,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
