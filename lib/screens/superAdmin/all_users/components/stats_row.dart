import 'package:admin/utility/constants.dart';
import 'package:admin/utility/responsive.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../provider/all_user_provider.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AllUsersProvider>(
      builder: (context, prov, _) {
        final isMobile = Responsive.isMobile(context);
        final cards = [
          StatCard(
              label: 'Total Users',
              value: prov.totalUsers,
              icon: Icons.people_alt_rounded,
              color: const Color(0xFF667EEA)),
          StatCard(
              label: 'Admins',
              value: prov.totalAdmins,
              icon: Icons.admin_panel_settings_rounded,
              color: const Color(0xFF4CAF50)),
          StatCard(
              label: 'Pending Approval',
              value: prov.pendingAdmins,
              icon: Icons.hourglass_top_rounded,
              color: const Color(0xFFFFC107)),
          StatCard(
              label: 'Blocked',
              value: prov.blockedUsers,
              icon: Icons.block_rounded,
              color: const Color(0xFFFF6B6B)),
        ];

        if (isMobile) {
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.7,
            children: cards,
          );
        }
        return Row(
          children: cards.asMap().entries.map((e) {
            return Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(right: e.key < cards.length - 1 ? 12 : 0),
                child: e.value,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  const StatCard({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value.toString(),
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(label,
                    style: const TextStyle(fontSize: 11, color: Colors.white54),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
