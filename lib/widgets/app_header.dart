// import 'package:admin/widgets/profile_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../utility/constants.dart';
// import '../utility/responsive_constants.dart';

// /// A reusable header used by every screen in the admin app.
// ///
// /// Usage:
// /// ```dart
// /// AppHeader(
// ///   title: "Dashboard",
// ///   onSearch: (val) => context.dataProvider.filterProducts(val),
// ///   showProfile: true,   // false if parent scaffold already shows ProfileCard
// /// )
// /// ```
// class AppHeader extends StatelessWidget {
//   final String title;
//   final ValueChanged<String>? onSearch;

//   /// Whether to show the ProfileCard inside this header.
//   /// Set to [false] if the parent Scaffold / side-by-side layout already
//   /// renders a ProfileCard so it doesn't appear twice.
//   final bool showProfile;

//   const AppHeader({
//     Key? key,
//     required this.title,
//     this.onSearch,
//     this.showProfile = true,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = AppBreakpoints.isMobile(context);
//     final isMobileS = AppBreakpoints.isMobileS(context);

//     // ── Mobile S (<480px): title [+ profile] on top, search below ─────────
//     if (isMobileS) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: showProfile
//                 ? MainAxisAlignment.spaceBetween
//                 : MainAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontSize: AppFontSize.lg(context),
//                     ),
//               ),
//               if (showProfile) const ProfileCard(),
//             ],
//           ),
//           if (onSearch != null) ...[
//             SizedBox(height: AppSpacing.itemGap(context)),
//             _SearchBar(onChange: onSearch!),
//           ],
//         ],
//       );
//     }

//     // ── Mobile L / Tablet / Web: single row ───────────────────────────────
//     return Row(
//       children: [
//         Text(
//           title,
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                 fontSize: AppFontSize.xl(context),
//               ),
//         ),
//         // Spacer only where there's room — keeps title left, search centred
//         if (!isMobile) const Spacer(flex: 1),
//         if (onSearch != null) ...[
//           SizedBox(width: AppSpacing.itemGap(context)),
//           Expanded(child: _SearchBar(onChange: onSearch!)),
//         ],
//         if (showProfile) ...[
//           SizedBox(width: AppSpacing.itemGap(context)),
//           const ProfileCard(),
//         ],
//       ],
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  SHARED SEARCH BAR  (extracted once, used by every header)
// // ─────────────────────────────────────────────────────────────────────────────
// class _SearchBar extends StatelessWidget {
//   final ValueChanged<String> onChange;
//   const _SearchBar({required this.onChange});

//   @override
//   Widget build(BuildContext context) {
//     final double iconContainerSize =
//         AppResponsive.value(context, mobile: 30.0, tablet: 32.0, web: 36.0);
//     final double iconPad = AppResponsive.value(context,
//         mobile: 6.0, tablet: 7.0, web: defaultPadding * 0.75);
//     final double iconMarginH = AppResponsive.value(context,
//         mobile: 4.0, tablet: 6.0, web: defaultPadding / 2);

//     return TextField(
//       style: TextStyle(fontSize: AppFontSize.body(context)),
//       decoration: InputDecoration(
//         hintText: "Search",
//         hintStyle: TextStyle(
//             fontSize: AppFontSize.body(context), color: Colors.white38),
//         fillColor: secondaryColor,
//         filled: true,
//         isDense: true,
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: AppSpacing.sm(context) + 4,
//           vertical: AppSpacing.sm(context),
//         ),
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius:
//               BorderRadius.all(Radius.circular(AppRadius.md(context))),
//         ),
//         suffixIcon: InkWell(
//           onTap: () {},
//           child: Container(
//             padding: EdgeInsets.all(iconPad),
//             margin: EdgeInsets.symmetric(horizontal: iconMarginH, vertical: 6),
//             height: iconContainerSize,
//             width: iconContainerSize,
//             decoration: BoxDecoration(
//               color: primaryColor,
//               borderRadius:
//                   BorderRadius.all(Radius.circular(AppRadius.sm(context))),
//             ),
//             child: SvgPicture.asset("assets/icons/Search.svg",
//                 fit: BoxFit.contain),
//           ),
//         ),
//       ),
//       onChanged: onChange,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utility/constants.dart';
import '../utility/responsive_constants.dart';

/// Reusable header for every admin screen.
/// ProfileCard is NEVER rendered here — it lives exclusively in MainScreen's
/// AppBar (mobile) or is not rendered at all (tablet/web headers don't need it
/// because it already shows in the per-screen header via showProfile param).
///
/// Usage:
///   AppHeader(title: "Orders", onSearch: (v) => filterOrders(v))
class AppHeader extends StatelessWidget {
  final String title;
  final ValueChanged<String>? onSearch;

  const AppHeader({
    Key? key,
    required this.title,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final isMobileS = AppBreakpoints.isMobileS(context);

    // Mobile S (<480px): title on its own line, search below
    if (isMobileS) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: AppFontSize.lg(context),
                ),
          ),
          if (onSearch != null) ...[
            SizedBox(height: AppSpacing.itemGap(context)),
            _AppSearchBar(onChange: onSearch!),
          ],
        ],
      );
    }

    // Mobile L / Tablet / Web: single row
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: AppFontSize.xl(context),
              ),
        ),
        if (!isMobile) const Spacer(flex: 1),
        if (onSearch != null) ...[
          SizedBox(width: AppSpacing.itemGap(context)),
          Expanded(child: _AppSearchBar(onChange: onSearch!)),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SEARCH BAR
// ─────────────────────────────────────────────────────────────────────────────
class _AppSearchBar extends StatelessWidget {
  final ValueChanged<String> onChange;
  const _AppSearchBar({required this.onChange});

  @override
  Widget build(BuildContext context) {
    final double iconSize =
        AppResponsive.value(context, mobile: 30.0, tablet: 32.0, web: 36.0);
    final double iconPad = AppResponsive.value(context,
        mobile: 6.0, tablet: 7.0, web: defaultPadding * 0.75);
    final double iconMarginH = AppResponsive.value(context,
        mobile: 4.0, tablet: 6.0, web: defaultPadding / 2);

    return TextField(
      style: TextStyle(fontSize: AppFontSize.body(context)),
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(
            fontSize: AppFontSize.body(context), color: Colors.white38),
        fillColor: secondaryColor,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm(context) + 4,
          vertical: AppSpacing.sm(context),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              BorderRadius.all(Radius.circular(AppRadius.md(context))),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(iconPad),
            margin: EdgeInsets.symmetric(horizontal: iconMarginH, vertical: 6),
            height: iconSize,
            width: iconSize,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(AppRadius.sm(context))),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg",
                fit: BoxFit.contain),
          ),
        ),
      ),
      onChanged: onChange,
    );
  }
}
