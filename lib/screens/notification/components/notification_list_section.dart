// import 'package:admin/utility/extensions.dart';

// import '../../../core/data/data_provider.dart';
// import '../../../models/my_notification.dart';
// import 'view_notification_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/color_list.dart';
// import '../../../utility/constants.dart';

// class NotificationListSection extends StatelessWidget {
//   const NotificationListSection({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "All Notification",
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Consumer<DataProvider>(
//               builder: (context, dataProvider, child) {
//                 return DataTable(
//                   columnSpacing: defaultPadding,
//                   // minWidth: 600,
//                   columns: [
//                     DataColumn(
//                       label: Text("Title"),
//                     ),
//                     DataColumn(
//                       label: Text("Description"),
//                     ),
//                     DataColumn(
//                       label: Text("Send Date"),
//                     ),
//                     DataColumn(
//                       label: Text("View"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     dataProvider.notifications.length,
//                     (index) => notificationDataRow(
//                         dataProvider.notifications[index], index + 1, edit: () {
//                       viewNotificationStatics(
//                           context, dataProvider.notifications[index]);
//                     }, delete: () {
//                       context.notificationProvider.deleteNotification(
//                           dataProvider.notifications[index]);
//                     }),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// DataRow notificationDataRow(MyNotification notificationInfo, int index,
//     {Function? edit, Function? delete}) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             Container(
//               height: 24,
//               width: 24,
//               decoration: BoxDecoration(
//                 color: colors[index % colors.length],
//                 shape: BoxShape.circle,
//               ),
//               child: Center(child: Text(index.toString())),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(notificationInfo.title!),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(notificationInfo.description ?? '')),
//       DataCell(Text(notificationInfo.createdAt ?? '')),
//       DataCell(IconButton(
//           onPressed: () {
//             if (edit != null) edit();
//           },
//           icon: Icon(
//             Icons.remove_red_eye_sharp,
//             color: Colors.white,
//           ))),
//       DataCell(IconButton(
//           onPressed: () {
//             if (delete != null) delete();
//           },
//           icon: Icon(
//             Icons.delete,
//             color: Colors.red,
//           ))),
//     ],
//   );
// }

import 'package:admin/utility/extensions.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/my_notification.dart';
import 'view_notification_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../sub_category/components/add_sub_category_form.dart'
    show showDeleteConfirmationDialog;

class NotificationListSection extends StatelessWidget {
  const NotificationListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
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
          Text(
            "All Notifications",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
          SizedBox(height: AppSpacing.sectionGap(context)),
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              return isMobile
                  ? _MobileNotificationList(
                      notifications: dataProvider.notifications)
                  : _DesktopNotificationTable(
                      notifications: dataProvider.notifications);
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DESKTOP TABLE
// ─────────────────────────────────────────────────────────────────────────────
class _DesktopNotificationTable extends StatelessWidget {
  final List<MyNotification> notifications;
  const _DesktopNotificationTable({required this.notifications});

  static const double _minTableWidth = 580.0;

  @override
  Widget build(BuildContext context) {
    final cellFontSize = AppFontSize.tableCell(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final needsScroll = constraints.maxWidth < _minTableWidth;

        final table = DataTable(
          columnSpacing: 12,
          horizontalMargin: 10,
          headingTextStyle: TextStyle(
            fontSize: cellFontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
          dataTextStyle: TextStyle(fontSize: cellFontSize, color: Colors.white),
          columns: const [
            DataColumn(label: Text("Title")),
            DataColumn(label: Text("Description")),
            DataColumn(label: Text("Send Date")),
            DataColumn(label: Text("View")),
            DataColumn(label: Text("Delete")),
          ],
          rows: List.generate(
            notifications.length,
            (index) => _notificationDataRow(
              context,
              notifications[index],
              index + 1,
              view: () =>
                  viewNotificationStatics(context, notifications[index]),
              delete: () async {
                final confirmed = await showDeleteConfirmationDialog(
                  context,
                  title: 'Delete Notification',
                  message:
                      'Are you sure you want to delete "${notifications[index].title}"? This action cannot be undone.',
                );
                if (confirmed) {
                  context.notificationProvider
                      .deleteNotification(notifications[index]);
                }
              },
            ),
          ),
        );

        if (needsScroll) {
          return Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: _minTableWidth),
                child: table,
              ),
            ),
          );
        }
        return SizedBox(width: double.infinity, child: table);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  MOBILE LIST
// ─────────────────────────────────────────────────────────────────────────────
class _MobileNotificationList extends StatelessWidget {
  final List<MyNotification> notifications;
  const _MobileNotificationList({required this.notifications});

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text("No notifications found",
              style: TextStyle(color: Colors.white54)),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: notifications.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppSpacing.itemGap(context)),
      itemBuilder: (context, index) {
        final n = notifications[index];
        return _MobileNotificationCard(
          notification: n,
          index: index + 1,
          onView: () => viewNotificationStatics(context, n),
          onDelete: () async {
            final confirmed = await showDeleteConfirmationDialog(
              context,
              title: 'Delete Notification',
              message:
                  'Are you sure you want to delete "${n.title}"? This action cannot be undone.',
            );
            if (confirmed) {
              context.notificationProvider.deleteNotification(n);
            }
          },
        );
      },
    );
  }
}

class _MobileNotificationCard extends StatelessWidget {
  final MyNotification notification;
  final int index;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const _MobileNotificationCard({
    required this.notification,
    required this.index,
    required this.onView,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = AppIconSize.tableAction(context);
    final hPad = AppSpacing.sm(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad + 4, vertical: hPad + 2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppRadius.sm(context)),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          // Index badge
          Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: colors[index % colors.length],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: TextStyle(
                  fontSize: AppFontSize.xs(context),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm(context) + 4),

          // Notification info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title ?? '',
                  style: TextStyle(
                    fontSize: AppFontSize.body(context),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  notification.description ?? '',
                  style: TextStyle(
                      fontSize: AppFontSize.sm(context), color: Colors.white54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  notification.createdAt ?? '',
                  style: TextStyle(
                      fontSize: AppFontSize.xs(context), color: Colors.white38),
                ),
              ],
            ),
          ),

          // View button
          IconButton(
            onPressed: onView,
            icon: Icon(Icons.remove_red_eye_sharp,
                size: iconSize, color: Colors.white70),
            visualDensity: VisualDensity.compact,
            tooltip: 'View Stats',
          ),
          // Delete button
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
            visualDensity: VisualDensity.compact,
            tooltip: 'Delete',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DESKTOP DataRow builder
// ─────────────────────────────────────────────────────────────────────────────
DataRow _notificationDataRow(
  BuildContext context,
  MyNotification n,
  int index, {
  Function? view,
  Function? delete,
}) {
  final iconSize = AppIconSize.tableAction(context);
  final hPad = AppSpacing.sm(context);

  return DataRow(cells: [
    DataCell(
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: colors[index % colors.length],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: TextStyle(
                  fontSize: AppFontSize.xs(context),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: hPad),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 150),
            child: Text(n.title ?? '', overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
    DataCell(
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 180),
        child: Text(n.description ?? '', overflow: TextOverflow.ellipsis),
      ),
    ),
    DataCell(Text(n.createdAt ?? '')),
    DataCell(IconButton(
      onPressed: () => view?.call(),
      icon:
          Icon(Icons.remove_red_eye_sharp, size: iconSize, color: Colors.white),
      tooltip: 'View Stats',
    )),
    DataCell(IconButton(
      onPressed: () => delete?.call(),
      icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
      tooltip: 'Delete',
    )),
  ]);
}
