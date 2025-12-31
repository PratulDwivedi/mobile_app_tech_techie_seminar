import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/event_service_provider.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(activeTabProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF111827),
        //color:  Color(0xFF4CAF50) ,
        border: Border(top: BorderSide(color: Color(0xFF1F2937))),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.calendar_today,
                label: 'Program',
                isActive: activeTab == 0,
                onTap: () => ref.read(activeTabProvider.notifier).state = 0,
              ),
              _NavItem(
                icon: Icons.person,
                label: 'Delegates',
                isActive: activeTab == 1,
                onTap: () => ref.read(activeTabProvider.notifier).state = 1,
              ),

              _NavItem(
                icon: Icons.card_membership,
                label: 'Exhibitors',
                isActive: activeTab == 4,
                onTap: () => ref.read(activeTabProvider.notifier).state = 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : const Color(0xFF6B7280),
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : const Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
