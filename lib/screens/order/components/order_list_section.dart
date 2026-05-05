// import 'package:admin/utility/extensions.dart';

// import '../../../core/data/data_provider.dart';
// import 'view_order_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/color_list.dart';
// import '../../../models/order.dart';
// import '../../../utility/constants.dart';

// class OrderListSection extends StatelessWidget {
//   const OrderListSection({
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
//             "All Order",
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
//                       label: Text("Customer Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Order Amount"),
//                     ),
//                     DataColumn(
//                       label: Text("Payment"),
//                     ),
//                     DataColumn(
//                       label: Text("Status"),
//                     ),
//                     DataColumn(
//                       label: Text("Date"),
//                     ),
//                     DataColumn(
//                       label: Text("Edit"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     dataProvider.orders.length,
//                     (index) => orderDataRow(
//                         dataProvider.orders[index], index + 1, delete: () {
//                       context.orderProvider
//                           .deleteOrder(dataProvider.orders[index]);
//                     }, edit: () {
//                       showOrderForm(context, dataProvider.orders[index]);
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

// DataRow orderDataRow(Order orderInfo, int index,
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
//               child: Text(index.toString(), textAlign: TextAlign.center),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(orderInfo.userID?.name ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text('${orderInfo.orderTotal?.total}')),
//       DataCell(Text(orderInfo.paymentMethod ?? '')),
//       DataCell(Text(orderInfo.orderStatus ?? '')),
//       DataCell(Text(orderInfo.orderDate ?? '')),
//       DataCell(IconButton(
//           onPressed: () {
//             if (edit != null) edit();
//           },
//           icon: Icon(
//             Icons.edit,
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
import 'view_order_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../models/order.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../sub_category/components/add_sub_category_form.dart'
    show showDeleteConfirmationDialog;

class OrderListSection extends StatelessWidget {
  const OrderListSection({Key? key}) : super(key: key);

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
            "All Orders",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
          SizedBox(height: AppSpacing.sectionGap(context)),
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              return isMobile
                  ? _MobileOrderList(orders: dataProvider.orders)
                  : _DesktopOrderTable(orders: dataProvider.orders);
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DESKTOP TABLE — 7 columns, minWidth 720px
// ─────────────────────────────────────────────────────────────────────────────
class _DesktopOrderTable extends StatelessWidget {
  final List<Order> orders;
  const _DesktopOrderTable({required this.orders});

  static const double _minTableWidth = 720.0;

