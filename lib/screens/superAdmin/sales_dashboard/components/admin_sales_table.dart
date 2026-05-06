import 'package:admin/models/sales_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utility/constants.dart';
import '../../../../utility/responsive.dart';
import '../provider/sales_dashboard_provider.dart';

class AdminSalesTable extends StatelessWidget {
  const AdminSalesTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesDashboardProvider>(
      builder: (_, prov, __) {
        final stats = prov.adminStats;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sales by Admin',
                      style: Theme.of(context).textTheme.titleMedium),
                  Text('${stats.length} admins',
                      style:
                          const TextStyle(fontSize: 11, color: Colors.white38)),
                ],
              ),
              const SizedBox(height: 16),
              if (stats.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text('No data',
                        style: TextStyle(color: Colors.white38)),
                  ),
                )
              else
                Responsive.isMobile(context)
                    ? _MobileAdminList(stats: stats)
                    : _DesktopAdminTable(stats: stats),
            ],
          ),
        );
      },
    );
  }
}

// ── Desktop ────────────────────────────────────────────────────────────────

class _DesktopAdminTable extends StatelessWidget {
  final List<AdminSalesStat> stats;
  const _DesktopAdminTable({required this.stats});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: constraints.maxWidth,
        child: DataTable(
          horizontalMargin: 8,
          columnSpacing: 12,
          dataRowMinHeight: 52,
          dataRowMaxHeight: 60,
          headingRowColor:
              WidgetStateProperty.all(Colors.white.withOpacity(0.05)),
          columns: const [
            DataColumn(label: Expanded(flex: 1, child: Text('#'))),
            DataColumn(label: Expanded(flex: 4, child: Text('Admin'))),
            DataColumn(label: Expanded(flex: 3, child: Text('Revenue'))),
            DataColumn(label: Expanded(flex: 2, child: Text('Orders'))),
            DataColumn(label: Expanded(flex: 2, child: Text('Pending'))),
            DataColumn(label: Expanded(flex: 2, child: Text('Shipped'))),
            DataColumn(label: Expanded(flex: 2, child: Text('Delivered'))),
            DataColumn(label: Expanded(flex: 2, child: Text('Cancelled'))),
          ],
          rows: stats.asMap().entries.map((e) {
            final i = e.key + 1;
            final stat = e.value;
            return DataRow(cells: [
              DataCell(Expanded(
                  flex: 1,
                  child: Text('$i',
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12)))),
              DataCell(Expanded(
                  flex: 4, child: _AdminNameCell(stat: stat, rank: i))),
              DataCell(Expanded(
                  flex: 3,
                  child: Text('Rs. ${_fmt(stat.totalSales)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                          fontSize: 13)))),
              DataCell(Expanded(
                  flex: 2,
                  child: Text('${stat.orderCount}',
                      style: const TextStyle(fontSize: 13)))),
              DataCell(Expanded(
                  flex: 2,
                  child:
                      _NumBadge(stat.pendingOrders, const Color(0xFFFFC107)))),
              DataCell(Expanded(
                  flex: 2,
                  child:
                      _NumBadge(stat.shippedOrders, const Color(0xFF667EEA)))),
              DataCell(Expanded(
                  flex: 2,
                  child: _NumBadge(
                      stat.deliveredOrders, const Color(0xFF4CAF50)))),
              DataCell(Expanded(
                  flex: 2,
                  child: _NumBadge(
                      stat.cancelledOrders, const Color(0xFFFF6B6B)))),
            ]);
          }).toList(),
        ),
      );
    });
  }
}

// ── Mobile ─────────────────────────────────────────────────────────────────

class _MobileAdminList extends StatelessWidget {
  final List<AdminSalesStat> stats;
  const _MobileAdminList({required this.stats});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      separatorBuilder: (_, __) =>
          const Divider(color: Colors.white12, height: 1),
      itemBuilder: (_, i) {
        final stat = stats[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AdminNameCell(stat: stat, rank: i + 1),
              const SizedBox(height: 8),
              Row(
                children: [
                  _MiniStat('Revenue', 'Rs. ${_fmt(stat.totalSales)}',
                      const Color(0xFF4CAF50)),
                  const SizedBox(width: 8),
                  _MiniStat('Orders', '${stat.orderCount}', Colors.white70),
                ],
              ),
              const SizedBox(height: 6),
              Row(children: [
                _MiniStat('Pending', '${stat.pendingOrders}',
                    const Color(0xFFFFC107)),
                const SizedBox(width: 8),
                _MiniStat('Shipped', '${stat.shippedOrders}',
                    const Color(0xFF667EEA)),
                const SizedBox(width: 8),
                _MiniStat('Delivered', '${stat.deliveredOrders}',
                    const Color(0xFF4CAF50)),
                const SizedBox(width: 8),
                _MiniStat('Cancelled', '${stat.cancelledOrders}',
                    const Color(0xFFFF6B6B)),
              ]),
            ],
          ),
        );
      },
    );
  }
}

