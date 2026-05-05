// import 'package:admin/utility/extensions.dart';

// import 'components/notification_header.dart';
// import 'components/notification_list_section.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import '../../utility/constants.dart';
// import 'components/send_notification_form.dart';

// class NotificationScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         primary: false,
//         padding: EdgeInsets.all(defaultPadding),
//         child: Column(
//           children: [
//             NotificationHeader(),
//             Gap(defaultPadding),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 5,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               "My Notification",
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           ElevatedButton.icon(
//                             style: TextButton.styleFrom(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: defaultPadding * 1.5,
//                                 vertical: defaultPadding,
//                               ),
//                             ),
//                             onPressed: () {
//                               sendNotificationFormForm(context);
//                             },
//                             icon: Icon(Icons.add),
//                             label: Text("Send New"),
//                           ),
//                           Gap(20),
//                           IconButton(
//                               onPressed: () {
//                                 context.dataProvider
//                                     .getAllNotifications(showSnack: true);
//                               },
//                               icon: Icon(Icons.refresh)),
//                         ],
//                       ),
//                       Gap(defaultPadding),
//                       NotificationListSection(),
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:admin/utility/extensions.dart';
import 'components/notification_header.dart';
import 'components/notification_list_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import '../../utility/responsive_constants.dart';
import 'components/send_notification_form.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobileS = AppBreakpoints.isMobileS(context);
    final padding = AppSpacing.pagePadding(context);
    final gap = AppSpacing.sectionGap(context);
    final smallGap = AppSpacing.itemGap(context);

    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NotificationHeader(),
            Gap(gap),
            isMobileS
                ? _buildToolbarStacked(context, smallGap)
                : _buildToolbarRow(context, smallGap),
            Gap(gap),
            const NotificationListSection(),
          ],
        ),
      ),
    );
  }

  // Mobile S: title stacked above buttons
  Widget _buildToolbarStacked(BuildContext context, double gap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Notifications",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: AppFontSize.sectionTitle(context),
              ),
        ),
        Gap(gap),
        Row(
          children: [
            _sendNewButton(context),
            const Spacer(),
            _refreshButton(context),
          ],
        ),
      ],
    );
  }

  // Tablet / Web: single row
  Widget _buildToolbarRow(BuildContext context, double gap) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "My Notifications",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
        ),
        _sendNewButton(context),
        Gap(gap),
        _refreshButton(context),
      ],
    );
  }

  Widget _sendNewButton(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md(context),
          vertical: AppSpacing.sm(context),
        ),
      ),
      onPressed: () => sendNotificationFormForm(context),
      icon: Icon(Icons.send, size: AppIconSize.sm(context)),
      label: Text("Send New",
          style: TextStyle(fontSize: AppFontSize.body(context))),
    );
  }

  Widget _refreshButton(BuildContext context) {
    return IconButton(
      onPressed: () =>
          context.dataProvider.getAllNotifications(showSnack: true),
      icon: Icon(Icons.refresh, size: AppIconSize.md(context)),
      tooltip: 'Refresh',
    );
  }
}
