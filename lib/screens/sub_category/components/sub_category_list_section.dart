// // import 'package:admin/utility/extensions.dart';

// // import '../../../core/data/data_provider.dart';
// // import '../../../models/sub_category.dart';
// // import 'add_sub_category_form.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:provider/provider.dart';
// // import '../../../utility/color_list.dart';
// // import '../../../utility/constants.dart';
// // import '../../category/components/add_category_form.dart';

// // class SubCategoryListSection extends StatelessWidget {
// //   const SubCategoryListSection({
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
// //             "All SubCategory",
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
// //                       label: Text("SubCategory Name"),
// //                     ),
// //                     DataColumn(
// //                       label: Text("Category"),
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
// //                     dataProvider.subCategories.length,
// //                     (index) => subCategoryDataRow(
// //                       dataProvider.subCategories[index],
// //                       index + 1,
// //                       edit: () {
// //                         showAddSubCategoryForm(
// //                             context, dataProvider.subCategories[index]);
// //                       },
// //                       delete: () {
// //                         context.subCategoryProvider.deleteSubCategory(
// //                             dataProvider.subCategories[index]);
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

// // DataRow subCategoryDataRow(SubCategory subCatInfo, int index,
// //     {Function? edit, Function? delete}) {
// //   return DataRow(
// //     cells: [
// //       DataCell(
// //         Row(
// //           children: [
// //             Container(
// //               height: 24,
// //               width: 24,
// //               decoration: BoxDecoration(
// //                 color: colors[index % colors.length],
// //                 shape: BoxShape.circle,
// //               ),
// //               child: Center(
// //                   child: Text(
// //                 index.toString(),
// //               )),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
// //               child: Text(subCatInfo.name ?? ''),
// //             ),
// //           ],
// //         ),
// //       ),
// //       DataCell(Text(subCatInfo.categoryId?.name ?? '')),
// //       DataCell(Text(subCatInfo.createdAt ?? '')),
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
// import '../../../models/sub_category.dart';
// import 'add_sub_category_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/color_list.dart';
// import '../../../utility/constants.dart';
// import '../../../utility/responsive_constants.dart';

// class SubCategoryListSection extends StatelessWidget {
//   const SubCategoryListSection({Key? key}) : super(key: key);

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
//             "All SubCategories",
//             style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   fontSize: AppFontSize.sectionTitle(context),
//                 ),
//           ),
//           SizedBox(height: AppSpacing.sectionGap(context)),
//           Consumer<DataProvider>(
//             builder: (context, dataProvider, child) {
//               return isMobile
//                   ? _MobileSubCategoryList(
//                       subCategories: dataProvider.subCategories)
//                   : _DesktopSubCategoryTable(
//                       subCategories: dataProvider.subCategories);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  DESKTOP TABLE
// // ─────────────────────────────────────────────────────────────────────────────
// class _DesktopSubCategoryTable extends StatelessWidget {
//   final List<SubCategory> subCategories;
//   const _DesktopSubCategoryTable({required this.subCategories});

//   static const double _minTableWidth = 580.0;

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
//             DataColumn(label: Text("SubCategory Name")),
//             DataColumn(label: Text("Category")),
//             DataColumn(label: Text("Added Date")),
//             DataColumn(label: Text("Edit")),
//             DataColumn(label: Text("Delete")),
//           ],
//           rows: List.generate(
//             subCategories.length,
//             (index) => _subCategoryDataRow(
//               context,
//               subCategories[index],
//               index + 1,
//               edit: () => showAddSubCategoryForm(context, subCategories[index]),
//               delete: () async {
//                 final confirmed = await showDeleteConfirmationDialog(
//                   context,
//                   title: 'Delete Sub Category',
//                   message:
//                       'Are you sure you want to delete "${subCategories[index].name}"? This action cannot be undone.',
//                 );
//                 if (confirmed) {
//                   context.subCategoryProvider
//                       .deleteSubCategory(subCategories[index]);
//                 }
//               },
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
// //  MOBILE LIST
// // ─────────────────────────────────────────────────────────────────────────────
// class _MobileSubCategoryList extends StatelessWidget {
//   final List<SubCategory> subCategories;
//   const _MobileSubCategoryList({required this.subCategories});

