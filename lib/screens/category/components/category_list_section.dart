// // import 'package:admin/utility/extensions.dart';

// // import '../../../core/data/data_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../../../utility/constants.dart';
// // import '../../../models/category.dart';
// // import 'add_category_form.dart';

// // class CategoryListSection extends StatelessWidget {
// //   const CategoryListSection({
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
// //             "All Categories",
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
// //                       label: Text("Category Name"),
// //                     ),
// //                     DataColumn(
// //                       label: Text("Added Date"),
// //                     ),
// //                     DataColumn(
// //                       label: Text("Edit"),
// //                     ),
// //                     DataColumn(
// //                       label: Text("Delete"),
// //                     ),
// //                   ],
// //                   rows: List.generate(
// //                     dataProvider.categories.length,
// //                     (index) => categoryDataRow(dataProvider.categories[index],
// //                         delete: () {
// //                       context.categoryProvider
// //                           .deleteCategory(dataProvider.categories[index]);
// //                     }, edit: () {
// //                       showAddCategoryForm(
// //                           context, dataProvider.categories[index]);
// //                     }),
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

// // DataRow categoryDataRow(Category CatInfo, {Function? edit, Function? delete}) {
// //   return DataRow(
// //     cells: [
// //       DataCell(
// //         Row(
// //           children: [
// //             Image.network(
// //               CatInfo.fullUrl ?? '',
// //               height: 30,
// //               width: 30,
// //               errorBuilder: (BuildContext context, Object exception,
// //                   StackTrace? stackTrace) {
// //                 return Icon(Icons.error);
// //               },
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
// //               child: Text(CatInfo.name ?? ''),
// //             ),
// //           ],
// //         ),
// //       ),
// //       DataCell(Text(CatInfo.createdAt ?? '')),
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

// import 'package:admin/utility/extensions.dart';
// import '../../../core/data/data_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
// import '../../../utility/responsive_constants.dart';
// import '../../../models/category.dart';
// import 'add_category_form.dart';

// class CategoryListSection extends StatelessWidget {
//   const CategoryListSection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = AppBreakpoints.isMobile(context);
//     final padding = AppSpacing.cardPadding(context);

//     return Container(
//       padding: padding,
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: BorderRadius.all(Radius.circular(AppRadius.md(context))),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "All Categories",
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   fontSize: AppFontSize.sectionTitle(context),
//                 ),
//           ),
//           SizedBox(height: AppSpacing.sectionGap(context)),
//           Consumer<DataProvider>(
//             builder: (context, dataProvider, child) {
//               return isMobile
//                   ? _MobileCategoryList(categories: dataProvider.categories)
//                   : _DesktopCategoryTable(categories: dataProvider.categories);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  DESKTOP TABLE — LayoutBuilder-based scroll (same pattern as ProductListSection)
// // ─────────────────────────────────────────────────────────────────────────────
// class _DesktopCategoryTable extends StatelessWidget {
//   final List<Category> categories;
//   const _DesktopCategoryTable({required this.categories});

//   static const double _minTableWidth = 520.0;

//   @override
//   Widget build(BuildContext context) {
//     final cellFontSize = AppFontSize.tableCell(context);

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final needsScroll = constraints.maxWidth < _minTableWidth;

//         final table = DataTable(
//           columnSpacing: 12,
//           horizontalMargin: 10,
//           headingTextStyle: TextStyle(
//             fontSize: cellFontSize,
//             fontWeight: FontWeight.w600,
//             color: Colors.white70,
//           ),
//           dataTextStyle: TextStyle(fontSize: cellFontSize, color: Colors.white),
//           columns: const [
//             DataColumn(label: Text("Category Name")),
//             DataColumn(label: Text("Added Date")),
//             DataColumn(label: Text("Edit")),
//             DataColumn(label: Text("Delete")),
//           ],
//           rows: List.generate(
//             categories.length,
//             (index) => _categoryDataRow(
//               context,
//               categories[index],
//               edit: () => showAddCategoryForm(context, categories[index]),
//               delete: () =>
//                   context.categoryProvider.deleteCategory(categories[index]),
//             ),
//           ),
//         );

//         if (needsScroll) {
//           return Scrollbar(
//             thumbVisibility: true,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(minWidth: _minTableWidth),
//                 child: table,
//               ),
//             ),
//           );
//         }
//         return SizedBox(width: double.infinity, child: table);
//       },
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  MOBILE LIST — card per category
// // ─────────────────────────────────────────────────────────────────────────────
// class _MobileCategoryList extends StatelessWidget {
//   final List<Category> categories;
//   const _MobileCategoryList({required this.categories});

