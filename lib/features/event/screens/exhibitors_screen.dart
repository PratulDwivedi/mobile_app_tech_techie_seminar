import 'package:mobile_app_tech_techie_seminar/config/app_config.dart';
import 'package:mobile_app_tech_techie_seminar/config/app_constants.dart';

import '../../common/models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../models/exhibitor.dart';
import '../providers/event_service_provider.dart';
import 'exhibitor_info_screen.dart';

class ExhibitorsScreen extends ConsumerStatefulWidget {
  final ScreenArgsModel args;

  const ExhibitorsScreen({required this.args, super.key});

  @override
  ConsumerState<ExhibitorsScreen> createState() => _ExhibitorsScreenState();
}

class _ExhibitorsScreenState extends ConsumerState<ExhibitorsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final exhibitorsAsync = ref.watch(exhibitorsProvider);
    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: widget.args.name,
            onRefresh: () {
              ref.invalidate(exhibitorsProvider);
            },
          ),

          // Profile Content
          Expanded(
            child: exhibitorsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (response) {
                if (!response.isSuccess) {
                  return Center(child: Text(response.message));
                }

                final exhibitorsData = (response.data as List?) ?? [];
                final exhibitors = exhibitorsData
                    .map((e) => Exhibitor.fromJson(e))
                    .toList();

                if (exhibitors.isEmpty) {
                  return const Center(child: Text('No exhibitors available'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: exhibitors.length,
                  itemBuilder: (context, index) {
                    final exhibitor = exhibitors[index];
                    return ExhibitorCard(
                      exhibitor: exhibitor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExhibitorInfoScreen(
                              args: ScreenArgsModel(
                                routeName: AppPageRoute.exhibitorInfo,
                                name: exhibitor.exhibitorName,
                                data: exhibitor.toJson(),
                              ),
                            ),
                          ),
                        );
                      },
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

class ExhibitorCard extends StatelessWidget {
  final Exhibitor exhibitor;
  final VoidCallback onTap;

  const ExhibitorCard({
    super.key,
    required this.exhibitor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Logo
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),
                child: exhibitor.filePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          '${appConfig.apiBaseUrl} /${exhibitor.filePath}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.business,
                              size: 30,
                              color: Colors.grey,
                            );
                          },
                        ),
                      )
                    : const Icon(Icons.business, size: 30, color: Colors.grey),
              ),
              const SizedBox(width: 16.0),
              // Exhibitor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exhibitor.exhibitorName,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (exhibitor.shortName.isNotEmpty) ...[
                      const SizedBox(height: 4.0),
                      Text(
                        exhibitor.shortName,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                    if (exhibitor.exhibitorDescr != null &&
                        exhibitor.exhibitorDescr!.isNotEmpty) ...[
                      const SizedBox(height: 8.0),
                      Text(
                        exhibitor.exhibitorDescr!,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF666666),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
