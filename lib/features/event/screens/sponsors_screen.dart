import '../../common/models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../providers/event_service_provider.dart';
import 'sponsor_info_screen.dart';

class SponsorsScreen extends ConsumerStatefulWidget {
  final ScreenArgsModel args;

  const SponsorsScreen({required this.args, super.key});

  @override
  ConsumerState<SponsorsScreen> createState() => _SponsorsScreenState();
}

class _SponsorsScreenState extends ConsumerState<SponsorsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sponsorsAsync = ref.watch(sponsorsProvider);
    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: widget.args.name,
            onRefresh: () {
              ref.invalidate(sponsorsProvider);
            },
          ),

          // Sponsors Content
          Expanded(
            child: sponsorsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (response) {
                if (!response.isSuccess) {
                  return Center(child: Text(response.message));
                }

                final sponsorsData = (response.data as List?) ?? [];

                if (sponsorsData.isEmpty) {
                  return const Center(child: Text('No sponsors available'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: sponsorsData.length,
                  itemBuilder: (context, index) {
                    final sponsor = sponsorsData[index] as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SponsorInfoScreen(sponsor: sponsor),
                          ),
                        );
                      },
                      child: SponsorCard(sponsor: sponsor),
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

class SponsorCard extends StatelessWidget {
  final Map<String, dynamic> sponsor;

  const SponsorCard({super.key, required this.sponsor});

  @override
  Widget build(BuildContext context) {
    final sponsorName = sponsor['sponsor_name']?.toString() ?? 'Unknown Sponsor';
    final sponsorType = sponsor['sponsor_type']?.toString() ?? '';
    final logoPath = sponsor['sponser_logo_path']?.toString();
    final address = sponsor['address']?.toString() ?? '';
    final description = sponsor['sponser_descr']?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sponsor Header with Logo and Basic Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sponsor Logo
                CircleAvatar(
                  radius: 40,
                  backgroundImage: logoPath != null
                      ? NetworkImage('https://your-api-base-url/$logoPath')
                      : null,
                  child: logoPath == null
                      ? const Icon(Icons.business, size: 40)
                      : null,
                ),
                const SizedBox(width: 16),
                // Sponsor Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sponsorName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      if (sponsorType.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getSponsorTypeColor(sponsorType),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: _getSponsorTypeColor(sponsorType).withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getSponsorTypeIcon(sponsorType),
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                sponsorType.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            // Address
            if (address.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: Color(0xFF666666),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // Description
            if (description.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF666666),
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getSponsorTypeColor(String sponsorType) {
    switch (sponsorType.toLowerCase()) {
      case 'diamond':
        return const Color(0xFF2196F3); // Bright blue for diamond
      case 'gold':
        return const Color(0xFFFFA000); // Orange for gold
      case 'silver':
        return const Color(0xFF757575); // Dark gray for silver
      default:
        return const Color(0xFF4CAF50); // Default green
    }
  }

  IconData _getSponsorTypeIcon(String sponsorType) {
    switch (sponsorType.toLowerCase()) {
      case 'diamond':
        return Icons.diamond;
      case 'gold':
        return Icons.star;
      case 'silver':
        return Icons.star_border;
      default:
        return Icons.business;
    }
  }
}
