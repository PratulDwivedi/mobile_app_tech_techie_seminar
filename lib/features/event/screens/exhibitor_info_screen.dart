import '../../../config/app_config.dart';
import '../../common/models/screen_args_model.dart';
import 'package:flutter/material.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../models/exhibitor.dart';

class ExhibitorInfoScreen extends StatelessWidget {
  final ScreenArgsModel args;

  const ExhibitorInfoScreen({required this.args, super.key});

  @override
  Widget build(BuildContext context) {
    final exhibitor = Exhibitor.fromJson(args.data);

    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: exhibitor.exhibitorName,
          ),

          // Exhibitor Detailed Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo and Basic Info
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.grey[200],
                          ),
                          child: exhibitor.filePath != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    '${appConfig.apiBaseUrl}/${exhibitor.filePath}',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.business,
                                        size: 60,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                )
                              : const Icon(
                                  Icons.business,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          exhibitor.exhibitorName,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF333333),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (exhibitor.shortName.isNotEmpty) ...[
                          const SizedBox(height: 8.0),
                          Text(
                            exhibitor.shortName,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  // Description
                  if (exhibitor.exhibitorDescr != null &&
                      exhibitor.exhibitorDescr!.isNotEmpty) ...[
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      exhibitor.exhibitorDescr!,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF666666),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                  ],

                  // Contact Information
                  const Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // Contact Person
                  if (exhibitor.contactPerson != null &&
                      exhibitor.contactPerson!.isNotEmpty) ...[
                    _buildInfoRow(
                      icon: Icons.person,
                      label: 'Contact Person',
                      value: exhibitor.contactPerson!,
                    ),
                    const SizedBox(height: 12.0),
                  ],

                  // Contact Number
                  if (exhibitor.contactPersonNo != null &&
                      exhibitor.contactPersonNo!.isNotEmpty) ...[
                    _buildInfoRow(
                      icon: Icons.phone,
                      label: 'Phone',
                      value: exhibitor.contactPersonNo!,
                    ),
                    const SizedBox(height: 12.0),
                  ],

                  // Email
                  if (exhibitor.emailId != null &&
                      exhibitor.emailId!.isNotEmpty) ...[
                    _buildInfoRow(
                      icon: Icons.email,
                      label: 'Email',
                      value: exhibitor.emailId!,
                    ),
                    const SizedBox(height: 12.0),
                  ],

                  // Website
                  if (exhibitor.exhibitorWebUrl != null &&
                      exhibitor.exhibitorWebUrl!.isNotEmpty) ...[
                    _buildInfoRow(
                      icon: Icons.web,
                      label: 'Website',
                      value: exhibitor.exhibitorWebUrl!,
                    ),
                    const SizedBox(height: 12.0),
                  ],

                  // Address
                  if (exhibitor.exhibitorAddress != null &&
                      exhibitor.exhibitorAddress!.isNotEmpty) ...[
                    _buildInfoRow(
                      icon: Icons.location_on,
                      label: 'Address',
                      value: exhibitor.exhibitorAddress!,
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

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20.0,
          color: const Color(0xFF4CAF50),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
