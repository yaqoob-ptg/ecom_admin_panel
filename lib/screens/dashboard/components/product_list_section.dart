// // import 'package:admin/utility/extensions.dart';

// // import '../../../core/data/data_provider.dart';
// // import '../../../models/product.dart';
// // import 'add_product_form.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../../../utility/constants.dart';

// // class ProductListSection extends StatelessWidget {
// //   const ProductListSection({
// //     Key? key,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: EdgeInsets.all(defaultPadding),
// //       decoration: BoxDecoration(
// //         color: secondaryColor,
// //         borderRadius: const BorderRadius.all(Radius.circular(10)),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             "All Products",
// //             style: Theme.of(context).textTheme.titleMedium,
// //           ),
// //           SizedBox(
// //             width: double.infinity,
// //             child: Consumer<DataProvider>(
// //               builder: (context, dataProvider, child) {
// //                 return DataTable(
// //                   columnSpacing: defaultPadding,
// //                   // minWidth: 600,
// //                   columns: [
// //                     DataColumn(
// //                       label: Text("Product Name"),
// //                     ),
// //                     DataColumn(
// //                       label: Text("Category"),
// //                     ),
// //                     DataColumn(
// //                       label: Text("Sub Category"),
// //                     ),
// //                     DataColumn(
// //                       label: Text("Price"),
// //                     ),
// //                     DataColumn(
// //                       label: Text("Edit"),
// //                     ),
// //                     DataColumn(
// //                       label: Text("Delete"),
// //                     ),
// //                   ],
// //                   rows: List.generate(
// //                     dataProvider.products.length,
// //                     (index) => productDataRow(
// //                       dataProvider.products[index],
// //                       edit: () {
// //                         showAddProductForm(
// //                             context, dataProvider.products[index]);
// //                       },
// //                       delete: () {
// //                         context.dashBoardProvider
// //                             .deleteProduct(dataProvider.products[index]);
// //                       },
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // DataRow productDataRow(Product productInfo,
// //     {Function? edit, Function? delete}) {
// //   return DataRow(
// //     cells: [
// //       DataCell(
// //         Row(
// //           children: [
// //             Image.network(
// //               productInfo.images?.first.fullUrl ?? '',
// //               height: 30,
// //               width: 30,
// //               errorBuilder: (BuildContext context, Object exception,
// //                   StackTrace? stackTrace) {
// //                 return Icon(Icons.error);
// //               },
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
// //               child: Text(productInfo.name ?? ''),
// //             ),
// //           ],
// //         ),
// //       ),
// //       DataCell(Text(productInfo.proCategoryId?.name ?? '')),
// //       DataCell(Text(productInfo.proSubCategoryId?.name ?? '')),
// //       DataCell(
// //         Text('${productInfo.price}'),
// //       ),
// //       DataCell(IconButton(
// //           onPressed: () {
// //             if (edit != null) edit();
// //           },
// //           icon: Icon(
// //             Icons.edit,
// //             color: Colors.white,
// //           ))),
// //       DataCell(IconButton(
// //           onPressed: () {
// //             if (delete != null) delete();
// //           },
// //           icon: Icon(
// //             Icons.delete,
// //             color: Colors.red,
// //           ))),
// //     ],
// //   );
// // }

// //responsive code
// import 'package:admin/utility/extensions.dart';
// import '../../../core/data/data_provider.dart';
// import '../../../models/product.dart';
// import 'add_product_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
// import '../../../utility/responsive_constants.dart'; // ← your new file

// class ProductListSection extends StatelessWidget {
//   const ProductListSection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = AppBreakpoints.isMobile(context);
//     final padding = AppSpacing.cardPadding(context);

