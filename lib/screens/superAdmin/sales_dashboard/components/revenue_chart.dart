// // lib/screens/superAdmin/sales_dashboard/components/revenue_chart.dart

// import 'package:admin/models/sales_dashboard.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../utility/constants.dart';
// import '../provider/sales_dashboard_provider.dart';

// class RevenueChart extends StatelessWidget {
//   const RevenueChart({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SalesDashboardProvider>(
//       builder: (_, prov, __) {
//         final points = prov.chartPoints;
//         final maxRev = prov.maxChartRevenue;

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
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Revenue Overview',
//                       style: Theme.of(context).textTheme.titleMedium),
//                   Text(prov.selectedPeriod.label,
//                       style:
//                           const TextStyle(fontSize: 11, color: Colors.white38)),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               if (points.isEmpty)
//                 const Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(32),
//                     child: Text('No data for this period',
//                         style: TextStyle(color: Colors.white38)),
//                   ),
//                 )
//               else
//                 SizedBox(
//                   height: 180,
//                   child: _BarChart(points: points, maxRev: maxRev),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class _BarChart extends StatelessWidget {
//   final List points;
//   final double maxRev;
//   const _BarChart({required this.points, required this.maxRev});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       final barWidth = (constraints.maxWidth / points.length).clamp(24.0, 60.0);

//       return Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: points.map((p) {
//           final ratio =
//               maxRev == 0 ? 0.0 : (p.revenue / maxRev).clamp(0.0, 1.0);
//           final barH = ratio * 150.0;
//           final isEmpty = p.revenue == 0;

//           return Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 3),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // Value label on top
//                   if (!isEmpty)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 4),
//                       child: Text(
//                         _shortFmt(p.revenue),
//                         style:
//                             const TextStyle(fontSize: 9, color: Colors.white54),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   // Bar
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 600),
//                     curve: Curves.easeOutCubic,
//                     height: isEmpty ? 4 : barH,
//                     decoration: BoxDecoration(
//                       gradient: isEmpty
//                           ? null
//                           : const LinearGradient(
//                               begin: Alignment.bottomCenter,
//                               end: Alignment.topCenter,
//                               colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
//                             ),
//                       color: isEmpty ? Colors.white12 : null,
//                       borderRadius:
//                           const BorderRadius.vertical(top: Radius.circular(6)),
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   // Label
//                   Text(
//                     p.label,
//                     style: const TextStyle(fontSize: 9, color: Colors.white54),
//                     textAlign: TextAlign.center,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       );
//     });
//   }

//   String _shortFmt(double v) {
//     if (v >= 1000) return 'Rs. ${(v / 1000).toStringAsFixed(1)}K';
//     return 'Rs. ${v.toStringAsFixed(0)}';
//   }
// }

// lib/screens/superAdmin/sales_dashboard/components/revenue_chart.dart

import 'package:admin/models/sales_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utility/constants.dart';
import '../provider/sales_dashboard_provider.dart';

class RevenueChart extends StatelessWidget {
  const RevenueChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesDashboardProvider>(
      builder: (_, prov, __) {
        final points = prov.chartPoints;
        final maxRev = prov.maxChartRevenue;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Revenue Overview',
                      style: Theme.of(context).textTheme.titleMedium),
                  Text(prov.selectedPeriod.label,
                      style:
                          const TextStyle(fontSize: 11, color: Colors.white38)),
                ],
              ),
              const SizedBox(height: 24),

              if (points.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Text('No data for this period',
                        style: TextStyle(color: Colors.white38)),
                  ),
                )
              else
                // Fixed height container — chart draws inside this box only
                SizedBox(
                  height: 200,
                  child: _BarChart(points: points, maxRev: maxRev),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ── Bar chart — all rendering stays within the given 200px height ─────────────
class _BarChart extends StatelessWidget {
  final List points;
  final double maxRev;

  const _BarChart({required this.points, required this.maxRev, Key? key})
      : super(key: key);

  // Layout constants
  static const double _labelAreaHeight = 20.0; // bottom label row
  static const double _valueLabelHeight = 16.0; // value text above bar
  static const double _gapLabelBar = 4.0; // space between value & bar
  static const double _gapBarLabel = 6.0; // space between bar & label

  @override
  Widget build(BuildContext context) {
    // Total reserved height for decorations outside the bar itself
    const double reserved =
        _valueLabelHeight + _gapLabelBar + _gapBarLabel + _labelAreaHeight;

    return LayoutBuilder(builder: (context, constraints) {
      final availableBarHeight = constraints.maxHeight - reserved;

      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // ── Bar area ────────────────────────────────────────────
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: points.map((p) {
                final ratio =
                    maxRev == 0 ? 0.0 : (p.revenue / maxRev).clamp(0.0, 1.0);
                final barH =
                    (ratio * availableBarHeight).clamp(4.0, availableBarHeight);
                final isEmpty = p.revenue == 0;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // Value label — always takes its fixed space
                        SizedBox(
                          height: _valueLabelHeight,
                          child: isEmpty
                              ? const SizedBox.shrink()
                              : Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    _shortFmt(p.revenue),
                                    style: const TextStyle(
                                        fontSize: 8, color: Colors.white54),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                        ),
                        SizedBox(height: _gapLabelBar),

                        // Bar
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOutCubic,
                          height: barH,
                          decoration: BoxDecoration(
                            gradient: isEmpty
                                ? null
                                : const LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Color(0xFF667EEA),
                                      Color(0xFF764BA2)
                                    ],
                                  ),
                            color: isEmpty ? Colors.white12 : null,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(5)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // ── Label row — fixed height below bars ───────────────────
          SizedBox(height: _gapBarLabel),
          SizedBox(
            height: _labelAreaHeight,
            child: Row(
              children: points.map((p) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Text(
                      p.label,
                      style:
                          const TextStyle(fontSize: 9, color: Colors.white54),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }

  String _shortFmt(double v) {
    if (v >= 1000000) return 'Rs. ${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return 'Rs. ${(v / 1000).toStringAsFixed(1)}K';
    return 'Rs. ${v.toStringAsFixed(0)}';
  }
}
