import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  BREAKPOINTS
// ─────────────────────────────────────────────
class AppBreakpoints {
  static const double mobileS = 480;
  static const double mobileL = 768;
  static const double tablet = 1024;
  static const double webS = 1280;
  // webL = 1280 and above

  static bool isMobileS(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileS;
  static bool isMobileL(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileL;
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileL;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileL &&
      MediaQuery.of(context).size.width < tablet;
  static bool isWebS(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet &&
      MediaQuery.of(context).size.width < webS;
  static bool isWebL(BuildContext context) =>
      MediaQuery.of(context).size.width >= webS;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet;
}

// ─────────────────────────────────────────────
//  RESPONSIVE VALUE HELPER
//  Usage: AppResponsive.value(context, mobile: 8, tablet: 12, web: 16)
// ─────────────────────────────────────────────
class AppResponsive {
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T web,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppBreakpoints.mobileL) return mobile;
    if (width < AppBreakpoints.tablet) return tablet ?? web;
    return web;
  }
}

// ─────────────────────────────────────────────
//  SPACING / PADDING
// ─────────────────────────────────────────────
class AppSpacing {
  /// Page-level outer padding
  static EdgeInsets pagePadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < AppBreakpoints.mobileS) return const EdgeInsets.all(10);
    if (w < AppBreakpoints.mobileL) return const EdgeInsets.all(14);
    if (w < AppBreakpoints.tablet) return const EdgeInsets.all(18);
    if (w < AppBreakpoints.webS) return const EdgeInsets.all(22);
    return const EdgeInsets.all(28);
  }

  /// Card / container inner padding
  static EdgeInsets cardPadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < AppBreakpoints.mobileS) return const EdgeInsets.all(10);
    if (w < AppBreakpoints.mobileL) return const EdgeInsets.all(12);
    if (w < AppBreakpoints.tablet) return const EdgeInsets.all(16);
    return const EdgeInsets.all(20);
  }

  /// Vertical gap between sections
  static double sectionGap(BuildContext context) =>
      AppResponsive.value(context, mobile: 12.0, tablet: 16.0, web: 24.0);

  /// Horizontal gap between columns/items
  static double itemGap(BuildContext context) =>
      AppResponsive.value(context, mobile: 8.0, tablet: 12.0, web: 16.0);

  /// Standard small padding (e.g. table cell horizontal)
  static double sm(BuildContext context) =>
      AppResponsive.value(context, mobile: 6.0, tablet: 8.0, web: 12.0);

  /// Standard medium padding
  static double md(BuildContext context) =>
      AppResponsive.value(context, mobile: 10.0, tablet: 14.0, web: 20.0);

  /// Standard large padding
  static double lg(BuildContext context) =>
      AppResponsive.value(context, mobile: 16.0, tablet: 20.0, web: 28.0);
}

// ─────────────────────────────────────────────
//  FONT SIZES
// ─────────────────────────────────────────────
class AppFontSize {
  static double xs(BuildContext context) =>
      AppResponsive.value(context, mobile: 10.0, tablet: 11.0, web: 12.0);
  static double sm(BuildContext context) =>
      AppResponsive.value(context, mobile: 11.0, tablet: 12.0, web: 13.0);
  static double body(BuildContext context) =>
      AppResponsive.value(context, mobile: 12.0, tablet: 13.0, web: 14.0);
  static double md(BuildContext context) =>
      AppResponsive.value(context, mobile: 13.0, tablet: 14.0, web: 15.0);
  static double lg(BuildContext context) =>
      AppResponsive.value(context, mobile: 15.0, tablet: 16.0, web: 18.0);
  static double xl(BuildContext context) =>
      AppResponsive.value(context, mobile: 18.0, tablet: 20.0, web: 24.0);
  static double xxl(BuildContext context) =>
      AppResponsive.value(context, mobile: 22.0, tablet: 26.0, web: 32.0);

  /// Table header/cell font size
  static double tableCell(BuildContext context) =>
      AppResponsive.value(context, mobile: 11.0, tablet: 12.0, web: 13.0);

  /// Section title (e.g. "All Products")
  static double sectionTitle(BuildContext context) =>
      AppResponsive.value(context, mobile: 14.0, tablet: 15.0, web: 16.0);
}

// ─────────────────────────────────────────────
//  ICON SIZES
// ─────────────────────────────────────────────
class AppIconSize {
  static double sm(BuildContext context) =>
      AppResponsive.value(context, mobile: 16.0, tablet: 18.0, web: 20.0);
  static double md(BuildContext context) =>
      AppResponsive.value(context, mobile: 18.0, tablet: 20.0, web: 24.0);
  static double lg(BuildContext context) =>
      AppResponsive.value(context, mobile: 22.0, tablet: 26.0, web: 30.0);

  /// Action icons in table rows
  static double tableAction(BuildContext context) =>
      AppResponsive.value(context, mobile: 18.0, tablet: 20.0, web: 22.0);
}

// ─────────────────────────────────────────────
//  IMAGE / AVATAR SIZES
// ─────────────────────────────────────────────
class AppImageSize {
  /// Product thumbnail in table rows
  static double tableThumb(BuildContext context) =>
      AppResponsive.value(context, mobile: 28.0, tablet: 32.0, web: 36.0);
}

// ─────────────────────────────────────────────
//  GRID COLUMNS  (for GridView / dashboard cards)
// ─────────────────────────────────────────────
class AppGrid {
  static int crossAxisCount(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < AppBreakpoints.mobileS) return 1;
    if (w < AppBreakpoints.mobileL) return 2;
    if (w < AppBreakpoints.tablet) return 3;
    if (w < AppBreakpoints.webS) return 4;
    return 5;
  }

  static double childAspectRatio(BuildContext context) =>
      AppResponsive.value(context, mobile: 1.2, tablet: 1.1, web: 1.0);
}

// ─────────────────────────────────────────────
//  SIDEBAR
// ─────────────────────────────────────────────
class AppSidebar {
  static double width(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < AppBreakpoints.tablet) return 0; // hidden (use Drawer)
    if (w < AppBreakpoints.webS) return 56; // icon-only rail
    return 250; // full sidebar
  }

  static bool showDrawer(BuildContext context) =>
      AppBreakpoints.isMobile(context);
  static bool showRail(BuildContext context) =>
      AppBreakpoints.isTablet(context);
  static bool showFull(BuildContext context) =>
      AppBreakpoints.isDesktop(context) && !AppBreakpoints.isTablet(context);
}

// ─────────────────────────────────────────────
//  BORDER RADIUS
// ─────────────────────────────────────────────
class AppRadius {
  static double sm(BuildContext context) =>
      AppResponsive.value(context, mobile: 6.0, tablet: 8.0, web: 8.0);
  static double md(BuildContext context) =>
      AppResponsive.value(context, mobile: 8.0, tablet: 10.0, web: 10.0);
  static double lg(BuildContext context) =>
      AppResponsive.value(context, mobile: 10.0, tablet: 12.0, web: 12.0);
}
