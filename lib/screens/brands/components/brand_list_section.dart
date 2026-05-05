// import 'package:admin/utility/extensions.dart';

// import '../../../core/data/data_provider.dart';
// import 'add_brand_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/color_list.dart';
// import '../../../utility/constants.dart';
// import '../../../models/brand.dart';

// class BrandListSection extends StatelessWidget {
//   const BrandListSection({
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
//             "All Brands",
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
//                       label: Text("Brands Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Sub Category"),
//                     ),
//                     DataColumn(
//                       label: Text("Added Date"),
//                     ),
//                     DataColumn(
//                       label: Text("Edit"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     dataProvider.brands.length,
//                     (index) => brandDataRow(
//                         dataProvider.brands[index], index + 1, edit: () {
//                       showBrandForm(context, dataProvider.brands[index]);
//                     }, delete: () {
//                       context.brandProvider
//                           .deleteBrand(dataProvider.brands[index]);
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

// DataRow brandDataRow(Brand brandInfo, int index,
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
//               child: Text(brandInfo.name!),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(brandInfo.subcategoryId?.name ?? '')),
//       DataCell(Text(brandInfo.createdAt ?? '')),
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
import 'add_brand_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../models/brand.dart';
import '../../sub_category/components/add_sub_category_form.dart'
    show showDeleteConfirmationDialog;

class BrandListSection extends StatelessWidget {
  const BrandListSection({Key? key}) : super(key: key);

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
            "All Brands",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
          SizedBox(height: AppSpacing.sectionGap(context)),
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              return isMobile
                  ? _MobileBrandList(brands: dataProvider.brands)
                  : _DesktopBrandTable(brands: dataProvider.brands);
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DESKTOP TABLE — LayoutBuilder auto-scroll when container < minWidth
// ─────────────────────────────────────────────────────────────────────────────
class _DesktopBrandTable extends StatelessWidget {
  final List<Brand> brands;
  const _DesktopBrandTable({required this.brands});

  static const double _minTableWidth = 560.0;

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
            DataColumn(label: Text("Brand Name")),
            DataColumn(label: Text("Sub Category")),
            DataColumn(label: Text("Added Date")),
            DataColumn(label: Text("Edit")),
            DataColumn(label: Text("Delete")),
          ],
          rows: List.generate(
            brands.length,
            (index) => _brandDataRow(
              context,
              brands[index],
              index + 1,
              edit: () => showBrandForm(context, brands[index]),
              delete: () async {
                final confirmed = await showDeleteConfirmationDialog(
                  context,
                  title: 'Delete Brand',
                  message:
                      'Are you sure you want to delete "${brands[index].name}"? This action cannot be undone.',
                );
                if (confirmed) {
                  context.brandProvider.deleteBrand(brands[index]);
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
//  MOBILE LIST — card per brand
// ─────────────────────────────────────────────────────────────────────────────
class _MobileBrandList extends StatelessWidget {
  final List<Brand> brands;
  const _MobileBrandList({required this.brands});

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child:
              Text("No brands found", style: TextStyle(color: Colors.white54)),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: brands.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppSpacing.itemGap(context)),
      itemBuilder: (context, index) {
        final brand = brands[index];
        return _MobileBrandCard(
          brand: brand,
          index: index + 1,
          onEdit: () => showBrandForm(context, brand),
          onDelete: () async {
            final confirmed = await showDeleteConfirmationDialog(
              context,
              title: 'Delete Brand',
              message:
                  'Are you sure you want to delete "${brand.name}"? This action cannot be undone.',
            );
            if (confirmed) {
              context.brandProvider.deleteBrand(brand);
            }
          },
        );
      },
    );
  }
}

class _MobileBrandCard extends StatelessWidget {
  final Brand brand;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _MobileBrandCard({
    required this.brand,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = AppIconSize.tableAction(context);
    final hPad = AppSpacing.sm(context);

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

          // Brand info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand.name ?? '',
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
                  brand.subcategoryId?.name ?? '',
                  style: TextStyle(
                      fontSize: AppFontSize.sm(context), color: Colors.white54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  brand.createdAt ?? '',
                  style: TextStyle(
                      fontSize: AppFontSize.xs(context), color: Colors.white38),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
DataRow _brandDataRow(
  BuildContext context,
  Brand brandInfo,
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
            constraints: const BoxConstraints(maxWidth: 160),
            child: Text(brandInfo.name ?? '', overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
    DataCell(Text(brandInfo.subcategoryId?.name ?? '')),
    DataCell(Text(brandInfo.createdAt ?? '')),
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
