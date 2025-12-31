import 'package:flutter/material.dart';
import '../../common/widgets/widget_utils.dart';
import '../../common/widgets/common_gradient_header_widget.dart';

class SpeakerInfoScreen extends StatelessWidget {
  final Map<String, dynamic> speaker;

  const SpeakerInfoScreen({super.key, required this.speaker});

  @override
  Widget build(BuildContext context) {
    final speakerName = speaker['speaker_name']?.toString() ?? 'Unknown Speaker';
    final designation = speaker['designation']?.toString() ?? '';
    final profilePic = speaker['profile_pic']?.toString();
    final biography = speaker['biography']?.toString() ?? '';
    final presentingAt = speaker['presenting_at']?.toString() ?? '';
    final companyName = speaker['company_name']?.toString() ?? '';
    final eMailId = speaker['e_mail_id']?.toString() ?? '';
    final contactNo = speaker['contact_no']?.toString() ?? '';
    final themeTitle = speaker['theme_title']?.toString() ?? '';
    final abstractPaperTitle = speaker['abstract_paper_title']?.toString() ?? '';
    final speakerTitle = speaker['speaker_title']?.toString() ?? '';

    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: speakerName,
          ),

          // Speaker Detailed Content
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
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: profilePic != null
                              ? NetworkImage('https://your-api-base-url/$profilePic')
                              : null,
                          child: profilePic == null
                              ? const Icon(Icons.person, size: 60)
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          speakerName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (speakerTitle.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            speakerTitle,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF666666),
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Detailed Information Cards
                  _buildInfoCard(
                    'Professional Information',
                    [
                      if (designation.isNotEmpty) _buildInfoRow('Designation', designation),
                      if (companyName.isNotEmpty) _buildInfoRow('Company', companyName),
                      if (themeTitle.isNotEmpty) _buildInfoRow('Theme', themeTitle),
                    ],
                  ),

                  const SizedBox(height: 16),

                  if (presentingAt.isNotEmpty)
                    _buildInfoCard(
                      'Presentation Details',
                      [
                        WidgetUtils.buildHtmlInfoRow('Presenting At', presentingAt),
                        if (abstractPaperTitle.isNotEmpty)
                          _buildInfoRow('Paper Title', abstractPaperTitle),
                      ],
                    ),

                  const SizedBox(height: 16),

                  _buildInfoCard(
                    'Contact Information',
                    [
                      if (eMailId.isNotEmpty) _buildInfoRow('Email', eMailId),
                      if (contactNo.isNotEmpty) _buildInfoRow('Contact', contactNo),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Biography Section
                  if (biography.isNotEmpty) ...[
                    const Text(
                      'Biography',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Text(
                        biography,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    if (children.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF555555),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