  @override
  Widget build(BuildContext context) {
    final cellFontSize = AppFontSize.tableCell(context);
    final scrollControl = ScrollController();

    return LayoutBuilder(
      builder: (context, constraints) {
        final needsScroll = constraints.maxWidth < _minTableWidth;

        final table = DataTable(
          columnSpacing: 10,
          horizontalMargin: 10,
          headingTextStyle: TextStyle(
            fontSize: cellFontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
          dataTextStyle: TextStyle(fontSize: cellFontSize, color: Colors.white),
          columns: const [
            DataColumn(label: Text("Customer")),
            DataColumn(label: Text("Amount")),
            DataColumn(label: Text("Payment")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Date")),
            DataColumn(label: Text("Edit")),
            DataColumn(label: Text("Delete")),
          ],
          rows: List.generate(
            orders.length,
            (index) => _orderDataRow(
              context,
              orders[index],
              index + 1,
              edit: () => showOrderForm(context, orders[index]),
              delete: () async {
                final confirmed = await showDeleteConfirmationDialog(
                  context,
                  title: 'Delete Order',
                  message:
                      'Are you sure you want to delete this order? This action cannot be undone.',
                );
                if (confirmed) {
                  context.orderProvider.deleteOrder(orders[index]);
                }
              },
            ),
          ),
        );

        if (needsScroll) {
          return Scrollbar(
            controller: scrollControl,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: scrollControl,
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
//  MOBILE LIST — card per order
// ─────────────────────────────────────────────────────────────────────────────
class _MobileOrderList extends StatelessWidget {
  final List<Order> orders;
  const _MobileOrderList({required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child:
              Text("No orders found", style: TextStyle(color: Colors.white54)),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppSpacing.itemGap(context)),
      itemBuilder: (context, index) {
        final o = orders[index];
        return _MobileOrderCard(
          order: o,
          index: index + 1,
          onEdit: () => showOrderForm(context, o),
          onDelete: () async {
            final confirmed = await showDeleteConfirmationDialog(
              context,
              title: 'Delete Order',
              message:
                  'Are you sure you want to delete this order? This action cannot be undone.',
            );
            if (confirmed) {
              context.orderProvider.deleteOrder(o);
            }
          },
        );
      },
    );
  }
}

class _MobileOrderCard extends StatelessWidget {
  final Order order;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _MobileOrderCard({
    required this.order,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = AppIconSize.tableAction(context);
    final hPad = AppSpacing.sm(context);

    // Status colour
    Color statusColor = Colors.white70;
    switch (order.orderStatus?.toLowerCase()) {
      case 'delivered':
        statusColor = Colors.greenAccent;
        break;
      case 'cancelled':
        statusColor = Colors.redAccent;
        break;
      case 'shipped':
        statusColor = Colors.blueAccent;
        break;
      case 'pending':
        statusColor = const Color(0xFFFFCF26);
        break;
    }

    return Container(
      padding: EdgeInsets.all(hPad + 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppRadius.sm(context)),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: index badge + customer name + actions
          Row(
            children: [
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
              Expanded(
                child: Text(
                  order.userID?.name ?? '',
                  style: TextStyle(
                    fontSize: AppFontSize.body(context),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: onEdit,
                icon: Icon(Icons.edit, size: iconSize, color: Colors.white70),
                visualDensity: VisualDensity.compact,
                tooltip: 'Edit',
              ),
              IconButton(
                onPressed: onDelete,
                icon:
                    Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
                visualDensity: VisualDensity.compact,
                tooltip: 'Delete',
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm(context)),

          // Detail rows
          _detailRow(context, 'Amount',
              '\$${order.orderTotal?.total?.toStringAsFixed(2) ?? 'N/A'}'),
          _detailRow(context, 'Payment', order.paymentMethod ?? ''),
          Row(
            children: [
              Text('Status  ',
                  style: TextStyle(
                      fontSize: AppFontSize.sm(context),
                      color: Colors.white54)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor.withOpacity(0.5)),
                ),
                child: Text(
                  order.orderStatus ?? '',
                  style: TextStyle(
                      fontSize: AppFontSize.xs(context),
                      color: statusColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          _detailRow(context, 'Date', order.orderDate ?? ''),
        ],
      ),
    );
  }

  Widget _detailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text('$label  ',
              style: TextStyle(
                  fontSize: AppFontSize.sm(context), color: Colors.white54)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  fontSize: AppFontSize.sm(context), color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DESKTOP DataRow builder
// ─────────────────────────────────────────────────────────────────────────────
DataRow _orderDataRow(
  BuildContext context,
  Order orderInfo,
  int index, {
  Function? edit,
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
            constraints: const BoxConstraints(maxWidth: 130),
            child: Text(orderInfo.userID?.name ?? '',
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
    DataCell(
        Text('\$${orderInfo.orderTotal?.total?.toStringAsFixed(2) ?? ''}')),
    DataCell(Text(orderInfo.paymentMethod ?? '')),
    DataCell(Text(orderInfo.orderStatus ?? '')),
    DataCell(Text(orderInfo.orderDate ?? '')),
    DataCell(IconButton(
      onPressed: () => edit?.call(),
      icon: Icon(Icons.edit, size: iconSize, color: Colors.white),
      tooltip: 'Edit',
    )),
    DataCell(IconButton(
      onPressed: () => delete?.call(),
      icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
      tooltip: 'Delete',
    )),
  ]);
}
