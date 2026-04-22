import 'package:admin/models/user.dart';
import 'package:admin/screens/superAdmin/all_users/components/user_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../provider/all_user_provider.dart';
import 'shared_widgets.dart';

class MobileUserList extends StatelessWidget {
  final List<User> users;
  final AllUsersProvider prov;

  const MobileUserList({
    Key? key,
    required this.users,
    required this.prov,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: users.length,
      separatorBuilder: (_, __) =>
          const Divider(color: Colors.white12, height: 1),
      itemBuilder: (context, i) {
        final user = users[i];
        return InkWell(
          onTap: () => showUserDetailsDialog(context, user, prov),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarWidget(name: user.name ?? '?', size: 42),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name ?? 'Unknown',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      const Gap(4),
                      Text(user.email ?? '',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white54)),
                      const Gap(8),
                      Wrap(spacing: 8, runSpacing: 6, children: [
                        RoleBadge(role: user.role ?? 'user'),
                        StatusBadge(isActive: user.isActive ?? true),
                      ]),
                    ],
                  ),
                ),
                CompactActionButtons(user: user, prov: prov),
              ],
            ),
          ),
        );
      },
    );
  }
}