//   @override
//   Widget build(BuildContext context) {
//     if (subCategories.isEmpty) {
//       return const Center(
//         child: Padding(
//           padding: EdgeInsets.all(24),
//           child: Text("No sub categories found",
//               style: TextStyle(color: Colors.white54)),
//         ),
//       );
//     }
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: subCategories.length,
//       separatorBuilder: (_, __) =>
//           SizedBox(height: AppSpacing.itemGap(context)),
//       itemBuilder: (context, index) {
//         final sub = subCategories[index];
//         return _MobileSubCategoryCard(
//           subCategory: sub,
//           index: index + 1,
//           onEdit: () => showAddSubCategoryForm(context, sub),
//           onDelete: () async {
//             final confirmed = await showDeleteConfirmationDialog(
//               context,
//               title: 'Delete Sub Category',
//               message:
//                   'Are you sure you want to delete "${sub.name}"? This action cannot be undone.',
//             );
//             if (confirmed) {
//               context.subCategoryProvider.deleteSubCategory(sub);
//             }
//           },
//         );
//       },
//     );
//   }
// }

// class _MobileSubCategoryCard extends StatelessWidget {
//   final SubCategory subCategory;
//   final int index;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;

//   const _MobileSubCategoryCard({
//     required this.subCategory,
//     required this.index,
//     required this.onEdit,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
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
//           // Coloured index badge
//           Container(
//             height: 28,
//             width: 28,
//             decoration: BoxDecoration(
//               color: colors[index % colors.length],
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 index.toString(),
//                 style: TextStyle(
//                   fontSize: AppFontSize.xs(context),
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: AppSpacing.sm(context) + 4),

//           // Name + category + date
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   subCategory.name ?? '',
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
//                   subCategory.categoryId?.name ?? '',
//                   style: TextStyle(
//                       fontSize: AppFontSize.sm(context), color: Colors.white54),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 2),
//                 Text(
//                   subCategory.createdAt ?? '',
//                   style: TextStyle(
//                       fontSize: AppFontSize.xs(context), color: Colors.white38),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
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
// //  DESKTOP DataRow builder
// // ─────────────────────────────────────────────────────────────────────────────
// DataRow _subCategoryDataRow(
//   BuildContext context,
//   SubCategory subCatInfo,
//   int index, {
//   Function? edit,
//   Function? delete,
// }) {
//   final iconSize = AppIconSize.tableAction(context);
//   final hPad = AppSpacing.sm(context);

//   return DataRow(cells: [
//     DataCell(
//       Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 24,
//             width: 24,
//             decoration: BoxDecoration(
//               color: colors[index % colors.length],
//               shape: BoxShape.circle,
//             ),
//             child: Center(
//               child: Text(
//                 index.toString(),
//                 style: TextStyle(
//                   fontSize: AppFontSize.xs(context),
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: hPad),
//           ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 160),
//             child: Text(subCatInfo.name ?? '', overflow: TextOverflow.ellipsis),
//           ),
//         ],
//       ),
//     ),
//     DataCell(Text(subCatInfo.categoryId?.name ?? '')),
//     DataCell(Text(subCatInfo.createdAt ?? '')),
//     DataCell(IconButton(
//       onPressed: () => edit?.call(),
//       icon: Icon(Icons.edit, size: iconSize, color: Colors.white),
//       tooltip: 'Edit',
//     )),
//     DataCell(IconButton(
//       onPressed: () => delete?.call(),
//       icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
//       tooltip: 'Delete',
//     )),
//   ]);
// }

import 'package:admin/utility/extensions.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/sub_category.dart';
import 'add_sub_category_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';

class SubCategoryListSection extends StatelessWidget {
  const SubCategoryListSection({Key? key}) : super(key: key);

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
            "All SubCategories",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
          SizedBox(height: AppSpacing.sectionGap(context)),
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              return isMobile
                  ? _MobileSubCategoryList(
                      subCategories: dataProvider.subCategories)
                  : _DesktopSubCategoryTable(
                      subCategories: dataProvider.subCategories);
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
class _DesktopSubCategoryTable extends StatelessWidget {
  final List<SubCategory> subCategories;
  const _DesktopSubCategoryTable({required this.subCategories});

