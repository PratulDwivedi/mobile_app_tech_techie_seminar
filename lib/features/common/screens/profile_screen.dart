import 'package:mobile_app_tech_techie_seminar/config/app_config.dart';

import '../../../config/app_constants.dart';
import '../models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/common_gradient_header_widget.dart';
import '../../auth/providers/auth_service_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final ScreenArgsModel args;

  const ProfileScreen({required this.args, super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);
    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: widget.args.name,
            onRefresh: () {
              ref.invalidate(profileProvider);
            },
          ),

          // Profile Content
          Expanded(
            child: profileAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (response) {
                if (!response.isSuccess) {
                  return Center(child: Text(response.message));
                }

                // Assuming response.data contains profile info
                final profileData = response.firstOrNull ?? {};

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Profile Information',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 20),

                        // Profile Picture
                        if (profileData['profile_pic'] != null)
                          Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                '${appConfig.storageUrl}/${profileData['profile_pic']}', // Replace with actual base URL
                              ),
                              child: Icon(getPageIcon('profile'), size: 50),
                            ),
                          ),

                        const SizedBox(height: 20),

                        // Display profile fields
                        _buildProfileField(
                          'Title',
                          profileData['delegate_title']?.toString() ?? 'N/A',
                        ),
                        _buildProfileField(
                          'Full Name',
                          profileData['full_name']?.toString() ?? 'N/A',
                        ),
                        _buildProfileField(
                          'Delegate Name',
                          profileData['delegate_name']?.toString() ?? 'N/A',
                        ),
                        _buildProfileField(
                          'Email',
                          profileData['e_mail_id']?.toString() ?? 'N/A',
                        ),
                        _buildProfileField(
                          'Contact Number',
                          profileData['contact_no']?.toString() ?? 'N/A',
                        ),
                        _buildProfileField(
                          'Registration No',
                          profileData['registration_no']?.toString() ?? 'N/A',
                        ),
                        _buildProfileField(
                          'Company Name',
                          profileData['company_name']?.toString() ?? 'N/A',
                        ),
                        _buildProfileField(
                          'Designation',
                          profileData['designation']?.toString() ?? 'N/A',
                        ),
                        _buildProfileField(
                          'Biography',
                          profileData['biography']?.toString() ?? 'N/A',
                        ),
                        // Add more fields as needed
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}
