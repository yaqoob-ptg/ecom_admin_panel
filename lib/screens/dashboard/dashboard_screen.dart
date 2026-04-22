// // import 'package:admin/utility/extensions.dart';

// // import 'components/dash_board_header.dart';
// // import 'package:flutter/material.dart';
// // import 'package:gap/gap.dart';
// // import '../../utility/constants.dart';
// // import 'components/add_product_form.dart';
// // import 'components/order_details_section.dart';
// // import 'components/product_list_section.dart';
// // import 'components/product_summery_section.dart';

// // class DashboardScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: SingleChildScrollView(
// //         primary: false,
// //         padding: EdgeInsets.all(defaultPadding),
// //         child: Column(
// //           children: [
// //             DashBoardHeader(),
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
// //                               "My Products",
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
// //                               showAddProductForm(context, null);
// //                             },
// //                             icon: Icon(Icons.add),
// //                             label: Text("Add New"),
// //                           ),
// //                           Gap(20),
// //                           IconButton(
// //                               onPressed: () {
// //                                 context.dataProvider
// //                                     .getAllProduct(showSnack: true);
// //                               },
// //                               icon: Icon(Icons.refresh)),
// //                         ],
// //                       ),
// //                       Gap(defaultPadding),
// //                       ProductSummerySection(),
// //                       Gap(defaultPadding),
// //                       ProductListSection(),
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(width: defaultPadding),
// //                 Expanded(
// //                   flex: 2,
// //                   child: OrderDetailsSection(),
// //                 ),
// //               ],
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// //responsive
// import 'package:admin/utility/extensions.dart';
// import 'components/dash_board_header.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import '../../utility/constants.dart';
// import '../../utility/responsive_constants.dart';
// import 'components/add_product_form.dart';
// import 'components/order_details_section.dart';
// import 'components/product_list_section.dart';
// import 'components/product_summery_section.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = AppBreakpoints.isMobile(context);
//     final isTablet = AppBreakpoints.isTablet(context);
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
//             // ── Header ────────────────────────────────────────────────
//             const DashBoardHeader(),
//             Gap(gap),

//             // ── Main body: products (left) + orders (right) ───────────
//             // Mobile/Tablet:  stacked vertically, orders below products
//             // Web:            side-by-side, flex 5 : flex 2
//             isMobile || isTablet
//                 ? _buildStackedLayout(context, gap, smallGap)
//                 : _buildSideBySideLayout(context, gap, smallGap),
//           ],
//         ),
//       ),
//     );
//   }

//   // ── Side-by-side layout (web only) ─────────────────────────────────────────
//   Widget _buildSideBySideLayout(
//       BuildContext context, double gap, double smallGap) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 5,
//           child: _ProductsColumn(gap: gap, smallGap: smallGap),
//         ),
//         SizedBox(width: gap),
//         Expanded(
//           flex: 2,
//           // Wrap in SingleChildScrollView so the order panel can scroll
//           // independently if it overflows on shorter web viewports
//           child: SingleChildScrollView(
//             child: const OrderDetailsSection(),
//           ),
//         ),
//       ],
//     );
//   }

//   // ── Stacked layout (mobile + tablet) ───────────────────────────────────────
//   Widget _buildStackedLayout(
//       BuildContext context, double gap, double smallGap) {
//     return Column(
//       children: [
//         _ProductsColumn(gap: gap, smallGap: smallGap),
//         Gap(gap),
//         // Order details takes full width below on mobile/tablet
//         const OrderDetailsSection(),
//       ],
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  PRODUCTS COLUMN  (shared by both layouts)
// // ─────────────────────────────────────────────────────────────────────────────
// class _ProductsColumn extends StatelessWidget {
//   final double gap;
//   final double smallGap;

//   const _ProductsColumn({required this.gap, required this.smallGap});

//   @override
//   Widget build(BuildContext context) {
//     final isMobileS = AppBreakpoints.isMobileS(context);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // ── "My Products" title row ──────────────────────────────────
//         _ProductsToolbar(isMobileS: isMobileS, smallGap: smallGap),
//         Gap(gap),

//         // ── Summary cards ────────────────────────────────────────────
//         const ProductSummerySection(),
//         Gap(gap),

//         // ── Product table ────────────────────────────────────────────
//         const ProductListSection(),
//       ],
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  PRODUCTS TOOLBAR  — title + Add New button + refresh
// // ─────────────────────────────────────────────────────────────────────────────
// class _ProductsToolbar extends StatelessWidget {
//   final bool isMobileS;
//   final double smallGap;

//   const _ProductsToolbar({required this.isMobileS, required this.smallGap});

//   @override
//   Widget build(BuildContext context) {
//     final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
//           fontSize: AppFontSize.sectionTitle(context),
//         );

//     // On very small screens, stack the title above the buttons
//     if (isMobileS) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("My Products", style: titleStyle),
//           Gap(smallGap),
//           Row(
//             children: [
//               _addNewButton(context),
//               const Spacer(),
//               _refreshButton(context),
//             ],
//           ),
//         ],
//       );
//     }

