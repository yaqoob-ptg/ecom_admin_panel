// import 'package:admin/utility/extensions.dart';

// import '../../../core/data/data_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
// import 'chart.dart';
// import 'order_info_card.dart';

// class OrderDetailsSection extends StatelessWidget {
//   const OrderDetailsSection({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DataProvider>(
//       builder: (context, dataProvider, child) {
//         int totalOrder = context.dataProvider.calculateOrdersWithStatus();
//         int pendingOrder =
//             context.dataProvider.calculateOrdersWithStatus(status: 'pending');
//         int processingOrder = context.dataProvider
//             .calculateOrdersWithStatus(status: 'processing');
//         int cancelledOrder =
//             context.dataProvider.calculateOrdersWithStatus(status: 'cancelled');
//         int shippedOrder =
//             context.dataProvider.calculateOrdersWithStatus(status: 'shipped');
//         int deliveredOrder =
//             context.dataProvider.calculateOrdersWithStatus(status: 'delivered');
//         return Container(
//           padding: EdgeInsets.all(defaultPadding),
//           decoration: BoxDecoration(
//             color: secondaryColor,
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Orders Details",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: defaultPadding),
//               Chart(),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery1.svg",
//                 title: "All Orders",
//                 totalOrder: totalOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery5.svg",
//                 title: "Pending Orders",
//                 totalOrder: pendingOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery6.svg",
//                 title: "Processed Orders",
//                 totalOrder: processingOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery2.svg",
//                 title: "Cancelled Orders",
//                 totalOrder: cancelledOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery4.svg",
//                 title: "Shipped Orders",
//                 totalOrder: shippedOrder,
//               ),
//               OrderInfoCard(
//                 svgSrc: "assets/icons/delivery3.svg",
//                 title: "Delivered Orders",
//                 totalOrder: deliveredOrder,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

//responsive
import 'package:admin/utility/extensions.dart';
import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import 'chart.dart';
import 'order_info_card.dart';

class OrderDetailsSection extends StatelessWidget {
  const OrderDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        final int totalOrder = context.dataProvider.calculateOrdersWithStatus();
        final int pendingOrder =
            context.dataProvider.calculateOrdersWithStatus(status: 'pending');
        final int processingOrder = context.dataProvider
            .calculateOrdersWithStatus(status: 'processing');
        final int cancelledOrder =
            context.dataProvider.calculateOrdersWithStatus(status: 'cancelled');
        final int shippedOrder =
            context.dataProvider.calculateOrdersWithStatus(status: 'shipped');
        final int deliveredOrder =
            context.dataProvider.calculateOrdersWithStatus(status: 'delivered');

        final isMobile = AppBreakpoints.isMobile(context);
        final padding = AppSpacing.cardPadding(context);

        final List<_OrderItem> orderItems = [
          _OrderItem("assets/icons/delivery1.svg", "All Orders", totalOrder),
          _OrderItem(
              "assets/icons/delivery5.svg", "Pending Orders", pendingOrder),
          _OrderItem("assets/icons/delivery6.svg", "Processed Orders",
              processingOrder),
          _OrderItem(
              "assets/icons/delivery2.svg", "Cancelled Orders", cancelledOrder),
          _OrderItem(
              "assets/icons/delivery4.svg", "Shipped Orders", shippedOrder),
          _OrderItem(
              "assets/icons/delivery3.svg", "Delivered Orders", deliveredOrder),
        ];

        return Container(
          padding: padding,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(AppRadius.md(context)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title ────────────────────────────────────────────────
              Text(
                "Orders Details",
                style: TextStyle(
                  fontSize: AppFontSize.lg(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: AppSpacing.sectionGap(context)),

              // ── Chart ────────────────────────────────────────────────
              const Chart(),
              SizedBox(height: AppSpacing.sectionGap(context)),

              // ── Order info cards ─────────────────────────────────────
              // On mobile: 2-column wrap grid for compact display
              // On tablet+: original vertical list
              isMobile
                  ? _MobileOrderGrid(items: orderItems)
                  : _DesktopOrderList(items: orderItems),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DESKTOP / TABLET — vertical list (original behaviour)
// ─────────────────────────────────────────────────────────────────────────────
class _DesktopOrderList extends StatelessWidget {
  final List<_OrderItem> items;
  const _DesktopOrderList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => OrderInfoCard(
                svgSrc: item.svg,
                title: item.title,
                totalOrder: item.count,
              ))
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  MOBILE — 2-column wrap grid
// ─────────────────────────────────────────────────────────────────────────────
class _MobileOrderGrid extends StatelessWidget {
  final List<_OrderItem> items;
  const _MobileOrderGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    final gap = AppSpacing.itemGap(context);
    return Wrap(
      spacing: gap,
      runSpacing: gap,
      children: items.map((item) {
        return SizedBox(
          // Each card takes roughly half the available width minus the gap
          width: (MediaQuery.of(context).size.width -
                  AppSpacing.cardPadding(context).horizontal -
                  AppSpacing.pagePadding(context).horizontal -
                  gap) /
              2,
          child: OrderInfoCard(
            svgSrc: item.svg,
            title: item.title,
            totalOrder: item.count,
          ),
        );
      }).toList(),
    );
  }
}

// Simple data holder
class _OrderItem {
  final String svg;
  final String title;
  final int count;
  const _OrderItem(this.svg, this.title, this.count);
}
