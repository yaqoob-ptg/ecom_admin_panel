// import 'package:admin/utility/extensions.dart';

// import '../../../core/data/data_provider.dart';
// import '../../../models/coupon.dart';
// import 'add_coupon_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/color_list.dart';
// import '../../../utility/constants.dart';

// class CouponListSection extends StatelessWidget {
//   const CouponListSection({
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
//             "All Coupons",
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
//                       label: Text("Coupon Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Status"),
//                     ),
//                     DataColumn(
//                       label: Text("Type"),
//                     ),
//                     DataColumn(
//                       label: Text("Amount"),
//                     ),
//                     DataColumn(
//                       label: Text("Edit"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     dataProvider.coupons.length,
//                     (index) => couponDataRow(
//                       dataProvider.coupons[index],
//                       index + 1,
//                       edit: () {
//                         showAddCouponForm(context, dataProvider.coupons[index]);
//                       },
//                       delete: () {
//                         context.couponCodeProvider
//                             .deleteCoupon(dataProvider.coupons[index]);
//                       },
//                     ),
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

// DataRow couponDataRow(Coupon coupon, int index,
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
//               child: Text(coupon.couponCode ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(coupon.status ?? '')),
//       DataCell(Text(coupon.discountType ?? '')),
//       DataCell(Text('${coupon.discountAmount}' ?? '')),
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
import '../../../models/coupon.dart';
import 'add_coupon_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../sub_category/components/add_sub_category_form.dart'
    show showDeleteConfirmationDialog;

class CouponListSection extends StatelessWidget {
  const CouponListSection({Key? key}) : super(key: key);

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
            "All Coupons",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
          SizedBox(height: AppSpacing.sectionGap(context)),
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              return isMobile
                  ? _MobileCouponList(coupons: dataProvider.coupons)
                  : _DesktopCouponTable(coupons: dataProvider.coupons);
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
class _DesktopCouponTable extends StatelessWidget {
  final List<Coupon> coupons;
  const _DesktopCouponTable({required this.coupons});

  static const double _minTableWidth = 600.0;

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
            DataColumn(label: Text("Coupon Code")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Type")),
            DataColumn(label: Text("Amount")),
            DataColumn(label: Text("Edit")),
            DataColumn(label: Text("Delete")),
          ],
          rows: List.generate(
            coupons.length,
            (index) => _couponDataRow(
              context,
              coupons[index],
              index + 1,
              edit: () => showAddCouponForm(context, coupons[index]),
              delete: () async {
                final confirmed = await showDeleteConfirmationDialog(
                  context,
                  title: 'Delete Coupon',
                  message:
                      'Are you sure you want to delete coupon "${coupons[index].couponCode}"? This action cannot be undone.',
                );
                if (confirmed) {
                  context.couponCodeProvider.deleteCoupon(coupons[index]);
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
class _MobileCouponList extends StatelessWidget {
  final List<Coupon> coupons;
  const _MobileCouponList({required this.coupons});

  @override
  Widget build(BuildContext context) {
    if (coupons.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child:
              Text("No coupons found", style: TextStyle(color: Colors.white54)),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: coupons.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppSpacing.itemGap(context)),
      itemBuilder: (context, index) {
        final c = coupons[index];
        return _MobileCouponCard(
          coupon: c,
          index: index + 1,
          onEdit: () => showAddCouponForm(context, c),
          onDelete: () async {
            final confirmed = await showDeleteConfirmationDialog(
              context,
              title: 'Delete Coupon',
              message:
                  'Are you sure you want to delete coupon "${c.couponCode}"? This action cannot be undone.',
            );
            if (confirmed) {
              context.couponCodeProvider.deleteCoupon(c);
            }
          },
        );
      },
    );
  }
}

class _MobileCouponCard extends StatelessWidget {
  final Coupon coupon;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _MobileCouponCard({
    required this.coupon,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = AppIconSize.tableAction(context);
    final hPad = AppSpacing.sm(context);

    // Status colour
    final Color statusColor = coupon.status?.toLowerCase() == 'active'
        ? Colors.greenAccent
        : Colors.redAccent;

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

          // Coupon info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coupon.couponCode ?? '',
                  style: TextStyle(
                    fontSize: AppFontSize.body(context),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: statusColor.withOpacity(0.5)),
                      ),
                      child: Text(
                        coupon.status ?? '',
                        style: TextStyle(
                          fontSize: AppFontSize.xs(context),
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm(context)),
                    Text(
                      coupon.discountType ?? '',
                      style: TextStyle(
                          fontSize: AppFontSize.sm(context),
                          color: Colors.white54),
                    ),
                    SizedBox(width: AppSpacing.sm(context)),
                    Text(
                      '${coupon.discountAmount}',
                      style: TextStyle(
                          fontSize: AppFontSize.sm(context),
                          color: Colors.white70,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
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
DataRow _couponDataRow(
  BuildContext context,
  Coupon coupon,
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
            constraints: const BoxConstraints(maxWidth: 140),
            child:
                Text(coupon.couponCode ?? '', overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
    DataCell(Text(coupon.status ?? '')),
    DataCell(Text(coupon.discountType ?? '')),
    DataCell(Text('${coupon.discountAmount}')),
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
