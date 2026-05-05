// import 'package:admin/utility/extensions.dart';

// import 'components/coupon_code_header.dart';
// import 'components/coupon_list_section.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import '../../utility/constants.dart';
// import 'components/add_coupon_form.dart';

// class CouponCodeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         primary: false,
//         padding: EdgeInsets.all(defaultPadding),
//         child: Column(
//           children: [
//             CouponCodeHeader(),
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
//                               "My Sub Categories",
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           if (context.userProvider.user?.role != 'superAdmin')
//                             ElevatedButton.icon(
//                               style: TextButton.styleFrom(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: defaultPadding * 1.5,
//                                   vertical: defaultPadding,
//                                 ),
//                               ),
//                               onPressed: () {
//                                 showAddCouponForm(context, null);
//                               },
//                               icon: Icon(Icons.add),
//                               label: Text("Add New"),
//                             ),
//                           Gap(20),
//                           IconButton(
//                               onPressed: () {
//                                 context.dataProvider
//                                     .getAllCoupons(showSnack: true);
//                               },
//                               icon: Icon(Icons.refresh)),
//                         ],
//                       ),
//                       Gap(defaultPadding),
//                       CouponListSection(),
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
import 'components/coupon_code_header.dart';
import 'components/coupon_list_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import '../../utility/responsive_constants.dart';
import 'components/add_coupon_form.dart';

class CouponCodeScreen extends StatelessWidget {
  const CouponCodeScreen({Key? key}) : super(key: key);

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
            const CouponCodeHeader(),
            Gap(gap),
            isMobileS
                ? _buildToolbarStacked(context, smallGap)
                : _buildToolbarRow(context, smallGap),
            Gap(gap),
            const CouponListSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbarStacked(BuildContext context, double gap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Coupons",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: AppFontSize.sectionTitle(context),
              ),
        ),
        Gap(gap),
        Row(
          children: [
            if (context.userProvider.user?.role != 'superAdmin')
              _addNewButton(context),
            const Spacer(),
            _refreshButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildToolbarRow(BuildContext context, double gap) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "My Coupons",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
        ),
        if (context.userProvider.user?.role != 'superAdmin')
          _addNewButton(context),
        Gap(gap),
        _refreshButton(context),
      ],
    );
  }

  Widget _addNewButton(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md(context),
          vertical: AppSpacing.sm(context),
        ),
      ),
      onPressed: () => showAddCouponForm(context, null),
      icon: Icon(Icons.add, size: AppIconSize.sm(context)),
      label: Text("Add New",
          style: TextStyle(fontSize: AppFontSize.body(context))),
    );
  }

  Widget _refreshButton(BuildContext context) {
    return IconButton(
      onPressed: () => context.dataProvider.getAllCoupons(showSnack: true),
      icon: Icon(Icons.refresh, size: AppIconSize.md(context)),
      tooltip: 'Refresh',
    );
  }
}
