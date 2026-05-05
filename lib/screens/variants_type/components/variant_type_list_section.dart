// import 'package:admin/utility/extensions.dart';

// import '../../../core/data/data_provider.dart';
// import 'add_variant_type_form.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/color_list.dart';
// import '../../../utility/constants.dart';
// import '../../../models/variant_type.dart';

// class VariantsTypeListSection extends StatelessWidget {
//   const VariantsTypeListSection({
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
//             "All Variants Type",
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
//                       label: Text("Variant Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Variant Type"),
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
//                     dataProvider.variantTypes.length,
//                     (index) => variantTypeDataRow(
//                       dataProvider.variantTypes[index],
//                       index + 1,
//                       edit: () {
//                         showAddVariantsTypeForm(
//                             context, dataProvider.variantTypes[index]);
//                       },
//                       delete: () {
//                         context.variantTypeProvider.deleteVariantType(
//                             dataProvider.variantTypes[index]);
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

// DataRow variantTypeDataRow(VariantType VariantTypeInfo, int index,
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
//               child: Text(VariantTypeInfo.name ?? ''),
//             ),
//           ],
//         ),
//       ),
//       DataCell(Text(VariantTypeInfo.type ?? '')),
//       DataCell(Text(VariantTypeInfo.createdAt ?? '')),
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
import 'add_variant_type_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../models/variant_type.dart';
import '../../sub_category/components/add_sub_category_form.dart'
    show showDeleteConfirmationDialog;

class VariantsTypeListSection extends StatelessWidget {
  const VariantsTypeListSection({Key? key}) : super(key: key);

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
            "All Variant Types",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
          SizedBox(height: AppSpacing.sectionGap(context)),
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              return isMobile
                  ? _MobileVariantTypeList(
                      variantTypes: dataProvider.variantTypes)
                  : _DesktopVariantTypeTable(
                      variantTypes: dataProvider.variantTypes);
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
class _DesktopVariantTypeTable extends StatelessWidget {
  final List<VariantType> variantTypes;
  const _DesktopVariantTypeTable({required this.variantTypes});

  static const double _minTableWidth = 540.0;

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
            DataColumn(label: Text("Variant Name")),
            DataColumn(label: Text("Variant Type")),
            DataColumn(label: Text("Added Date")),
            DataColumn(label: Text("Edit")),
            DataColumn(label: Text("Delete")),
          ],
          rows: List.generate(
            variantTypes.length,
            (index) => _variantTypeDataRow(
              context,
              variantTypes[index],
              index + 1,
              edit: () => showAddVariantsTypeForm(context, variantTypes[index]),
              delete: () async {
                final confirmed = await showDeleteConfirmationDialog(
                  context,
                  title: 'Delete Variant Type',
                  message:
                      'Are you sure you want to delete "${variantTypes[index].name}"? This action cannot be undone.',
                );
                if (confirmed) {
                  context.variantTypeProvider
                      .deleteVariantType(variantTypes[index]);
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
class _MobileVariantTypeList extends StatelessWidget {
  final List<VariantType> variantTypes;
  const _MobileVariantTypeList({required this.variantTypes});

  @override
  Widget build(BuildContext context) {
    if (variantTypes.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text("No variant types found",
              style: TextStyle(color: Colors.white54)),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: variantTypes.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppSpacing.itemGap(context)),
      itemBuilder: (context, index) {
        final vt = variantTypes[index];
        return _MobileVariantTypeCard(
          variantType: vt,
          index: index + 1,
          onEdit: () => showAddVariantsTypeForm(context, vt),
          onDelete: () async {
            final confirmed = await showDeleteConfirmationDialog(
              context,
              title: 'Delete Variant Type',
              message:
                  'Are you sure you want to delete "${vt.name}"? This action cannot be undone.',
            );
            if (confirmed) {
              context.variantTypeProvider.deleteVariantType(vt);
            }
          },
        );
      },
    );
  }
}

class _MobileVariantTypeCard extends StatelessWidget {
  final VariantType variantType;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _MobileVariantTypeCard({
    required this.variantType,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  variantType.name ?? '',
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
                  variantType.type ?? '',
                  style: TextStyle(
                      fontSize: AppFontSize.sm(context), color: Colors.white54),
                ),
                SizedBox(height: 2),
                Text(
                  variantType.createdAt ?? '',
                  style: TextStyle(
                      fontSize: AppFontSize.xs(context), color: Colors.white38),
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
DataRow _variantTypeDataRow(
  BuildContext context,
  VariantType vtInfo,
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
            constraints: const BoxConstraints(maxWidth: 150),
            child: Text(vtInfo.name ?? '', overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
    DataCell(Text(vtInfo.type ?? '')),
    DataCell(Text(vtInfo.createdAt ?? '')),
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
