// // lib/screens/superAdmin/sales_dashboard/components/order_status_overview.dart

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../utility/constants.dart';
// import '../../../../utility/responsive.dart';
// import '../provider/sales_dashboard_provider.dart';

// class OrderStatusOverview extends StatelessWidget {
//   const OrderStatusOverview({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SalesDashboardProvider>(
//       builder: (_, prov, __) {
//         final s = prov.summary;
//         final isMobile = Responsive.isMobile(context);

//         final statuses = [
//           _StatusItem('Pending', s.pendingOrders, Icons.hourglass_top_rounded,
//               const Color(0xFFFFC107)),
//           _StatusItem('Shipped', s.shippedOrders, Icons.local_shipping_rounded,
//               const Color(0xFF667EEA)),
//           _StatusItem('Delivered', s.deliveredOrders,
//               Icons.check_circle_rounded, const Color(0xFF4CAF50)),
//           _StatusItem('Cancelled', s.cancelledOrders, Icons.cancel_rounded,
//               const Color(0xFFFF6B6B)),
//         ];

//         return Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: secondaryColor,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Order Status Breakdown',
//                   style: Theme.of(context).textTheme.titleMedium),
//               const SizedBox(height: 16),
//               // Status pills row
//               isMobile
//                   ? GridView.count(
//                       crossAxisCount: 2,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                       childAspectRatio: 2.4,
//                       children: statuses.map(_buildPill).toList(),
//                     )
//                   : Row(
//                       children: statuses.asMap().entries.map((e) {
//                         return Expanded(
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 right: e.key < statuses.length - 1 ? 10 : 0),
//                             child: _buildPill(e.value),
//                           ),
//                         );
//                       }).toList(),
//                     ),

//               const SizedBox(height: 20),
//               const Divider(color: Colors.white12),
//               const SizedBox(height: 16),

//               // Progress bars for each status
//               ...statuses.map((st) {
//                 final total = s.totalOrders == 0 ? 1 : s.totalOrders;
//                 final ratio = st.count / total;
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 12),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(children: [
//                             Icon(st.icon, size: 14, color: st.color),
//                             const SizedBox(width: 6),
//                             Text(st.label,
//                                 style: const TextStyle(
//                                     fontSize: 12, color: Colors.white70)),
//                           ]),
//                           Text(
//                             '${st.count}  (${(ratio * 100).toStringAsFixed(1)}%)',
//                             style: const TextStyle(
//                                 fontSize: 12, color: Colors.white54),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 6),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(4),
//                         child: LinearProgressIndicator(
//                           value: ratio,
//                           backgroundColor: Colors.white.withOpacity(0.06),
//                           valueColor: AlwaysStoppedAnimation<Color>(st.color),
//                           minHeight: 6,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildPill(_StatusItem st) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: BoxDecoration(
//         color: st.color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: st.color.withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           Icon(st.icon, color: st.color, size: 20),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('${st.count}',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: st.color)),
//                 Text(st.label,
//                     style:
//                         const TextStyle(fontSize: 10, color: Colors.white54)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StatusItem {
//   final String label;
//   final int count;
//   final IconData icon;
//   final Color color;
//   const _StatusItem(this.label, this.count, this.icon, this.color);
// }

// lib/screens/superAdmin/sales_dashboard/components/order_status_overview.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utility/constants.dart';
import '../../../../utility/responsive.dart';
import '../provider/sales_dashboard_provider.dart';

class OrderStatusOverview extends StatelessWidget {
  const OrderStatusOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesDashboardProvider>(
      builder: (_, prov, __) {
        final s = prov.summary;
        final isMobile = Responsive.isMobile(context);

        final statuses = [
          _StatusItem('Pending', s.pendingOrders, Icons.hourglass_top_rounded,
              const Color(0xFFFFC107)),
          _StatusItem('Shipped', s.shippedOrders, Icons.local_shipping_rounded,
              const Color(0xFF667EEA)),
          _StatusItem('Delivered', s.deliveredOrders,
              Icons.check_circle_rounded, const Color(0xFF4CAF50)),
          _StatusItem('Cancelled', s.cancelledOrders, Icons.cancel_rounded,
              const Color(0xFFFF6B6B)),
        ];

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // ← don't expand unboundedly
            children: [
              Text('Order Status Breakdown',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),

              // ── Status pills ──────────────────────────────────
              isMobile
                  // Mobile: 2×2 grid of self-sizing pills
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(children: [
                          Expanded(child: _Pill(statuses[0])),
                          const SizedBox(width: 10),
                          Expanded(child: _Pill(statuses[1])),
                        ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          Expanded(child: _Pill(statuses[2])),
                          const SizedBox(width: 10),
                          Expanded(child: _Pill(statuses[3])),
                        ]),
                      ],
                    )
                  // Desktop: single horizontal row
                  : Row(
                      children: statuses.asMap().entries.map((e) {
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: e.key < statuses.length - 1 ? 10 : 0),
                            child: _Pill(e.value),
                          ),
                        );
                      }).toList(),
                    ),

              const SizedBox(height: 20),
              const Divider(color: Colors.white12),
              const SizedBox(height: 12),

              // ── Progress bars ─────────────────────────────────
              ...statuses.map((st) {
                final total = s.totalOrders == 0 ? 1 : s.totalOrders;
                final ratio = (st.count / total).clamp(0.0, 1.0);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Icon(st.icon, size: 14, color: st.color),
                            const SizedBox(width: 6),
                            Text(st.label,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white70)),
                          ]),
                          Text(
                            '${st.count}  (${(ratio * 100).toStringAsFixed(1)}%)',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white54),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: ratio,
                          backgroundColor: Colors.white.withOpacity(0.06),
                          valueColor: AlwaysStoppedAnimation<Color>(st.color),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

// ── Pill widget — intrinsic height, no fixed constraints ─────────────────────
class _Pill extends StatelessWidget {
  final _StatusItem st;
  const _Pill(this.st, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: st.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: st.color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(st.icon, color: st.color, size: 22),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // ← key fix: no forced height
              children: [
                Text(
                  '${st.count}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: st.color),
                ),
                Text(
                  st.label,
                  style: const TextStyle(fontSize: 11, color: Colors.white54),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusItem {
  final String label;
  final int count;
  final IconData icon;
  final Color color;
  const _StatusItem(this.label, this.count, this.icon, this.color);
}
