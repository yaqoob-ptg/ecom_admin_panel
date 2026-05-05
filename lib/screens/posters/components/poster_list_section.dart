// import 'package:admin/utility/extensions.dart';

// import '../../../core/data/data_provider.dart';
// import 'add_poster_form.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../models/poster.dart';
// import '../../../utility/constants.dart';

// class PosterListSection extends StatelessWidget {
//   const PosterListSection({
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
//             "All Posters",
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
//                       label: Text("Category Name"),
//                     ),
//                     DataColumn(
//                       label: Text("Edit"),
//                     ),
//                     DataColumn(
//                       label: Text("Delete"),
//                     ),
//                   ],
//                   rows: List.generate(
//                     dataProvider.posters.length,
//                     (index) =>
//                         posterDataRow(dataProvider.posters[index], delete: () {
//                       context.posterProvider
//                           .deletePoster(dataProvider.posters[index]);
//                     }, edit: () {
//                       showAddPosterForm(context, dataProvider.posters[index]);
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

// DataRow posterDataRow(Poster poster, {Function? edit, Function? delete}) {
//   return DataRow(
//     cells: [
//       DataCell(
//         Row(
//           children: [
//             Image.network(
//               poster.fullUrl ?? '',
//               height: 30,
//               width: 30,
//               errorBuilder: (BuildContext context, Object exception,
//                   StackTrace? stackTrace) {
//                 return Icon(Icons.error);
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               child: Text(poster.posterName ?? ''),
//             ),
//           ],
//         ),
//       ),
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
import 'add_poster_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/poster.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../sub_category/components/add_sub_category_form.dart'
    show showDeleteConfirmationDialog;

class PosterListSection extends StatelessWidget {
  const PosterListSection({Key? key}) : super(key: key);

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
            "All Posters",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: AppFontSize.sectionTitle(context),
                ),
          ),
          SizedBox(height: AppSpacing.sectionGap(context)),
          Consumer<DataProvider>(
            builder: (context, dataProvider, child) {
              return isMobile
                  ? _MobilePosterList(posters: dataProvider.posters)
                  : _DesktopPosterTable(posters: dataProvider.posters);
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DESKTOP TABLE — only 3 columns, min width 360px
// ─────────────────────────────────────────────────────────────────────────────
class _DesktopPosterTable extends StatelessWidget {
  final List<Poster> posters;
  const _DesktopPosterTable({required this.posters});

  static const double _minTableWidth = 360.0;

  @override
  Widget build(BuildContext context) {
    final cellFontSize = AppFontSize.tableCell(context);
    final thumbSize = AppImageSize.tableThumb(context);

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
            DataColumn(label: Text("Poster Name")),
            DataColumn(label: Text("Edit")),
            DataColumn(label: Text("Delete")),
          ],
          rows: List.generate(
            posters.length,
            (index) => _posterDataRow(
              context,
              posters[index],
              thumbSize,
              edit: () => showAddPosterForm(context, posters[index]),
              delete: () async {
                final confirmed = await showDeleteConfirmationDialog(
                  context,
                  title: 'Delete Poster',
                  message:
                      'Are you sure you want to delete "${posters[index].posterName}"? This action cannot be undone.',
                );
                if (confirmed) {
                  context.posterProvider.deletePoster(posters[index]);
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
//  MOBILE LIST — card per poster
// ─────────────────────────────────────────────────────────────────────────────
class _MobilePosterList extends StatelessWidget {
  final List<Poster> posters;
  const _MobilePosterList({required this.posters});

  @override
  Widget build(BuildContext context) {
    if (posters.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child:
              Text("No posters found", style: TextStyle(color: Colors.white54)),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posters.length,
      separatorBuilder: (_, __) =>
          SizedBox(height: AppSpacing.itemGap(context)),
      itemBuilder: (context, index) {
        final p = posters[index];
        return _MobilePosterCard(
          poster: p,
          onEdit: () => showAddPosterForm(context, p),
          onDelete: () async {
            final confirmed = await showDeleteConfirmationDialog(
              context,
              title: 'Delete Poster',
              message:
                  'Are you sure you want to delete "${p.posterName}"? This action cannot be undone.',
            );
            if (confirmed) {
              context.posterProvider.deletePoster(p);
            }
          },
        );
      },
    );
  }
}

class _MobilePosterCard extends StatelessWidget {
  final Poster poster;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _MobilePosterCard({
    required this.poster,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final thumbSize =
        AppImageSize.tableThumb(context) * 1.4; // slightly larger for posters
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
          // Poster thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm(context)),
            child: Image.network(
              poster.fullUrl ?? '',
              height: thumbSize,
              width: thumbSize,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: thumbSize,
                width: thumbSize,
                color: Colors.white10,
                child: Icon(Icons.broken_image,
                    size: thumbSize * 0.5, color: Colors.white38),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm(context) + 4),

          // Poster name
          Expanded(
            child: Text(
              poster.posterName ?? '',
              style: TextStyle(
                fontSize: AppFontSize.body(context),
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
DataRow _posterDataRow(
  BuildContext context,
  Poster poster,
  double thumbSize, {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              poster.fullUrl ?? '',
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
            constraints: const BoxConstraints(maxWidth: 200),
            child:
                Text(poster.posterName ?? '', overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
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
