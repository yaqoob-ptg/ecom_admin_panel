// import 'package:admin/utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import '../../utility/constants.dart';
// import 'components/add_variant_form.dart';
// import 'components/variant_header.dart';
// import 'components/variants_list_section.dart';

// class VariantsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         primary: false,
//         padding: EdgeInsets.all(defaultPadding),
//         child: Column(
//           children: [
//             VariantsHeader(),
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
//                               "My Variants",
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                           ),
//                           if (context.userProvider.user?.role == 'admin')
//                             ElevatedButton.icon(
//                               style: TextButton.styleFrom(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: defaultPadding * 1.5,
//                                   vertical: defaultPadding,
//                                 ),
//                               ),
//                               onPressed: () {
//                                 showAddVariantForm(context, null);
//                               },
//                               icon: Icon(Icons.add),
//                               label: Text("Add New"),
//                             ),
//                           Gap(20),
//                           IconButton(
//                               onPressed: () {
//                                 context.dataProvider
//                                     .getAllVariant(showSnack: true);
//                               },
//                               icon: Icon(Icons.refresh)),
//                         ],
//                       ),
//                       Gap(defaultPadding),
//                       VariantsListSection(),
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
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import '../../utility/responsive_constants.dart';
import 'components/add_variant_form.dart';
import 'components/variant_header.dart';
import 'components/variants_list_section.dart';

class VariantsScreen extends StatelessWidget {
  const VariantsScreen({Key? key}) : super(key: key);

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
            const VariantsHeader(),
            Gap(gap),
            isMobileS
                ? _buildToolbarStacked(context, smallGap)
                : _buildToolbarRow(context, smallGap),
            Gap(gap),
            const VariantsListSection(),
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
          "My Variants",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: AppFontSize.sectionTitle(context),
              ),
        ),
        Gap(gap),
        Row(
          children: [
            if (context.userProvider.user?.role == 'admin')
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
            "My Variants",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
        ),
        if (context.userProvider.user?.role == 'admin') _addNewButton(context),
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
      onPressed: () => showAddVariantForm(context, null),
      icon: Icon(Icons.add, size: AppIconSize.sm(context)),
      label: Text("Add New",
          style: TextStyle(fontSize: AppFontSize.body(context))),
    );
  }

  Widget _refreshButton(BuildContext context) {
    return IconButton(
      onPressed: () => context.dataProvider.getAllVariant(showSnack: true),
      icon: Icon(Icons.refresh, size: AppIconSize.md(context)),
      tooltip: 'Refresh',
    );
  }
}