// ── Shared sub-widgets ──────────────────────────────────────────────────────

class _AdminNameCell extends StatelessWidget {
  final AdminSalesStat stat;
  final int rank;
  const _AdminNameCell({required this.stat, required this.rank});

  @override
  Widget build(BuildContext context) {
    final rankColor = rank == 1
        ? const Color(0xFFFFD700)
        : rank == 2
            ? const Color(0xFFC0C0C0)
            : rank == 3
                ? const Color(0xFFCD7F32)
                : Colors.white30;

    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: rankColor.withOpacity(0.15),
          shape: BoxShape.circle,
          border: Border.all(color: rankColor.withOpacity(0.5)),
        ),
        child: Center(
          child: Text('$rank',
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: rankColor)),
        ),
      ),
      const SizedBox(width: 10),
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(stat.adminName,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis),
            Text(stat.adminEmail,
                style: const TextStyle(fontSize: 10, color: Colors.white38),
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    ]);
  }
}

class _NumBadge extends StatelessWidget {
  final int value;
  final Color color;
  const _NumBadge(this.value, this.color);

  @override
  Widget build(BuildContext context) {
    if (value == 0) {
      return Text('—', style: TextStyle(color: Colors.white24, fontSize: 12));
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text('$value',
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: color)),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MiniStat(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          Text(label,
              style: const TextStyle(fontSize: 9, color: Colors.white38)),
        ],
      ),
    );
  }
}

String _fmt(double v) {
  if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
  if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
  return v.toStringAsFixed(2);
}



// import 'package:admin/models/sales_dashboard.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../utility/constants.dart';
// import '../../../../utility/responsive.dart';
// import '../provider/sales_dashboard_provider.dart';

// class AdminSalesTable extends StatelessWidget {
//   const AdminSalesTable({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SalesDashboardProvider>(
//       builder: (_, prov, __) {
//         final stats = prov.adminStats;

//         return Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: secondaryColor,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Sales by Admin',
//                       style: Theme.of(context).textTheme.titleMedium),
//                   Text('${stats.length} admins',
//                       style: const TextStyle(
//                           fontSize: 11, color: Colors.white38)),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               if (stats.isEmpty)
//                 const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(32),
//                     child: Text('No data',
//                         style: TextStyle(color: Colors.white38)),
//                   ),
//                 )
//               else
//                 Responsive.isMobile(context)
//                     ? _MobileAdminList(stats: stats)
//                     : _DesktopAdminTable(stats: stats),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// // ── Desktop ──────────────────────────────────────────────────────────────────
// // Uses SingleChildScrollView so it never overflows horizontally on smaller desktops.
// // DataColumn/DataCell children are plain widgets — no Expanded inside them.

// class _DesktopAdminTable extends StatelessWidget {
//   final List<AdminSalesStat> stats;
//   const _DesktopAdminTable({required this.stats});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: ConstrainedBox(
//         // Ensure the table is at least as wide as the parent
//         constraints: BoxConstraints(
//           minWidth: MediaQuery.of(context).size.width - 120,
//         ),
//         child: DataTable(
//           horizontalMargin: 8,
//           columnSpacing: 20,
//           dataRowMinHeight: 54,
//           dataRowMaxHeight: 64,
//           headingRowColor:
//               WidgetStateProperty.all(Colors.white.withOpacity(0.05)),
//           columns: const [
//             DataColumn(label: Text('#',        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
//             DataColumn(label: Text('Admin',    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
//             DataColumn(label: Text('Revenue',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
//             DataColumn(label: Text('Orders',   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
//             DataColumn(label: Text('Pending',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
//             DataColumn(label: Text('Shipped',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
//             DataColumn(label: Text('Delivered',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
//             DataColumn(label: Text('Cancelled',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
//           ],
//           rows: stats.asMap().entries.map((e) {
//             final i    = e.key + 1;
//             final stat = e.value;
//             return DataRow(cells: [
//               DataCell(Text('$i',
//                   style: const TextStyle(color: Colors.white54, fontSize: 12))),
//               DataCell(_AdminNameCell(stat: stat, rank: i)),
//               DataCell(Text('Rs. ${_fmt(stat.totalSales)}',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF4CAF50),
//                       fontSize: 13))),
//               DataCell(Text('${stat.orderCount}',
//                   style: const TextStyle(fontSize: 13))),
//               DataCell(_NumBadge(stat.pendingOrders,   const Color(0xFFFFC107))),
//               DataCell(_NumBadge(stat.shippedOrders,   const Color(0xFF667EEA))),
//               DataCell(_NumBadge(stat.deliveredOrders, const Color(0xFF4CAF50))),
//               DataCell(_NumBadge(stat.cancelledOrders, const Color(0xFFFF6B6B))),
//             ]);
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// // ── Mobile ───────────────────────────────────────────────────────────────────

