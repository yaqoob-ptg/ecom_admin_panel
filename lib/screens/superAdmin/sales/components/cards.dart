import 'package:admin/utility/constants.dart';
import 'package:admin/utility/responsive_constants.dart';
import 'package:flutter/material.dart';

class SuperAdminStatsCards extends StatelessWidget {
  final Map<String, dynamic> stats;

  const SuperAdminStatsCards({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final crossAxisCount = isMobile ? 2 : 4;
    final spacing = AppSpacing.itemGap(context);

    final cards = [
      _StatCardData(
        title: 'Total Users',
        value: stats['totalUsers']?.toString() ?? '0',
        icon: Icons.people,
        color: Colors.blue,
      ),
      _StatCardData(
        title: 'Total Admins',
        value: stats['byRole']?['admins']?.toString() ?? '0',
        icon: Icons.admin_panel_settings,
        color: Colors.purple,
      ),
      _StatCardData(
        title: 'Total Guests',
        value: stats['byRole']?['guests']?.toString() ?? '0',
        icon: Icons.person_outline,
        color: Colors.orange,
      ),
      _StatCardData(
        title: 'Verified Users',
        value: stats['verified']?.toString() ?? '0',
        icon: Icons.verified,
        color: Colors.green,
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      childAspectRatio: 1.2,
      children: cards.map((card) => _StatCard(data: card)).toList(),
    );
  }
}

class _StatCardData {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  _StatCardData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class _StatCard extends StatelessWidget {
  final _StatCardData data;

  const _StatCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: secondaryColor,
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.cardPadding(context).left),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.sm(context)),
              decoration: BoxDecoration(
                color: data.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.md(context)),
              ),
              child: Icon(data.icon,
                  color: data.color, size: AppIconSize.lg(context)),
            ),
            SizedBox(height: AppSpacing.sm(context)),
            Text(
              data.value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.xl(context),
                  ),
            ),
            SizedBox(height: AppSpacing.sm(context)),
            Text(
              data.title,
              style: TextStyle(
                fontSize: AppFontSize.sm(context),
                color: Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