  static const double _minTableWidth = 580.0;

  @override
  Widget build(BuildContext context) {
    final cellFontSize = AppFontSize.tableCell(context);
    final isSuperAdmin = context.userProvider.user?.role == 'superAdmin';

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
            DataColumn(label: Text("SubCategory Name")),
            DataColumn(label: Text("Category")),
            DataColumn(label: Text("Added Date")),
            DataColumn(label: Text("Edit")),
            DataColumn(label: Text("Delete")),
          ],
          rows: List.generate(
            subCategories.length,
            (index) => _subCategoryDataRow(
              context,
              subCategories[index],
              index + 1,
              edit: () => showAddSubCategoryForm(context, subCategories[index]),
              delete: () async {
                final confirmed = await showDeleteConfirmationDialog(
                  context,
                  title: 'Delete Sub Category',
                  message:
                      'Are you sure you want to delete "${subCategories[index].name}"? This action cannot be undone.',
                );
                if (confirmed) {
                  context.subCategoryProvider
                      .deleteSubCategory(subCategories[index]);
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
class _MobileSubCategoryList extends StatelessWidget {
  final List<SubCategory> subCategories;
  const _MobileSubCategoryList({required this.subCategories});

  @override
  Widget build(BuildContext context) {
    if (subCategories.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text("No sub categories found",
              style: TextStyle(color: Colors.white54)),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subCategories.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppSpacing.itemGap(context)),
      itemBuilder: (context, index) {
        final sub = subCategories[index];
        return _MobileSubCategoryCard(
          subCategory: sub,
          index: index + 1,
          onEdit: () => showAddSubCategoryForm(context, sub),
          onDelete: () async {
            final confirmed = await showDeleteConfirmationDialog(
              context,
              title: 'Delete Sub Category',
              message:
                  'Are you sure you want to delete "${sub.name}"? This action cannot be undone.',
            );
            if (confirmed) {
              context.subCategoryProvider.deleteSubCategory(sub);
            }
          },
        );
      },
    );
  }
}

class _MobileSubCategoryCard extends StatelessWidget {
  final SubCategory subCategory;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _MobileSubCategoryCard({
    required this.subCategory,
    required this.index,
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
          // Coloured index badge
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

          // Name + category + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subCategory.name ?? '',
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
                  subCategory.categoryId?.name ?? '',
                  style: TextStyle(
                      fontSize: AppFontSize.sm(context), color: Colors.white54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  subCategory.createdAt ?? '',
                  style: TextStyle(
                      fontSize: AppFontSize.xs(context), color: Colors.white38),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Edit Button - Conditional based on role
          if (isSuperAdmin)
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit, size: iconSize, color: Colors.white70),
              visualDensity: VisualDensity.compact,
              tooltip: 'Edit SubCategory',
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

          // Delete Button - Conditional based on role
          if (isSuperAdmin)
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
              visualDensity: VisualDensity.compact,
              tooltip: 'Delete SubCategory',
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
//  DESKTOP DataRow builder
// ─────────────────────────────────────────────────────────────────────────────
DataRow _subCategoryDataRow(
  BuildContext context,
  SubCategory subCatInfo,
  int index, {
  Function? edit,
  Function? delete,
}) {
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
            constraints: const BoxConstraints(maxWidth: 160),
            child: Text(subCatInfo.name ?? '', overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
    DataCell(Text(subCatInfo.categoryId?.name ?? '')),
    DataCell(Text(subCatInfo.createdAt ?? '')),

    // Edit Button Cell
    DataCell(
      isSuperAdmin
          ? IconButton(
              onPressed: () => edit?.call(),
              icon: Icon(Icons.edit, size: iconSize, color: Colors.white),
              tooltip: 'Edit SubCategory',
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
              onPressed: () => delete?.call(),
              icon: Icon(Icons.delete, size: iconSize, color: Colors.redAccent),
              tooltip: 'Delete SubCategory',
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

// Helper function for delete confirmation dialog
Future<bool> showDeleteConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          backgroundColor: secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
              child: const Text('Delete'),
            ),
          ],
        ),
      ) ??
      false;
}
