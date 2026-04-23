// // // // lib/screens/superAdmin/sales_dashboard/components/sales_header.dart

// // // import 'package:admin/models/sales_dashboard.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import '../../../../utility/constants.dart';
// // // import '../../../../utility/responsive.dart';
// // // import '../../../../widgets/profile_card.dart';
// // // import '../provider/sales_dashboard_provider.dart';

// // // class SalesHeader extends StatelessWidget {
// // //   const SalesHeader({Key? key}) : super(key: key);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final isMobile = Responsive.isMobile(context);

// // //     return isMobile
// // //         ? Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: [
// // //                   Text('Sales Dashboard',
// // //                       style: Theme.of(context).textTheme.titleLarge),
// // //                   Row(children: [
// // //                     _RefreshBtn(),
// // //                     const SizedBox(width: 8),
// // //                     ProfileCard(),
// // //                   ]),
// // //                 ],
// // //               ),
// // //               const SizedBox(height: 12),
// // //               _PeriodChips(),
// // //             ],
// // //           )
// // //         : Row(
// // //             children: [
// // //               Text('Sales Dashboard',
// // //                   style: Theme.of(context).textTheme.titleLarge),
// // //               const SizedBox(width: 20),
// // //               _PeriodChips(),
// // //               const Spacer(),
// // //               _RefreshBtn(),
// // //               const SizedBox(width: 12),
// // //               ProfileCard(),
// // //             ],
// // //           );
// // //   }
// // // }

// // // class _RefreshBtn extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return IconButton(
// // //       tooltip: 'Refresh',
// // //       onPressed: () =>
// // //           context.read<SalesDashboardProvider>().loadDashboard(showSnack: true),
// // //       icon: const Icon(Icons.refresh_rounded),
// // //     );
// // //   }
// // // }

// // // class _PeriodChips extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Consumer<SalesDashboardProvider>(
// // //       builder: (_, prov, __) {
// // //         return SingleChildScrollView(
// // //           scrollDirection: Axis.horizontal,
// // //           child: Row(
// // //             children: SalesPeriod.values.map((p) {
// // //               final selected = prov.selectedPeriod == p;
// // //               return Padding(
// // //                 padding: const EdgeInsets.only(right: 8),
// // //                 child: FilterChip(
// // //                   label: Text(
// // //                     p.label,
// // //                     style: TextStyle(
// // //                       fontSize: 12,
// // //                       fontWeight:
// // //                           selected ? FontWeight.bold : FontWeight.normal,
// // //                       color: selected ? Colors.white : Colors.white70,
// // //                     ),
// // //                   ),
// // //                   selected: selected,
// // //                   onSelected: (_) => prov.setPeriod(p),
// // //                   selectedColor: primaryColor,
// // //                   backgroundColor: secondaryColor,
// // //                   checkmarkColor: Colors.white,
// // //                   side: BorderSide(
// // //                       color: selected ? primaryColor : Colors.white24),
// // //                   padding:
// // //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// // //                   shape: RoundedRectangleBorder(
// // //                       borderRadius: BorderRadius.circular(20)),
// // //                 ),
// // //               );
// // //             }).toList(),
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }
// // // }

// // // lib/screens/superAdmin/sales_dashboard/components/sales_header.dart

// // import 'package:admin/models/sales_dashboard.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../../../../utility/constants.dart';
// // import '../../../../utility/responsive.dart';
// // import '../../../../widgets/profile_card.dart';
// // import '../provider/sales_dashboard_provider.dart';

// // /// Layout on ALL screen sizes:
// // ///
// // ///   Row 1 │ "Sales Dashboard"   [Refresh]  [ProfileCard — desktop only]
// // ///   Row 2 │ [Today] [This Week] [This Month] [Overall]
// // ///
// // /// On mobile the global app bar already shows the ProfileCard,
// // /// so we hide it here to avoid duplication.

// // class SalesHeader extends StatelessWidget {
// //   const SalesHeader({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final isDesktop = Responsive.isDesktop(context);

// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         // ── Row 1: title + actions ─────────────────────────────────
// //         Row(
// //           children: [
// //             Text(
// //               'Sales Dashboard',
// //               style: Theme.of(context).textTheme.titleLarge,
// //             ),
// //             const Spacer(),
// //             _RefreshBtn(),
// //             // Only show ProfileCard on desktop — mobile already has it in the app bar
// //             if (isDesktop) ...[
// //               const SizedBox(width: 12),
// //               ProfileCard(),
// //             ],
// //           ],
// //         ),

// //         const SizedBox(height: 12),

// //         // ── Row 2: period filter chips ─────────────────────────────
// //         _PeriodChips(),
// //       ],
// //     );
// //   }
// // }

// // class _RefreshBtn extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return IconButton(
// //       tooltip: 'Refresh',
// //       padding: EdgeInsets.zero,
// //       constraints: const BoxConstraints(),
// //       onPressed: () =>
// //           context.read<SalesDashboardProvider>().loadDashboard(showSnack: true),
// //       icon: const Icon(Icons.refresh_rounded),
// //     );
// //   }
// // }

// // class _PeriodChips extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<SalesDashboardProvider>(
// //       builder: (_, prov, __) {
// //         return SingleChildScrollView(
// //           scrollDirection: Axis.horizontal,
// //           child: Row(
// //             children: SalesPeriod.values.map((p) {
// //               final selected = prov.selectedPeriod == p;
// //               return Padding(
// //                 padding: const EdgeInsets.only(right: 8),
// //                 child: FilterChip(
// //                   label: Text(
// //                     p.label,
// //                     style: TextStyle(
// //                       fontSize: 12,
// //                       fontWeight:
// //                           selected ? FontWeight.bold : FontWeight.normal,
// //                       color: selected ? Colors.white : Colors.white70,
// //                     ),
// //                   ),
// //                   selected: selected,
// //                   onSelected: (_) => prov.setPeriod(p),
// //                   selectedColor: primaryColor,
// //                   backgroundColor: secondaryColor,
// //                   checkmarkColor: Colors.white,
// //                   side: BorderSide(
// //                       color: selected ? primaryColor : Colors.white24),
// //                   padding:
// //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //                   shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(20)),
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // lib/screens/superAdmin/sales_dashboard/components/sales_header.dart

// import 'package:admin/models/sales_dashboard.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../utility/constants.dart';
// import '../../../../widgets/profile_card.dart';
// import '../provider/sales_dashboard_provider.dart';

// /// Layout (identical structure on all breakpoints):
// ///
// ///   Row 1 │ "Sales Dashboard"  ··· [Refresh]  [ProfileCard — tablet+desktop]
// ///   Row 2 │ [Today] [This Week] [This Month] [Overall]
// ///
// /// ProfileCard is hidden on mobile (width < 850) because the global app bar
// /// already renders it there.  On tablet (850–1099) and desktop (≥1100) it
// /// is shown here since the app bar does not include it at those sizes.

// class SalesHeader extends StatelessWidget {
//   const SalesHeader({Key? key}) : super(key: key);

//   // Show the profile card whenever the screen is NOT mobile.
//   // Using raw MediaQuery avoids depending on which Responsive class is imported.
//   static bool _showProfileCard(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 850;

//   @override
//   Widget build(BuildContext context) {
//     final showCard = _showProfileCard(context);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // ── Row 1: title + refresh + profile card ──────────────────
//         Row(
//           children: [
//             Text(
//               'Sales Dashboard',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             const Spacer(),
//             _RefreshBtn(),
//             if (showCard) ...[
//               const SizedBox(width: 12),
//               ProfileCard(),
//             ],
//           ],
//         ),

//         const SizedBox(height: 12),

//         // ── Row 2: period filter chips (scrollable) ─────────────────
//         const _PeriodChips(),
//       ],
//     );
//   }
// }

