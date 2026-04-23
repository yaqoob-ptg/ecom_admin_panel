// // lib/screens/superAdmin/sales_dashboard/components/kpi_cards.dart

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../utility/constants.dart';
// import '../../../../utility/responsive.dart';
// import '../provider/sales_dashboard_provider.dart';

// class KpiCards extends StatelessWidget {
//   const KpiCards({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SalesDashboardProvider>(
//       builder: (_, prov, __) {
//         final s = prov.summary;
//         final cards = [
//           _KpiCard(
//             label: 'Total Revenue',
//             value: 'Rs.${_fmt(s.totalRevenue)}',
//             sub: '${s.totalOrders} orders',
//             icon: Icons.attach_money_rounded,
//             color: const Color(0xFF667EEA),
//             gradient: const [Color(0xFF667EEA), Color(0xFF764BA2)],
//           ),
//           _KpiCard(
//             label: "Today's Sales",
//             value: 'Rs.${_fmt(s.todayRevenue)}',
//             sub: '${s.todayOrders} orders today',
//             icon: Icons.today_rounded,
//             color: const Color(0xFF4CAF50),
//             gradient: const [Color(0xFF4CAF50), Color(0xFF087F23)],
//           ),
//           _KpiCard(
//             label: 'Delivered',
//             value: '${s.deliveredOrders}',
//             sub: 'of ${s.totalOrders} orders',
//             icon: Icons.local_shipping_rounded,
//             color: const Color(0xFF00BCD4),
//             gradient: const [Color(0xFF00BCD4), Color(0xFF006064)],
//           ),
//           _KpiCard(
//             label: 'Pending',
//             value: '${s.pendingOrders}',
//             sub: '${s.shippedOrders} in transit',
//             icon: Icons.hourglass_top_rounded,
//             color: const Color(0xFFFFC107),
//             gradient: const [Color(0xFFFFC107), Color(0xFFFF8F00)],
//           ),
//         ];

//         final isMobile = Responsive.isMobile(context);
//         if (isMobile) {
//           return GridView.count(
//             crossAxisCount: 2,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 1.5,
//             children: cards,
//           );
//         }
//         return Row(
//           children: cards.asMap().entries.map((e) {
//             return Expanded(
//               child: Padding(
//                 padding: EdgeInsets.only(right: e.key < cards.length - 1 ? 12 : 0),
//                 child: e.value,
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }

//   String _fmt(double v) {
//     if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
//     if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
//     return v.toStringAsFixed(2);
//   }
// }

// class _KpiCard extends StatelessWidget {
//   final String label;
//   final String value;
//   final String sub;
//   final IconData icon;
//   final Color color;
//   final List<Color> gradient;

//   const _KpiCard({
//     required this.label,
//     required this.value,
//     required this.sub,
//     required this.icon,
//     required this.color,
//     required this.gradient,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(label,
//                     style: const TextStyle(fontSize: 12, color: Colors.white54)),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: gradient),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(icon, color: Colors.white, size: 18),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Text(value,
//               style: const TextStyle(
//                   fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
//           const SizedBox(height: 4),
//           Text(sub,
//               style: TextStyle(fontSize: 11, color: color.withOpacity(0.8))),
//         ],
//       ),
//     );
//   }
// }

// lib/screens/superAdmin/sales_dashboard/components/kpi_cards.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utility/constants.dart';
import '../../../../utility/responsive.dart';
import '../provider/sales_dashboard_provider.dart';

class KpiCards extends StatelessWidget {
  const KpiCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesDashboardProvider>(
      builder: (_, prov, __) {
        final s = prov.summary;
        final cards = [
          _KpiCard(
            label: 'Total Revenue',
            value: 'Rs.${_fmt(s.totalRevenue)}',
            sub: '${s.totalOrders} orders',
            icon: Icons.attach_money_rounded,
            gradient: const [Color(0xFF667EEA), Color(0xFF764BA2)],
          ),
          _KpiCard(
            label: "Today's Sales",
            value: 'Rs.${_fmt(s.todayRevenue)}',
            sub: '${s.todayOrders} orders today',
            icon: Icons.today_rounded,
            gradient: const [Color(0xFF4CAF50), Color(0xFF087F23)],
          ),
          _KpiCard(
            label: 'Delivered',
            value: '${s.deliveredOrders}',
            sub: 'of ${s.totalOrders} orders',
            icon: Icons.local_shipping_rounded,
            gradient: const [Color(0xFF00BCD4), Color(0xFF006064)],
          ),
          _KpiCard(
            label: 'Pending',
            value: '${s.pendingOrders}',
            sub: '${s.shippedOrders} in transit',
            icon: Icons.hourglass_top_rounded,
            gradient: const [Color(0xFFFFC107), Color(0xFFFF8F00)],
          ),
        ];

        final isMobile = Responsive.isMobile(context);

        if (isMobile) {
          // 2-column grid — rows size to content, no fixed aspect ratio
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: cards[0]),
                  const SizedBox(width: 12),
                  Expanded(child: cards[1]),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: cards[2]),
                  const SizedBox(width: 12),
                  Expanded(child: cards[3]),
                ],
              ),
            ],
          );
        }

        // Tablet / desktop: single row
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cards.asMap().entries.map((e) {
            return Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(right: e.key < cards.length - 1 ? 12 : 0),
                child: e.value,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  static String _fmt(double v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
    return v.toStringAsFixed(2);
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final IconData icon;
  final List<Color> gradient;

  const _KpiCard({
    required this.label,
    required this.value,
    required this.sub,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: gradient.first.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // ← shrink-wrap to content
        children: [
          // Label row with icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.white54),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Value — auto-sizes, never truncated
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          // Sub-label
          Text(
            sub,
            style: TextStyle(
                fontSize: 11, color: gradient.first.withOpacity(0.85)),
          ),
        ],
      ),
    );
  }
}