//     // Tablet / Web: everything in one row
//     return Row(
//       children: [
//         Expanded(
//           child: Text("My Products", style: titleStyle),
//         ),
//         _addNewButton(context),
//         Gap(smallGap),
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
//       onPressed: () => showAddProductForm(context, null),
//       icon: Icon(Icons.add, size: AppIconSize.sm(context)),
//       label: Text(
//         "Add New",
//         style: TextStyle(fontSize: AppFontSize.body(context)),
//       ),
//     );
//   }

//   Widget _refreshButton(BuildContext context) {
//     return IconButton(
//       onPressed: () => context.dataProvider.getAllProduct(showSnack: true),
//       icon: Icon(Icons.refresh, size: AppIconSize.md(context)),
//       tooltip: 'Refresh',
//     );
//   }
// }

import 'package:admin/utility/extensions.dart';
import 'components/dash_board_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import '../../utility/responsive_constants.dart';
import 'components/add_product_form.dart';
import 'components/order_details_section.dart';
import 'components/product_list_section.dart';
import 'components/product_summery_section.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final isTablet = AppBreakpoints.isTablet(context);
    // Side-by-side only at webS+ (1280px+) — at 1024px the left column is
    // ~730px which is still too narrow for the 6-column product table without
    // awkward squishing. Stacking on webS gives both panels full width.
    final isWebL = AppBreakpoints.isWebL(context);
    final isWebS = AppBreakpoints.isWebS(context);
    final sideBySide = isWebS || isWebL;

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
            // ── Header ────────────────────────────────────────────────
            const DashBoardHeader(),
            Gap(gap),

            // ── Main body ─────────────────────────────────────────────
            // Mobile / Tablet / WebS(1024–1279): stacked
            // WebL (1280px+):                    side-by-side
            sideBySide
                ? _buildSideBySideLayout(context, gap, smallGap, isWebL)
                : _buildStackedLayout(context, gap, smallGap),
          ],
        ),
      ),
    );
  }

  // ── Side-by-side layout (webL 1280px+) ────────────────────────────────────
  Widget _buildSideBySideLayout(
      BuildContext context, double gap, double smallGap, bool isWebL) {
    // At 1280px: flex 5:2 gives left col ~914px — plenty for the table.
    // Keep consistent ratio regardless of exact web width.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _ProductsColumn(gap: gap, smallGap: smallGap),
        ),
        SizedBox(width: gap),
        Expanded(
          flex: 2,
          // Order panel scrolls independently on shorter viewports
          child: SingleChildScrollView(
            child: const OrderDetailsSection(),
          ),
        ),
      ],
    );
  }

  // ── Stacked layout (mobile + tablet) ───────────────────────────────────────
  Widget _buildStackedLayout(
      BuildContext context, double gap, double smallGap) {
    return Column(
      children: [
        _ProductsColumn(gap: gap, smallGap: smallGap),
        Gap(gap),
        // Order details takes full width below on mobile/tablet
        const OrderDetailsSection(),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  PRODUCTS COLUMN  (shared by both layouts)
// ─────────────────────────────────────────────────────────────────────────────
class _ProductsColumn extends StatelessWidget {
  final double gap;
  final double smallGap;

  const _ProductsColumn({required this.gap, required this.smallGap});

  @override
  Widget build(BuildContext context) {
    final isMobileS = AppBreakpoints.isMobileS(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── "My Products" title row ──────────────────────────────────
        _ProductsToolbar(isMobileS: isMobileS, smallGap: smallGap),
        Gap(gap),

        // ── Summary cards ────────────────────────────────────────────
        const ProductSummerySection(),
        Gap(gap),

        // ── Product table ────────────────────────────────────────────
        const ProductListSection(),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  PRODUCTS TOOLBAR  — title + Add New button + refresh
// ─────────────────────────────────────────────────────────────────────────────
class _ProductsToolbar extends StatelessWidget {
  final bool isMobileS;
  final double smallGap;

  const _ProductsToolbar({required this.isMobileS, required this.smallGap});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: AppFontSize.sectionTitle(context),
        );

    // On very small screens, stack the title above the buttons
    if (isMobileS) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("My Products", style: titleStyle),
          Gap(smallGap),
          Row(
            children: [
              _addNewButton(context),
              const Spacer(),
              _refreshButton(context),
            ],
          ),
        ],
      );
    }

    // Tablet / Web: everything in one row
    return Row(
      children: [
        Expanded(
          child: Text("My Products", style: titleStyle),
        ),
        if (context.userProvider.user?.role != 'superAdmin')
          _addNewButton(context),
        Gap(smallGap),
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
      onPressed: () => showAddProductForm(context, null),
      icon: Icon(Icons.add, size: AppIconSize.sm(context)),
      label: Text(
        "Add New",
        style: TextStyle(fontSize: AppFontSize.body(context)),
      ),
    );
  }

  Widget _refreshButton(BuildContext context) {
    return IconButton(
      onPressed: () => context.dataProvider.getAllProduct(showSnack: true),
      icon: Icon(Icons.refresh, size: AppIconSize.md(context)),
      tooltip: 'Refresh',
    );
  }
}