//   @override
//   Widget build(BuildContext context) {
//     if (categories.isEmpty) {
//       return const Center(
//         child: Padding(
//           padding: EdgeInsets.all(24),
//           child: Text("No categories found",
//               style: TextStyle(color: Colors.white54)),
//         ),
//       );
//     }
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: categories.length,
//       separatorBuilder: (_, __) =>
//           SizedBox(height: AppSpacing.itemGap(context)),
//       itemBuilder: (context, index) {
//         final cat = categories[index];
//         return _MobileCategoryCard(
//           category: cat,
//           onEdit: () => showAddCategoryForm(context, cat),
//           onDelete: () => context.categoryProvider.deleteCategory(cat),
//         );
//       },
//     );
//   }
// }

// class _MobileCategoryCard extends StatelessWidget {
//   final Category category;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;
//   const _MobileCategoryCard({
//     required this.category,
//     required this.onEdit,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final thumbSize = AppImageSize.tableThumb(context);
//     final iconSize = AppIconSize.tableAction(context);
//     final hPad = AppSpacing.sm(context);

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: hPad + 4, vertical: hPad + 2),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(AppRadius.sm(context)),
//         border: Border.all(color: Colors.white12),
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(AppRadius.sm(context)),
//             child: Image.network(
//               category.fullUrl ?? '',
//               height: thumbSize,
//               width: thumbSize,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => Icon(Icons.broken_image,
//                   size: thumbSize, color: Colors.white38),
//             ),
//           ),
//           SizedBox(width: AppSpacing.sm(context) + 4),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   category.name ?? '',
//                   style: TextStyle(
//                     fontSize: AppFontSize.body(context),
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   category.createdAt ?? '',
//                   style: TextStyle(
//                       fontSize: AppFontSize.sm(context), color: Colors.white54),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
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
// //  SHARED DataRow builder (desktop/tablet)
// // ─────────────────────────────────────────────────────────────────────────────
// DataRow _categoryDataRow(
//   BuildContext context,
//   Category catInfo, {
//   Function? edit,
//   Function? delete,
// }) {
//   final thumbSize = AppImageSize.tableThumb(context);
//   final iconSize = AppIconSize.tableAction(context);
//   final hPad = AppSpacing.sm(context);

//   return DataRow(cells: [
//     DataCell(
//       Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4),
//             child: Image.network(
//               catInfo.fullUrl ?? '',
//               height: thumbSize,
//               width: thumbSize,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => Icon(Icons.broken_image,
//                   size: thumbSize, color: Colors.white38),
//             ),
//           ),
//           SizedBox(width: hPad),
//           ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 180),
//             child: Text(catInfo.name ?? '', overflow: TextOverflow.ellipsis),
//           ),
//         ],
//       ),
//     ),
//     DataCell(Text(catInfo.createdAt ?? '')),
//     DataCell(IconButton(
//       onPressed: () =>
//           context.userProvider.user?.role == 'superAdmin' && edit != null
//               ? edit()
//               : null,
//       icon: Icon(Icons.edit, size: iconSize, color: Colors.white),
//       tooltip: 'Edit',
//     )),
//     DataCell(IconButton(
//       onPressed: () =>
//           context.userProvider.user?.role == 'superAdmin' && delete != null
//               ? delete()
//               : null,
//       icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
//       tooltip: 'Delete',
//     )),
//   ]);
// }

import 'package:admin/utility/extensions.dart';
import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../models/category.dart';
import 'add_category_form.dart';

class CategoryListSection extends StatelessWidget {
  const CategoryListSection({Key? key}) : super(key: key);

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
            "All Categories",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
          SizedBox(height: AppSpacing.sectionGap(context)),
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              return isMobile
                  ? _MobileCategoryList(categories: dataProvider.categories)
                  : _DesktopCategoryTable(categories: dataProvider.categories);
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DESKTOP TABLE — LayoutBuilder-based scroll (same pattern as ProductListSection)
// ─────────────────────────────────────────────────────────────────────────────
class _DesktopCategoryTable extends StatelessWidget {
  final List<Category> categories;
  const _DesktopCategoryTable({required this.categories});

  static const double _minTableWidth = 520.0;

