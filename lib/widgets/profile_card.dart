// import 'package:admin/utility/constants.dart';
// import 'package:admin/utility/extensions.dart';
// import 'package:flutter/material.dart';
//
// class ProfileCard extends StatelessWidget {
//   const ProfileCard({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: defaultPadding),
//       padding: EdgeInsets.symmetric(
//         horizontal: defaultPadding,
//         vertical: defaultPadding / 2,
//       ),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//         border: Border.all(color: Colors.white10),
//       ),
//       child: Row(
//         children: [
//           Image.asset(
//             "assets/images/profile_pic.png",
//             height: 38,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
//             child: Text("${context.userProvider.getLoginUsr()?.name}"),
//           ),
//           Icon(Icons.keyboard_arrow_down),
//         ],
//       ),
//     );
//   }
// }

import 'package:admin/screens/login/provider/user_provider.dart';
import 'package:admin/utility/constants.dart';
import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final GlobalKey _menuKey = GlobalKey();

  void _showDropdown() {
    final RenderBox renderBox =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + 4,
        offset.dx + size.width,
        offset.dy + size.height + 4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.white10),
      ),
      color: secondaryColor,
      items: <PopupMenuEntry<dynamic>>[
        PopupMenuItem<dynamic>(
          onTap: () {
            // TODO: Navigate to Edit Profile screen
          },
          child: const Row(
            children: [
              Icon(Icons.person_outline, size: 18, color: Colors.white70),
              SizedBox(width: 10),
              Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<dynamic>(
          onTap: () {
            Future.microtask(() {
              context.read<UserProvider>().logOutUser();
            });
          },
          child: const Row(
            children: [
              Icon(Icons.logout, size: 18, color: Colors.redAccent),
              SizedBox(width: 10),
              Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDropdown,
      child: Container(
        key: _menuKey,
        margin: const EdgeInsets.only(left: defaultPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            final user = userProvider.user;
            return Row(
              children: [
                Image.asset(
                  "assets/images/profile_pic.png",
                  height: 38,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  child: Text("${user?.name ?? 'User'}"),
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            );
          },
          // child: Row(
          //   children: [
          //     Image.asset(
          //       "assets/images/profile_pic.png",
          //       height: 38,
          //     ),
          //     Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
          //       child: Text("${context.userProvider.getLoginUsr()?.name}"),
          //     ),
          //     const Icon(Icons.keyboard_arrow_down),
          //   ],
          // ),
        ),
      ),
    );
  }
}