// class _MobileAdminList extends StatelessWidget {
//   final List<AdminSalesStat> stats;
//   const _MobileAdminList({required this.stats});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: stats.length,
//       separatorBuilder: (_, __) =>
//           const Divider(color: Colors.white12, height: 1),
//       itemBuilder: (_, i) {
//         final stat = stats[i];
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _AdminNameCell(stat: stat, rank: i + 1),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   _MiniStat('Revenue',  'Rs. ${_fmt(stat.totalSales)}', const Color(0xFF4CAF50)),
//                   const SizedBox(width: 8),
//                   _MiniStat('Orders',   '${stat.orderCount}',         Colors.white70),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: [
//                   _MiniStat('Pending',   '${stat.pendingOrders}',   const Color(0xFFFFC107)),
//                   _MiniStat('Shipped',   '${stat.shippedOrders}',   const Color(0xFF667EEA)),
//                   _MiniStat('Delivered', '${stat.deliveredOrders}', const Color(0xFF4CAF50)),
//                   _MiniStat('Cancelled', '${stat.cancelledOrders}', const Color(0xFFFF6B6B)),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// // ── Shared sub-widgets ───────────────────────────────────────────────────────

// class _AdminNameCell extends StatelessWidget {
//   final AdminSalesStat stat;
//   final int rank;
//   const _AdminNameCell({required this.stat, required this.rank});

//   @override
//   Widget build(BuildContext context) {
//     final rankColor = rank == 1
//         ? const Color(0xFFFFD700)
//         : rank == 2
//             ? const Color(0xFFC0C0C0)
//             : rank == 3
//                 ? const Color(0xFFCD7F32)
//                 : Colors.white30;

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 28, height: 28,
//           decoration: BoxDecoration(
//             color: rankColor.withOpacity(0.15),
//             shape: BoxShape.circle,
//             border: Border.all(color: rankColor.withOpacity(0.5)),
//           ),
//           child: Center(
//             child: Text('$rank',
//                 style: TextStyle(
//                     fontSize: 11, fontWeight: FontWeight.bold, color: rankColor)),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(stat.adminName,
//                 style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//                 overflow: TextOverflow.ellipsis),
//             Text(stat.adminEmail,
//                 style: const TextStyle(fontSize: 10, color: Colors.white38),
//                 overflow: TextOverflow.ellipsis),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class _NumBadge extends StatelessWidget {
//   final int value;
//   final Color color;
//   const _NumBadge(this.value, this.color);

//   @override
//   Widget build(BuildContext context) {
//     if (value == 0) {
//       return const Text('—', style: TextStyle(color: Colors.white24, fontSize: 12));
//     }
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text('$value',
//           style: TextStyle(
//               fontSize: 12, fontWeight: FontWeight.bold, color: color)),
//     );
//   }
// }

// class _MiniStat extends StatelessWidget {
//   final String label;
//   final String value;
//   final Color color;
//   const _MiniStat(this.label, this.value, this.color);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(value,
//               style: TextStyle(
//                   fontSize: 13, fontWeight: FontWeight.bold, color: color)),
//           Text(label,
//               style: const TextStyle(fontSize: 9, color: Colors.white38)),
//         ],
//       ),
//     );
//   }
// }

// String _fmt(double v) {
//   if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
//   if (v >= 1000)    return '${(v / 1000).toStringAsFixed(1)}K';
//   return v.toStringAsFixed(2);
// }