  @override
  Widget build(BuildContext context) {
    final cellFontSize = AppFontSize.tableCell(context);
    // final isSuperAdmin = context.userProvider.user?.role == 'superAdmin';

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
            DataColumn(label: Text("Category Name")),
            DataColumn(label: Text("Added Date")),
            DataColumn(label: Text("Edit")),
            DataColumn(label: Text("Delete")),
          ],
          rows: List.generate(
            categories.length,
            (index) => _categoryDataRow(
              context,
              categories[index],
              edit: () => showAddCategoryForm(context, categories[index]),
              delete: () =>
                  context.categoryProvider.deleteCategory(categories[index]),
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
//  MOBILE LIST — card per category
// ─────────────────────────────────────────────────────────────────────────────
class _MobileCategoryList extends StatelessWidget {
  final List<Category> categories;
  const _MobileCategoryList({required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text("No categories found",
              style: TextStyle(color: Colors.white54)),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppSpacing.itemGap(context)),
      itemBuilder: (context, index) {
        final cat = categories[index];
        return _MobileCategoryCard(
          category: cat,
          onEdit: () => showAddCategoryForm(context, cat),
          onDelete: () => context.categoryProvider.deleteCategory(cat),
        );
      },
    );
  }
}

class _MobileCategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _MobileCategoryCard({
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  bool _isSuperAdmin(BuildContext context) {
    return context.userProvider.user?.role == 'superAdmin';
  }

  void _showPermissionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Only Super Admins can perform this action',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final thumbSize = AppImageSize.tableThumb(context);
    final iconSize = AppIconSize.tableAction(context);
    final hPad = AppSpacing.sm(context);
    final isSuperAdmin = _isSuperAdmin(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad + 4, vertical: hPad + 2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppRadius.sm(context)),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm(context)),
            child: Image.network(
              category.fullUrl,
              height: thumbSize,
              width: thumbSize,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.broken_image,
                  size: thumbSize, color: Colors.white38),
            ),
          ),
          SizedBox(width: AppSpacing.sm(context) + 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name ?? '',
                  style: TextStyle(
                    fontSize: AppFontSize.body(context),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  category.createdAt ?? '',
                  style: TextStyle(
                      fontSize: AppFontSize.sm(context), color: Colors.white54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Edit Button - Conditional rendering based on role
          if (isSuperAdmin)
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit, size: iconSize, color: Colors.white70),
              visualDensity: VisualDensity.compact,
              tooltip: 'Edit Category',
            )
          else
            Tooltip(
              message: 'Only Super Admins can edit',
              child: IconButton(
                onPressed: () => _showPermissionSnackBar(context),
                icon: Icon(Icons.edit, size: iconSize, color: Colors.grey),
                visualDensity: VisualDensity.compact,
                tooltip: 'Edit (Disabled)',
              ),
            ),

          // Delete Button - Conditional rendering based on role
          if (isSuperAdmin)
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
              visualDensity: VisualDensity.compact,
              tooltip: 'Delete Category',
            )
          else
            Tooltip(
              message: 'Only Super Admins can delete',
              child: IconButton(
                onPressed: () => _showPermissionSnackBar(context),
                icon: Icon(Icons.delete, size: iconSize, color: Colors.grey),
                visualDensity: VisualDensity.compact,
                tooltip: 'Delete (Disabled)',
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SHARED DataRow builder (desktop/tablet)
// ─────────────────────────────────────────────────────────────────────────────
DataRow _categoryDataRow(
  BuildContext context,
  Category catInfo, {
  Function? edit,
  Function? delete,
}) {
  final thumbSize = AppImageSize.tableThumb(context);
  final iconSize = AppIconSize.tableAction(context);
  final hPad = AppSpacing.sm(context);
  final isSuperAdmin = context.userProvider.user?.role == 'superAdmin';

  void _showPermissionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Only Super Admins can perform this action',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  return DataRow(cells: [
    DataCell(
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              catInfo.fullUrl ?? '',
              height: thumbSize,
              width: thumbSize,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.broken_image,
                  size: thumbSize, color: Colors.white38),
            ),
          ),
          SizedBox(width: hPad),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 180),
            child: Text(catInfo.name ?? '', overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
    DataCell(Text(catInfo.createdAt ?? '')),

    // Edit Button Cell
    DataCell(
      isSuperAdmin
          ? IconButton(
              onPressed: () => edit != null ? edit() : null,
              icon: Icon(Icons.edit, size: iconSize, color: Colors.white),
              tooltip: 'Edit Category',
            )
          : Tooltip(
              message: 'Only Super Admins can edit',
              child: IconButton(
                onPressed: () => _showPermissionSnackBar(context),
                icon: Icon(Icons.edit, size: iconSize, color: Colors.grey),
                tooltip: 'Edit (Disabled)',
              ),
            ),
    ),

    // Delete Button Cell
    DataCell(
      isSuperAdmin
          ? IconButton(
              onPressed: () => delete != null ? delete() : null,
              icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
              tooltip: 'Delete Category',
            )
          : Tooltip(
              message: 'Only Super Admins can delete',
              child: IconButton(
                onPressed: () => _showPermissionSnackBar(context),
                icon: Icon(Icons.delete, size: iconSize, color: Colors.grey),
                tooltip: 'Delete (Disabled)',
              ),
            ),
    ),
  ]);
}
