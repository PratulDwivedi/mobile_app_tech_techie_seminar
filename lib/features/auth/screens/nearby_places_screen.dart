import '../../common/models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../providers/auth_service_provider.dart';

class NearbyPlacesScreen extends ConsumerStatefulWidget {
  final ScreenArgsModel args;

  const NearbyPlacesScreen({required this.args, super.key});

  @override
  ConsumerState<NearbyPlacesScreen> createState() => _NearbyPlacesScreenState();
}

class _NearbyPlacesScreenState extends ConsumerState<NearbyPlacesScreen> {
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
                final data = response.data;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Container()],
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
