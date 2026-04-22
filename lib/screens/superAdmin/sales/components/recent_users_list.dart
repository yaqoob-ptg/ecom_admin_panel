import 'package:admin/models/user.dart';
import 'package:admin/utility/constants.dart';
import 'package:admin/utility/responsive_constants.dart';
import 'package:flutter/material.dart';

class RecentUsersList extends StatelessWidget {
  final List<User> users;
  final VoidCallback onViewAll;

  const RecentUsersList({
    Key? key,
    required this.users,
    required this.onViewAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.cardPadding(context);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.md(context))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Users',
                style: TextStyle(
                  fontSize: AppFontSize.lg(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                child: const Text('View All'),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sectionGap(context)),
          if (users.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg(context)),
                child: Text(
                  'No users found',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length > 5 ? 5 : users.length,
              separatorBuilder: (_, __) => Divider(
                color: Colors.white.withOpacity(0.1),
                height: 1,
              ),
              itemBuilder: (context, index) {
                final user = users[index];
                return _RecentUserTile(user: user);
              },
            ),
        ],
      ),
    );
  }
}

class _RecentUserTile extends StatelessWidget {
  final User user;

  const _RecentUserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getRoleColor(user.role).withOpacity(0.2),
        child: Text(
          user.name?[0].toUpperCase() ?? 'U',
          style: TextStyle(color: _getRoleColor(user.role)),
        ),
      ),
      title: Text(
        user.name ?? 'Unknown',
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        user.email ?? '',
        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: _getRoleColor(user.role).withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          user.role?.toUpperCase() ?? 'USER',
          style: TextStyle(
            color: _getRoleColor(user.role),
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  Color _getRoleColor(String? role) {
    switch (role) {
      case 'admin':
        return Colors.blue;
      case 'superAdmin':
        return Colors.deepPurple;
      case 'guest':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
