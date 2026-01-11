import '../../../config/app_config.dart';
import '../../common/models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../../event/providers/event_service_provider.dart';
import '../providers/auth_service_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookCabScreen extends ConsumerStatefulWidget {
  final ScreenArgsModel args;

  const BookCabScreen({required this.args, super.key});

  @override
  ConsumerState<BookCabScreen> createState() => _BookCabScreenState();
}

class _BookCabScreenState extends ConsumerState<BookCabScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cabsAsync = ref.watch(cabsProvider);
    const storeType = 'playstore';
    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: widget.args.name,
            onRefresh: () {
              ref.invalidate(cabsProvider);
            },
          ),

          // Profile Content
          Expanded(
            child: cabsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (response) {
                if (!response.isSuccess) {
                  return Center(child: Text(response.message));
                }
                final data = response.data as List<Map<String, dynamic>>;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...data
                            .where((element) => element['store'] == storeType)
                            .map(
                              (item) => InkWell(
                                onTap: () async {
                                  final packageName =
                                      item['package_name'] as String?;
                                  if (packageName != null) {
                                    final url =
                                        'https://play.google.com/store/apps/details?id=$packageName';
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(Uri.parse(url));
                                    }
                                  }
                                },
                                child: SizedBox(
                                  width: 150,
                                  child: Card(
                                    elevation: 1,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Image(
                                          height: 40,
                                          width: 40,
                                          image: NetworkImage(
                                            '${appConfig.storageUrl}/${item['icon']}',
                                          ),
                                        ),
                                        const Divider(),
                                        Text(item['title'] ?? ''),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
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
}
