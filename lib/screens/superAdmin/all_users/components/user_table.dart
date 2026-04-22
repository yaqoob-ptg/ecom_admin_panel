import 'package:admin/screens/superAdmin/all_users/components/desktop_user_table.dart';
import 'package:admin/screens/superAdmin/all_users/components/mobile_user_list.dart';
import 'package:admin/utility/constants.dart';
import 'package:admin/utility/responsive.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../provider/all_user_provider.dart';

class UserTable extends StatelessWidget {
  const UserTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AllUsersProvider>(
      builder: (context, prov, _) {
        if (prov.isLoading) {
          return _shell(
              child: const Center(
            child: Padding(
                padding: EdgeInsets.all(60),
                child: CircularProgressIndicator()),
          ));
        }

        if (prov.users.isEmpty) {
          return _shell(
            child: Center(
              child: Column(children: [
                const Icon(Icons.people_outline,
                    size: 52, color: Colors.white24),
                const Gap(12),
                Text('No users found',
                    style: TextStyle(color: Colors.white38, fontSize: 15)),
              ]),
            ),
          );
        }

        final isMobile = Responsive.isMobile(context);

        return _shell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Users  (${prov.users.length})',
                      style: Theme.of(context).textTheme.titleMedium),
                  if (prov.selectedFilter == 'pending') ...[
                    const Gap(10),
                    _mini('⏳ Awaiting Approval', const Color(0xFFFFC107)),
                  ],
                ],
              ),
              const Gap(defaultPadding),
              isMobile
                  ? MobileUserList(users: prov.users, prov: prov)
                  : const DesktopUserTable(),
            ],
          ),
        );
      },
    );
  }

  Widget _shell({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  Widget _mini(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 11, color: color, fontWeight: FontWeight.w600)),
    );
  }
}
