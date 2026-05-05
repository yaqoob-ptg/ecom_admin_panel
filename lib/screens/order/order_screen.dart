// import 'package:admin/utility/extensions.dart';

// import 'components/order_header.dart';
// import 'components/order_list_section.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import '../../utility/constants.dart';
// import '../../widgets/custom_dropdown.dart';

// class OrderScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         primary: false,
//         padding: EdgeInsets.all(defaultPadding),
//         child: Column(
//           children: [
//             OrderHeader(),
//             SizedBox(height: defaultPadding),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 5,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               "My Orders",
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           Gap(20),
//                           SizedBox(
//                             width: 280,
//                             child: CustomDropdown(
//                               hintText: 'Filter Order By status',
//                               initialValue: 'All order',
//                               items: [
//                                 'All order',
//                                 'pending',
//                                 'processing',
//                                 'shipped',
//                                 'delivered',
//                                 'cancelled'
//                               ],
//                               displayItem: (val) => val,
//                               onChanged: (newValue) {
//                                 if (newValue?.toLowerCase() == 'all order') {
//                                   context.dataProvider.filterOrders('');
//                                 } else {
//                                   context.dataProvider.filterOrders(
//                                       newValue?.toLowerCase() ?? '');
//                                 }
//                               },
//                               validator: (value) {
//                                 if (value == null) {
//                                   return 'Please select status';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           Gap(40),
//                           IconButton(
//                               onPressed: () {
//                                 context.dataProvider
//                                     .getAllOrders(showSnack: true);
//                               },
//                               icon: Icon(Icons.refresh)),
//                         ],
//                       ),
//                       Gap(defaultPadding),
//                       OrderListSection(),
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
import 'components/order_header.dart';
import 'components/order_list_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import '../../utility/responsive_constants.dart';
import '../../widgets/custom_dropdown.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobileS = AppBreakpoints.isMobileS(context);
    final isMobile = AppBreakpoints.isMobile(context);
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
            const OrderHeader(),
            Gap(gap),

            // Toolbar: title + status filter + refresh
            isMobileS
                ? _buildToolbarStacked(context, smallGap, isMobile)
                : _buildToolbarRow(context, smallGap, isMobile),

            Gap(gap),
            const OrderListSection(),
          ],
        ),
      ),
    );
  }

  // ── Mobile S: stack title, then filter + refresh in a row ─────────────────
  Widget _buildToolbarStacked(BuildContext context, double gap, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Orders",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: AppFontSize.sectionTitle(context),
              ),
        ),
        Gap(gap),
        Row(
          children: [
            Expanded(child: _statusFilter(context)),
            SizedBox(width: gap),
            _refreshButton(context),
          ],
        ),
      ],
    );
  }

  // ── Tablet / Web: single row ───────────────────────────────────────────────
  Widget _buildToolbarRow(BuildContext context, double gap, bool isMobile) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "My Orders",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
        ),
        // Filter dropdown — fixed width that scales by breakpoint
        SizedBox(
          width: AppResponsive.value(context,
              mobile: 200.0, tablet: 240.0, web: 280.0),
          child: _statusFilter(context),
        ),
        Gap(gap),
        _refreshButton(context),
      ],
    );
  }

  Widget _statusFilter(BuildContext context) {
    return CustomDropdown(
      hintText: 'Filter by Status',
      initialValue: 'All order',
      items: const [
        'All order',
        'pending',
        'processing',
        'shipped',
        'delivered',
        'cancelled',
      ],
      displayItem: (val) => val,
      onChanged: (newValue) {
        if (newValue?.toLowerCase() == 'all order') {
          context.dataProvider.filterOrders('');
        } else {
          context.dataProvider.filterOrders(newValue?.toLowerCase() ?? '');
        }
      },
      validator: (value) {
        if (value == null) return 'Please select status';
        return null;
      },
    );
  }

  Widget _refreshButton(BuildContext context) {
    return IconButton(
      onPressed: () => context.dataProvider.getAllOrders(showSnack: true),
      icon: Icon(Icons.refresh, size: AppIconSize.md(context)),
      tooltip: 'Refresh',
    );
  }
}
