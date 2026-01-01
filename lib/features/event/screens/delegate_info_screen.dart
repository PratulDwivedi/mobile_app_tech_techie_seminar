import 'package:flutter/material.dart';
import '../../../config/app_config.dart';
import '../../../utils/widget_utils.dart';
import '../../common/widgets/common_gradient_header_widget.dart';

class DelegateInfoScreen extends StatelessWidget {
  final Map<String, dynamic> delegate;

  const DelegateInfoScreen({super.key, required this.delegate});

  @override
  Widget build(BuildContext context) {
    final delegateName = delegate['delegate_name']?.toString() ?? 'Unknown Delegate';
    final designation = delegate['designation']?.toString() ?? '';
    final companyName = delegate['company_name']?.toString() ?? '';
    final profilePic = delegate['profile_pic']?.toString();
    final address = delegate['address1']?.toString() ?? '';
    final email = delegate['e_mail_id']?.toString() ?? '';
    final contactNo = delegate['contact_no']?.toString() ?? '';
    final biography = delegate['biography']?.toString() ?? '';
    final isUsingApp = delegate['is_using_app']?.toString() ?? '';
    final openForAppointment = delegate['open_for_appointment'] as bool? ?? false;
    final showEmail = delegate['show_email'] as bool? ?? false;
    final showContactNo = delegate['show_contact_no'] as bool? ?? false;

    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: delegateName,
          ),

          // Delegate Detailed Content
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
                          backgroundImage: profilePic != null && profilePic != 'delegate.png'
                              ? NetworkImage('${appConfig.apiBaseUrl}/$profilePic')
                              : null,
                          child: profilePic == null || profilePic == 'delegate.png'
                              ? const Icon(Icons.person, size: 60)
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          delegateName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        if (designation.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            designation,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF666666),
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        if (companyName.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            companyName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF888888),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Status Indicators
                  if (openForAppointment || isUsingApp.isNotEmpty) ...[
                    _buildInfoCard(
                      'Status',
                      [
                        if (openForAppointment)
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                  color: Color(0xFF4CAF50),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'Available for Appointment',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF4CAF50),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (isUsingApp.isNotEmpty)
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isUsingApp.contains('not using')
                                      ? const Color(0xFFFF9800).withOpacity(0.1)
                                      : const Color(0xFF2196F3).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  isUsingApp.contains('not using')
                                      ? Icons.phone_android
                                      : Icons.phone_android,
                                  size: 20,
                                  color: isUsingApp.contains('not using')
                                      ? const Color(0xFFFF9800)
                                      : const Color(0xFF2196F3),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  isUsingApp,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isUsingApp.contains('not using')
                                        ? const Color(0xFFFF9800)
                                        : const Color(0xFF2196F3),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],

                  // Contact Information
                  if ((showEmail && email.isNotEmpty) || (showContactNo && contactNo.isNotEmpty))
                    _buildInfoCard(
                      'Contact Information',
                      [
                        if (showEmail && email.isNotEmpty)
                          _buildInfoRow('Email', email),
                        if (showContactNo && contactNo.isNotEmpty)
                          _buildInfoRow('Phone', contactNo),
                      ],
                    ),

                  // Address Information
                  if (address.isNotEmpty)
                    _buildInfoCard(
                      'Address',
                      [
                        WidgetUtils.buildHtmlInfoRow('Address', address),
                      ],
                    ),

                  // Biography
                  if (biography.isNotEmpty)
                    _buildInfoCard(
                      'Biography',
                      [
                        WidgetUtils.buildHtmlInfoRow('Biography', biography),
                      ],
                    ),
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
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}
