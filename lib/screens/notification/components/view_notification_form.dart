// import 'package:admin/utility/extensions.dart';

// import '../../../models/my_notification.dart';
// import '../provider/notification_provider.dart';
// import '../../../utility/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';

// import 'notification_statics_card.dart';

// class ViewNotificationForm extends StatelessWidget {
//   final MyNotification? notification;

//   const ViewNotificationForm({Key? key, this.notification}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     context.notificationProvider.getNotificationInfo(notification);
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.all(defaultPadding),
//         width: size.width * 0.5, // Adjust width based on screen size
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(12.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(notification?.title ?? 'N/A',
//                     style: TextStyle(fontSize: 16)),
//               ],
//             ),
//             Gap(10),
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               padding: EdgeInsets.all(defaultPadding),
//               decoration: BoxDecoration(
//                 color: secondaryColor, // Light grey background to stand out
//                 borderRadius: BorderRadius.circular(8.0),
//                 border: Border.all(
//                     color: Colors.blueAccent), // Blue border for emphasis
//               ),
//               child: Consumer<NotificationProvider>(
//                 builder: (context, notificationProvider, child) {
//                   int totalSend = notificationProvider
//                           .notificationResult?.successDelivery ??
//                       0;
//                   int totalOpened = notificationProvider
//                           .notificationResult?.openedNotification ??
//                       0;
//                   int totalFailed =
//                       notificationProvider.notificationResult?.failedDelivery ??
//                           0;
//                   int totalError = notificationProvider
//                           .notificationResult?.erroredDelivery ??
//                       0;
//                   double calculatePercentage(int notificationCount) {
//                     if (totalSend == 0) {
//                       return 0;
//                     } else {
//                       return (notificationCount / totalSend) * 100;
//                     }
//                   }

//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       NotificationCard(
//                         text: 'Total Send',
//                         color: Colors.blue,
//                         number: totalSend,
//                         percentage: calculatePercentage(totalSend),
//                       ),
//                       NotificationCard(
//                         text: 'Total Opened',
//                         color: Colors.green,
//                         number: totalOpened,
//                         percentage: calculatePercentage(totalOpened),
//                       ),
//                       NotificationCard(
//                         text: 'Total Failed',
//                         color: Colors.red,
//                         number: totalFailed,
//                         percentage: calculatePercentage(totalFailed),
//                       ),
//                       NotificationCard(
//                         text: 'Total Error',
//                         color: Colors.yellow,
//                         number: totalError,
//                         percentage: calculatePercentage(totalError),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             Gap(10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   style:
//                       ElevatedButton.styleFrom(backgroundColor: secondaryColor),
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: const Text('Cancel'),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// // How to show the order popup
// void viewNotificationStatics(
//     BuildContext context, MyNotification? notification) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         title: Center(
//             child: Text('Notification Statics'.toUpperCase(),
//                 style: TextStyle(color: primaryColor))),
//         content: ViewNotificationForm(notification: notification),
//       );
//     },
//   );
// }
import 'package:admin/utility/extensions.dart';
import '../../../models/my_notification.dart';
import '../provider/notification_provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'notification_statics_card.dart';

class ViewNotificationForm extends StatelessWidget {
  final MyNotification? notification;
  const ViewNotificationForm({Key? key, this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.cardPadding(context);
    final gap = AppSpacing.sectionGap(context);
    final smallGap = AppSpacing.itemGap(context);

    context.notificationProvider.getNotificationInfo(notification);

    return SingleChildScrollView(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Notification title
            Text(
              notification?.title ?? 'N/A',
              style: TextStyle(
                fontSize: AppFontSize.lg(context),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            Gap(gap),

            // Stats cards
            Container(
              padding: padding,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(AppRadius.sm(context)),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Consumer<NotificationProvider>(
                builder: (context, notificationProvider, child) {
                  final int totalSend = notificationProvider
                          .notificationResult?.successDelivery ??
                      0;
                  final int totalOpened = notificationProvider
                          .notificationResult?.openedNotification ??
                      0;
                  final int totalFailed =
                      notificationProvider.notificationResult?.failedDelivery ??
                          0;
                  final int totalError = notificationProvider
                          .notificationResult?.erroredDelivery ??
                      0;

                  double pct(int n) =>
                      totalSend == 0 ? 0 : (n / totalSend) * 100;

                  // On tablet+ show 2 cards per row for a compact grid
                  final isWide = !AppBreakpoints.isMobile(context);

                  final cards = [
                    NotificationCard(
                      text: 'Total Send',
                      color: Colors.blue,
                      number: totalSend,
                      percentage: pct(totalSend),
                    ),
                    NotificationCard(
                      text: 'Total Opened',
                      color: Colors.green,
                      number: totalOpened,
                      percentage: pct(totalOpened),
                    ),
                    NotificationCard(
                      text: 'Total Failed',
                      color: Colors.red,
                      number: totalFailed,
                      percentage: pct(totalFailed),
                    ),
                    NotificationCard(
                      text: 'Total Error',
                      color: Colors.yellow,
                      number: totalError,
                      percentage: pct(totalError),
                    ),
                  ];

                  if (isWide) {
                    // 2×2 grid on tablet/web
                    return Column(
                      children: [
                        Row(children: [
                          Expanded(child: cards[0]),
                          SizedBox(width: smallGap),
                          Expanded(child: cards[1]),
                        ]),
                        SizedBox(height: smallGap),
                        Row(children: [
                          Expanded(child: cards[2]),
                          SizedBox(width: smallGap),
                          Expanded(child: cards[3]),
                        ]),
                      ],
                    );
                  }

                  // Vertical list on mobile
                  return Column(
                    children: cards
                        .map((c) => Padding(
                              padding: EdgeInsets.only(bottom: smallGap),
                              child: c,
                            ))
                        .toList(),
                  );
                },
              ),
            ),

            Gap(gap),

            // Close button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md(context),
                  vertical: AppSpacing.sm(context),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close',
                  style: TextStyle(fontSize: AppFontSize.body(context))),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DIALOG LAUNCHER
// ─────────────────────────────────────────────────────────────────────────────
void viewNotificationStatics(
    BuildContext context, MyNotification? notification) {
  final w = MediaQuery.of(context).size.width;

  final double dialogWidth = () {
    if (w < AppBreakpoints.mobileS) return w * 0.92;
    if (w < AppBreakpoints.mobileL) return w * 0.88;
    if (w < AppBreakpoints.tablet) return w * 0.80;
    if (w < AppBreakpoints.webS) return w * 0.55;
    return w * 0.45;
  }();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        insetPadding: EdgeInsets.symmetric(
          horizontal: (w - dialogWidth) / 2,
          vertical: 24,
        ),
        title: Center(
          child: Text(
            'NOTIFICATION STATISTICS',
            style: TextStyle(
              color: primaryColor,
              fontSize: AppFontSize.lg(context),
            ),
          ),
        ),
        content: SizedBox(
          width: dialogWidth,
          child: ViewNotificationForm(notification: notification),
        ),
      );
    },
  );
}
