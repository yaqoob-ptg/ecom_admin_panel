// // import 'package:admin/utility/extensions.dart';
// // import 'package:flutter/material.dart';
// // import 'package:gap/gap.dart';
// // import '../../utility/constants.dart';
// // import 'components/add_sub_category_form.dart';
// // import 'components/sub_category_header.dart';
// // import 'components/sub_category_list_section.dart';

// // class SubCategoryScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: SingleChildScrollView(
// //         primary: false,
// //         padding: EdgeInsets.all(defaultPadding),
// //         child: Column(
// //           children: [
// //             SubCategoryHeader(),
// //             Gap(defaultPadding),
// //             Row(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Expanded(
// //                   flex: 5,
// //                   child: Column(
// //                     children: [
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Expanded(
// //                             child: Text(
// //                               "My Sub Categories",
// //                               style: Theme.of(context).textTheme.titleMedium,
// //                             ),
// //                           ),
// //                           ElevatedButton.icon(
// //                             style: TextButton.styleFrom(
// //                               padding: EdgeInsets.symmetric(
// //                                 horizontal: defaultPadding * 1.5,
// //                                 vertical: defaultPadding,
// //                               ),
// //                             ),
// //                             onPressed: () {
// //                               showAddSubCategoryForm(context, null);
// //                             },
// //                             icon: Icon(Icons.add),
// //                             label: Text("Add New"),
// //                           ),
// //                           Gap(20),
// //                           IconButton(
// //                               onPressed: () {
// //                                 context.dataProvider
// //                                     .getAllSubCategory(showSnack: true);
// //                               },
// //                               icon: Icon(Icons.refresh)),
// //                         ],
// //                       ),
// //                       Gap(defaultPadding),
// //                       SubCategoryListSection(),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:admin/utility/extensions.dart';
// import 'package:admin/widgets/app_header.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import '../../utility/constants.dart';
// import '../../utility/responsive_constants.dart';
// import 'components/add_sub_category_form.dart';
// import 'components/sub_category_header.dart';
// import 'components/sub_category_list_section.dart';

// class SubCategoryScreen extends StatelessWidget {
//   const SubCategoryScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isMobileS = AppBreakpoints.isMobileS(context);
//     final padding = AppSpacing.pagePadding(context);
//     final gap = AppSpacing.sectionGap(context);
//     final smallGap = AppSpacing.itemGap(context);

//     return SafeArea(
//       child: SingleChildScrollView(
//         primary: false,
//         padding: padding,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // const SubCategoryHeader(),
//             AppHeader(
//               title: "Sub Category",
//               onSearch: (val) => context.dataProvider.filterSubCategories(val),
//               showProfile:
//                   isMobileS, // profile already shown in main header on larger screens
//             ),
//             Gap(gap),
//             isMobileS
//                 ? _buildToolbarStacked(context, smallGap)
//                 : _buildToolbarRow(context, smallGap),
//             Gap(gap),
//             const SubCategoryListSection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildToolbarStacked(BuildContext context, double gap) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "My Sub Categories",
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                 fontSize: AppFontSize.sectionTitle(context),
//               ),
//         ),
//         Gap(gap),
//         Row(
//           children: [
//             _addNewButton(context),
//             const Spacer(),
//             _refreshButton(context),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildToolbarRow(BuildContext context, double gap) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         // Expanded(
//         //   child: Text(
//         //     "My Sub Categories",
//         //     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//         //           fontSize: AppFontSize.sectionTitle(context),
//         //         ),
//         //   ),
//         // ),
//         _addNewButton(context),
//         Gap(gap),
//         _refreshButton(context),
//       ],
//     );
//   }

//   Widget _addNewButton(BuildContext context) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.symmetric(
//           horizontal: AppSpacing.md(context),
//           vertical: AppSpacing.sm(context),
//         ),
//       ),
//       onPressed: () => showAddSubCategoryForm(context, null),
//       icon: Icon(Icons.add, size: AppIconSize.sm(context)),
//       label: Text("Add New",
//           style: TextStyle(fontSize: AppFontSize.body(context))),
//     );
//   }

//   Widget _refreshButton(BuildContext context) {
//     return IconButton(
//       onPressed: () => context.dataProvider.getAllSubCategory(showSnack: true),
//       icon: Icon(Icons.refresh, size: AppIconSize.md(context)),
//       tooltip: 'Refresh',
//     );
//   }
// }

import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/responsive_constants.dart';
import 'components/add_sub_category_form.dart';
import 'components/sub_category_header.dart';
import 'components/sub_category_list_section.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
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
            // On mobile the MainScreen AppBar already renders ProfileCard.
            // On tablet/web there is no AppBar so the header must show it.
            SubCategoryHeader(showProfile: !isMobile),
            Gap(gap),
            isMobileS
                ? _buildToolbarStacked(context, smallGap)
                : _buildToolbarRow(context, smallGap),
            Gap(gap),
            const SubCategoryListSection(),
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
          "My Sub Categories",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: AppFontSize.sectionTitle(context),
              ),
        ),
        Gap(gap),
        Row(
          children: [
            if (context.userProvider.user?.role == 'superAdmin')
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Expanded(
        //   child: Text(
        //     "My Sub Categories",
        //     style: Theme.of(context).textTheme.titleMedium?.copyWith(
        //           fontSize: AppFontSize.sectionTitle(context),
        //         ),
        //   ),
        // ),
        if (context.userProvider.user?.role == 'superAdmin')
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
      onPressed: () => showAddSubCategoryForm(context, null),
      icon: Icon(Icons.add, size: AppIconSize.sm(context)),
      label: Text("Add New",
          style: TextStyle(fontSize: AppFontSize.body(context))),
    );
  }

  Widget _refreshButton(BuildContext context) {
    return IconButton(
      onPressed: () => context.dataProvider.getAllSubCategory(showSnack: true),
      icon: Icon(Icons.refresh, size: AppIconSize.md(context)),
      tooltip: 'Refresh',
    );
  }
}
