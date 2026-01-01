import 'package:flutter/material.dart';
import '../../../config/app_config.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../../common/widgets/widget_utils.dart';

class SponsorInfoScreen extends StatelessWidget {
  final Map<String, dynamic> sponsor;

  const SponsorInfoScreen({super.key, required this.sponsor});

  @override
  Widget build(BuildContext context) {
    final sponsorName =
        sponsor['sponsor_name']?.toString() ?? 'Unknown Sponsor';
    final sponsorType = sponsor['sponsor_type']?.toString() ?? '';
    final logoPath = sponsor['sponser_logo_path']?.toString();
    final address = sponsor['address']?.toString() ?? '';
    final description = sponsor['sponser_descr']?.toString() ?? '';
    final contactPerson = sponsor['contact_person']?.toString() ?? '';
    final webUrl = sponsor['sponser_web_url']?.toString() ?? '';
    final contactNumber = sponsor['contact_person_no']?.toString() ?? '';

    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(title: sponsorName),

          // Sponsor Detailed Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Picture and Basic Info
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // Adjust radius as needed
                            image: DecorationImage(
                              image: NetworkImage(
                                '${appConfig.storageUrl}/${logoPath}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          sponsorName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (sponsorType.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _getSponsorTypeColor(sponsorType),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: _getSponsorTypeColor(
                                    sponsorType,
                                  ).withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getSponsorTypeIcon(sponsorType),
                                  size: 20,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  sponsorType.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 16,
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

                  const SizedBox(height: 24),

                  // Contact Information
                  if (contactPerson.isNotEmpty ||
                      contactNumber.isNotEmpty ||
                      webUrl.isNotEmpty)
                    _buildInfoCard('Contact Information', [
                      if (contactPerson.isNotEmpty)
                        _buildInfoRow('Contact Person', contactPerson),
                      if (contactNumber.isNotEmpty)
                        _buildInfoRow('Phone', contactNumber),
                      if (webUrl.isNotEmpty) _buildInfoRow('Website', webUrl),
                    ]),

                  // Address Information
                  if (address.isNotEmpty)
                    _buildInfoCard('Address', [
                      _buildInfoRow('Address', address),
                    ]),

                  // Description
                  if (description.isNotEmpty)
                    _buildInfoCard('Description', [
                      WidgetUtils.buildHtmlInfoRow('Description', description),
                    ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF555555),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
          ),
        ],
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