//     return Container(
//       padding: padding,
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: BorderRadius.all(
//           Radius.circular(AppRadius.md(context)),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ── Section title ──────────────────────────────────
//           Text(
//             "All Products",
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   fontSize: AppFontSize.sectionTitle(context),
//                 ),
//           ),
//           SizedBox(height: AppSpacing.sectionGap(context)),

//           // ── Table (scrollable on mobile, full on larger screens) ──
//           Consumer<DataProvider>(
//             builder: (context, dataProvider, child) {
//               return isMobile
//                   ? _MobileProductTable(products: dataProvider.products)
//                   : _DesktopProductTable(products: dataProvider.products);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  DESKTOP TABLE  (tablet and above — full DataTable, horizontally scrollable
// //                  on tablet to handle narrower widths)
// // ─────────────────────────────────────────────────────────────────────────────
// class _DesktopProductTable extends StatelessWidget {
//   final List<Product> products;
//   const _DesktopProductTable({required this.products});

//   @override
//   Widget build(BuildContext context) {
//     final isTablet = AppBreakpoints.isTablet(context);

//     return SizedBox(
//       width: double.infinity,
//       child: SingleChildScrollView(
//         scrollDirection: isTablet ? Axis.horizontal : Axis.vertical,
//         child: ConstrainedBox(
//           // On tablet, enforce a minimum width so columns don't squish
//           constraints: BoxConstraints(
//             minWidth: isTablet ? 650 : 0,
//           ),
//           child: DataTable(
//             columnSpacing: AppSpacing.md(context),
//             headingTextStyle: TextStyle(
//               fontSize: AppFontSize.tableCell(context),
//               fontWeight: FontWeight.w600,
//               color: Colors.white70,
//             ),
//             dataTextStyle: TextStyle(
//               fontSize: AppFontSize.tableCell(context),
//               color: Colors.white,
//             ),
//             columns: const [
//               DataColumn(label: Text("Product Name")),
//               DataColumn(label: Text("Category")),
//               DataColumn(label: Text("Sub Category")),
//               DataColumn(label: Text("Price")),
//               DataColumn(label: Text("Edit")),
//               DataColumn(label: Text("Delete")),
//             ],
//             rows: List.generate(
//               products.length,
//               (index) => _productDataRow(
//                 context,
//                 products[index],
//                 edit: () => showAddProductForm(context, products[index]),
//                 delete: () =>
//                     context.dashBoardProvider.deleteProduct(products[index]),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  MOBILE TABLE  (card list — avoids the cramped DataTable on small screens)
// // ─────────────────────────────────────────────────────────────────────────────
// class _MobileProductTable extends StatelessWidget {
//   final List<Product> products;
//   const _MobileProductTable({required this.products});

//   @override
//   Widget build(BuildContext context) {
//     if (products.isEmpty) {
//       return const Center(
//         child: Padding(
//           padding: EdgeInsets.all(24),
//           child: Text("No products found",
//               style: TextStyle(color: Colors.white54)),
//         ),
//       );
//     }

//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: products.length,
//       separatorBuilder: (_, __) =>
//           SizedBox(height: AppSpacing.itemGap(context)),
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return _MobileProductCard(
//           product: product,
//           onEdit: () => showAddProductForm(context, product),
//           onDelete: () => context.dashBoardProvider.deleteProduct(product),
//         );
//       },
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  MOBILE PRODUCT CARD
// // ─────────────────────────────────────────────────────────────────────────────
// class _MobileProductCard extends StatelessWidget {
//   final Product product;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;

//   const _MobileProductCard({
//     required this.product,
//     required this.onEdit,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final thumbSize = AppImageSize.tableThumb(context);
//     final bodySize = AppFontSize.body(context);
//     final smSize = AppFontSize.sm(context);
//     final iconSize = AppIconSize.tableAction(context);
//     final hPad = AppSpacing.sm(context);

//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: hPad + 4,
//         vertical: hPad + 2,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(AppRadius.sm(context)),
//         border: Border.all(color: Colors.white12),
//       ),
//       child: Row(
//         children: [
//           // Thumbnail
//           ClipRRect(
//             borderRadius: BorderRadius.circular(AppRadius.sm(context)),
//             child: Image.network(
//               product.images?.first.fullUrl ?? '',
//               height: thumbSize,
//               width: thumbSize,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => Icon(
//                 Icons.broken_image,
//                 size: thumbSize,
//                 color: Colors.white38,
//               ),
//             ),
//           ),
//           SizedBox(width: AppSpacing.sm(context) + 4),

//           // Product info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.name ?? '',
//                   style: TextStyle(
//                     fontSize: bodySize,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   '${product.proCategoryId?.name ?? ''}'
//                   '${product.proSubCategoryId?.name != null ? ' › ${product.proSubCategoryId!.name}' : ''}',
//                   style: TextStyle(fontSize: smSize, color: Colors.white54),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   '\$${product.price}',
//                   style: TextStyle(
//                     fontSize: smSize,
//                     color: Colors.greenAccent,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Actions
//           IconButton(
//             onPressed: onEdit,
//             icon: Icon(Icons.edit, size: iconSize, color: Colors.white70),
//             visualDensity: VisualDensity.compact,
//             tooltip: 'Edit',
//           ),
//           IconButton(
//             onPressed: onDelete,
//             icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
//             visualDensity: VisualDensity.compact,
//             tooltip: 'Delete',
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  SHARED: DataTable row builder  (used in desktop/tablet view)
// // ─────────────────────────────────────────────────────────────────────────────
// DataRow _productDataRow(
//   BuildContext context,
//   Product productInfo, {
//   Function? edit,
//   Function? delete,
// }) {
//   final thumbSize = AppImageSize.tableThumb(context);
//   final iconSize = AppIconSize.tableAction(context);
//   final hPad = AppSpacing.sm(context);

//   return DataRow(
//     cells: [
//       // Product name + thumbnail
//       DataCell(
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(4),
//               child: Image.network(
//                 productInfo.images?.first.fullUrl ?? '',
//                 height: thumbSize,
//                 width: thumbSize,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Icon(
//                   Icons.broken_image,
//                   size: thumbSize,
//                   color: Colors.white38,
//                 ),
//               ),
//             ),
//             SizedBox(width: hPad),
//             ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 160),
//               child: Text(
//                 productInfo.name ?? '',
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(productInfo.proCategoryId?.name ?? '')),
//       DataCell(Text(productInfo.proSubCategoryId?.name ?? '')),
//       DataCell(Text('\$${productInfo.price}')),
//       DataCell(
//         IconButton(
//           onPressed: () => edit?.call(),
//           icon: Icon(Icons.edit, size: iconSize, color: Colors.white),
//           tooltip: 'Edit',
//         ),
//       ),
//       DataCell(
//         IconButton(
//           onPressed: () => delete?.call(),
//           icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
//           tooltip: 'Delete',
//         ),
//       ),
//     ],
//   );
// }

import 'package:admin/utility/delete_dialog.dart';
import 'package:admin/utility/extensions.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/product.dart';
import 'add_product_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart'; // ← your new file

class ProductListSection extends StatelessWidget {
  const ProductListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final padding = AppSpacing.cardPadding(context);

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
          // ── Section title ──────────────────────────────────
          Text(
            "All Products",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
          SizedBox(height: AppSpacing.sectionGap(context)),

          // ── Table (scrollable on mobile, full on larger screens) ──
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              return isMobile
                  ? _MobileProductTable(products: dataProvider.products)
                  : _DesktopProductTable(products: dataProvider.products);
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DESKTOP TABLE  (tablet and above)
//  Uses LayoutBuilder to measure actual available width at runtime.
//  The table needs ~680px for all 6 columns comfortably. If the container
//  is narrower (e.g. iPad 1024px split 5:2 = ~730px left col, minus paddings
//  leaves ~690px — still tight), horizontal scroll kicks in automatically.
// ─────────────────────────────────────────────────────────────────────────────
class _DesktopProductTable extends StatelessWidget {
  final List<Product> products;
  const _DesktopProductTable({required this.products});

  // Minimum px needed to show all 6 columns without overflow
  static const double _minTableWidth = 680.0;

  @override
  Widget build(BuildContext context) {
    final cellFontSize = AppFontSize.tableCell(context);
    // Tighter column spacing so columns breathe without overflowing
    const double colSpacing = 12.0;
    final scrollController = ScrollController();

    return LayoutBuilder(
      builder: (context, constraints) {
        final needsScroll = constraints.maxWidth < _minTableWidth;

        final table = DataTable(
          columnSpacing: colSpacing,
          horizontalMargin: 10,
          headingTextStyle: TextStyle(
            fontSize: cellFontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
          dataTextStyle: TextStyle(
            fontSize: cellFontSize,
            color: Colors.white,
          ),
          columns: const [
            DataColumn(label: Text("Product Name")),
            DataColumn(label: Text("Category")),
            DataColumn(label: Text("Sub Category")),
            DataColumn(label: Text("Price")),
            DataColumn(label: Text("Edit")),
            DataColumn(label: Text("Delete")),
          ],
          rows: List.generate(
            products.length,
            (index) => _productDataRow(
              context,
              products[index],
              edit: () => showAddProductForm(context, products[index]),
              // delete: () =>
              //     context.dashBoardProvider.deleteProduct(products[index]),
              delete: () async {
                final confirm = await showDeleteConfirmationDialog(context);
                if (confirm) {
                  context.dashBoardProvider.deleteProduct(products[index]);
                }
              },
            ),
          ),
        );

        if (needsScroll) {
          return Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: scrollController,
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
//  MOBILE TABLE  (card list — avoids the cramped DataTable on small screens)
// ─────────────────────────────────────────────────────────────────────────────
class _MobileProductTable extends StatelessWidget {
  final List<Product> products;
  const _MobileProductTable({required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text("No products found",
              style: TextStyle(color: Colors.white54)),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppSpacing.itemGap(context)),
      itemBuilder: (context, index) {
        final product = products[index];
        return _MobileProductCard(
          product: product,
          onEdit: () => showAddProductForm(context, product),
          onDelete: () => context.dashBoardProvider.deleteProduct(product),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  MOBILE PRODUCT CARD
// ─────────────────────────────────────────────────────────────────────────────
class _MobileProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _MobileProductCard({
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final thumbSize = AppImageSize.tableThumb(context);
    final bodySize = AppFontSize.body(context);
    final smSize = AppFontSize.sm(context);
    final iconSize = AppIconSize.tableAction(context);
    final hPad = AppSpacing.sm(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: hPad + 4,
        vertical: hPad + 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppRadius.sm(context)),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm(context)),
            child: Image.network(
              product.images?.first.fullUrl ?? '',
              height: thumbSize,
              width: thumbSize,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.broken_image,
                size: thumbSize,
                color: Colors.white38,
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm(context) + 4),

          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? '',
                  style: TextStyle(
                    fontSize: bodySize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  '${product.proCategoryId?.name ?? ''}'
                  '${product.proSubCategoryId?.name != null ? ' › ${product.proSubCategoryId!.name}' : ''}',
                  style: TextStyle(fontSize: smSize, color: Colors.white54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    fontSize: smSize,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Actions
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
//  SHARED: DataTable row builder  (used in desktop/tablet view)
// ─────────────────────────────────────────────────────────────────────────────
DataRow _productDataRow(
  BuildContext context,
  Product productInfo, {
  Function? edit,
  Function? delete,
}) {
  final thumbSize = AppImageSize.tableThumb(context);
  final iconSize = AppIconSize.tableAction(context);
  final hPad = AppSpacing.sm(context);

  return DataRow(
    cells: [
      // Product name + thumbnail
      DataCell(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                productInfo.images?.first.fullUrl ?? '',
                height: thumbSize,
                width: thumbSize,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.broken_image,
                  size: thumbSize,
                  color: Colors.white38,
                ),
              ),
            ),
            SizedBox(width: hPad),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 160),
              child: Text(
                productInfo.name ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(productInfo.proCategoryId?.name ?? '')),
      DataCell(Text(productInfo.proSubCategoryId?.name ?? '')),
      DataCell(Text('\$${productInfo.price}')),
      DataCell(
        IconButton(
          onPressed: () => edit?.call(),
          icon: Icon(Icons.edit, size: iconSize, color: Colors.white),
          tooltip: 'Edit',
        ),
      ),
      DataCell(
        IconButton(
          onPressed: () => delete?.call(),
          icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
          tooltip: 'Delete',
        ),
      ),
    ],
  );
}