// // ── Refresh button ────────────────────────────────────────────────────────────

// class _RefreshBtn extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       tooltip: 'Refresh',
//       padding: EdgeInsets.zero,
//       constraints: const BoxConstraints(),
//       onPressed: () =>
//           context.read<SalesDashboardProvider>().loadDashboard(showSnack: true),
//       icon: const Icon(Icons.refresh_rounded),
//     );
//   }
// }

// // ── Period filter chips ───────────────────────────────────────────────────────

// class _PeriodChips extends StatelessWidget {
//   const _PeriodChips();

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SalesDashboardProvider>(
//       builder: (_, prov, __) {
//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: SalesPeriod.values.map((p) {
//               final selected = prov.selectedPeriod == p;
//               return Padding(
//                 padding: const EdgeInsets.only(right: 8),
//                 child: FilterChip(
//                   label: Text(
//                     p.label,
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight:
//                           selected ? FontWeight.bold : FontWeight.normal,
//                       color: selected ? Colors.white : Colors.white70,
//                     ),
//                   ),
//                   selected: selected,
//                   onSelected: (_) => prov.setPeriod(p),
//                   selectedColor: primaryColor,
//                   backgroundColor: secondaryColor,
//                   checkmarkColor: Colors.white,
//                   side: BorderSide(
//                       color: selected ? primaryColor : Colors.white24),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                 ),
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
// }

// lib/screens/superAdmin/sales_dashboard/components/sales_header.dart

import 'package:admin/models/sales_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utility/constants.dart';
import '../../../../widgets/profile_card.dart';
import '../provider/sales_dashboard_provider.dart';

/// Layout (same structure on every breakpoint):
///
///   Row 1 │ "Sales Dashboard"  ··· [Refresh]  [ProfileCard when width ≥ 768]
///   Row 2 │ [Today] [This Week] [This Month] [Overall]
///
/// ProfileCard visibility rule — mirrors your AppBreakpoints:
///   • width < 768  → true mobile, global app bar shows ProfileCard → hide here
///   • width ≥ 768  → tablet / rail / desktop → show here
///     (768 == AppBreakpoints.mobileL, which is where your sidebar switches
///      from drawer to icon-rail, so the global app bar no longer shows it)

class SalesHeader extends StatelessWidget {
  const SalesHeader({Key? key}) : super(key: key);

  /// Match AppBreakpoints.mobileL = 768
  static const double _profileCardBreakpoint = 768.0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final showCard = width >= _profileCardBreakpoint;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Row 1 ──────────────────────────────────────────────────
        Row(
          children: [
            Text(
              'Sales Dashboard',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            _RefreshBtn(),
            if (showCard) ...[
              const SizedBox(width: 12),
              ProfileCard(),
            ],
          ],
        ),

        const SizedBox(height: 12),

        // ── Row 2: period chips ────────────────────────────────────
        const _PeriodChips(),
      ],
    );
  }
}

// ── Refresh button ────────────────────────────────────────────────────────────

class _RefreshBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Refresh',
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: () =>
          context.read<SalesDashboardProvider>().loadDashboard(showSnack: true),
      icon: const Icon(Icons.refresh_rounded),
    );
  }
}

// ── Period filter chips ───────────────────────────────────────────────────────

class _PeriodChips extends StatelessWidget {
  const _PeriodChips();

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesDashboardProvider>(
      builder: (_, prov, __) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: SalesPeriod.values.map((p) {
              final selected = prov.selectedPeriod == p;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(
                    p.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          selected ? FontWeight.bold : FontWeight.normal,
                      color: selected ? Colors.white : Colors.white70,
                    ),
                  ),
                  selected: selected,
                  onSelected: (_) => prov.setPeriod(p),
                  selectedColor: primaryColor,
                  backgroundColor: secondaryColor,
                  checkmarkColor: Colors.white,
                  side: BorderSide(
                      color: selected ? primaryColor : Colors.white24),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
