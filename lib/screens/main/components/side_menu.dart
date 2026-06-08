// // import '../../../utility/extensions.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:get/get.dart';

// // class SideMenu extends StatelessWidget {
// //   const SideMenu({
// //     Key? key,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Drawer(
// //       child: ListView(
// //         children: [
// //           DrawerHeader(
// //             child: Image.asset("assets/images/logo.png"),
// //           ),
// //           DrawerListTile(
// //             title: "Dashboard",
// //             svgSrc: "assets/icons/menu_dashboard.svg",
// //             press: () {
// //               context.mainScreenProvider.navigateToScreen('Dashboard');
// //             },
// //           ),
// //           DrawerListTile(
// //             title: "Category",
// //             svgSrc: "assets/icons/menu_tran.svg",
// //             press: () {
// //               context.mainScreenProvider.navigateToScreen('Category');
// //             },
// //           ),
// //           DrawerListTile(
// //             title: "Sub Category",
// //             svgSrc: "assets/icons/menu_task.svg",
// //             press: () {
// //               context.mainScreenProvider.navigateToScreen('SubCategory');
// //             },
// //           ),
// //           DrawerListTile(
// //             title: "Brands",
// //             svgSrc: "assets/icons/menu_doc.svg",
// //             press: () {
// //               context.mainScreenProvider.navigateToScreen('Brands');
// //             },
// //           ),
// //           DrawerListTile(
// //             title: "Variant Type",
// //             svgSrc: "assets/icons/menu_store.svg",
// //             press: () {
// //               context.mainScreenProvider.navigateToScreen('VariantType');
// //             },
// //           ),
// //           DrawerListTile(
// //             title: "Variants",
// //             svgSrc: "assets/icons/menu_notification.svg",
// //             press: () {
// //               context.mainScreenProvider.navigateToScreen('Variants');
// //             },
// //           ),
// //           DrawerListTile(
// //             title: "Orders",
// //             svgSrc: "assets/icons/menu_profile.svg",
// //             press: () {
// //               context.mainScreenProvider.navigateToScreen('Order');
// //             },
// //           ),
// //           DrawerListTile(
// //             title: "Coupons",
// //             svgSrc: "assets/icons/menu_setting.svg",
// //             press: () {
// //               context.mainScreenProvider.navigateToScreen('Coupon');
// //             },
// //           ),
// //           DrawerListTile(
// //             title: "Posters",
// //             svgSrc: "assets/icons/menu_doc.svg",
// //             press: () {
// //               context.mainScreenProvider.navigateToScreen('Poster');
// //             },
// //           ),
// //           DrawerListTile(
// //             title: "Notifications",
// //             svgSrc: "assets/icons/menu_notification.svg",
// //             press: () {
// //               context.mainScreenProvider.navigateToScreen('Notifications');
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class DrawerListTile extends StatelessWidget {
// //   const DrawerListTile({
// //     Key? key,
// //     // For selecting those three line once press "Command+D"
// //     required this.title,
// //     required this.svgSrc,
// //     required this.press,
// //   }) : super(key: key);

// //   final String title, svgSrc;
// //   final VoidCallback press;

// //   @override
// //   Widget build(BuildContext context) {
// //     return ListTile(
// //       onTap: press,
// //       horizontalTitleGap: 0.0,
// //       leading: SvgPicture.asset(
// //         svgSrc,
// //         colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
// //         height: 16,
// //       ),
// //       title: Text(
// //         title,
// //         style: TextStyle(color: Colors.white54),
// //       ),
// //     );
// //   }
// // }

// //responsive
// import '../../../utility/extensions.dart';
// import '../../../utility/responsive_constants.dart';
// import '../../../utility/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// // ─────────────────────────────────────────────────────────────────────────────
// //  MENU ITEMS — single source of truth
// // ─────────────────────────────────────────────────────────────────────────────
// class _MenuItem {
//   final String title;
//   final String svgSrc;
//   final String route;
//   const _MenuItem(this.title, this.svgSrc, this.route);
// }

// const List<_MenuItem> _menuItems = [
//   _MenuItem("Dashboard", "assets/icons/menu_dashboard.svg", "Dashboard"),
//   _MenuItem("Category", "assets/icons/menu_tran.svg", "Category"),
//   _MenuItem("Sub Category", "assets/icons/menu_task.svg", "SubCategory"),
//   _MenuItem("Brands", "assets/icons/menu_doc.svg", "Brands"),
//   _MenuItem("Variant Type", "assets/icons/menu_store.svg", "VariantType"),
//   _MenuItem("Variants", "assets/icons/menu_notification.svg", "Variants"),
//   _MenuItem("Orders", "assets/icons/menu_profile.svg", "Order"),
//   _MenuItem("Coupons", "assets/icons/menu_setting.svg", "Coupon"),
//   _MenuItem("Posters", "assets/icons/menu_doc.svg", "Poster"),
//   _MenuItem(
//       "Notifications", "assets/icons/menu_notification.svg", "Notifications"),
// ];

// // ─────────────────────────────────────────────────────────────────────────────
// //  SIDE MENU — auto-switches between three modes:
// //
// //    Mobile  (<768px)   → Drawer  (hidden, opened via hamburger)
// //    Tablet  (768–1023) → NavigationRail (icon-only, 56px wide)
// //    Web     (1024px+)  → Full sidebar  (icon + label, 250px wide)
// //
// //  Usage in your scaffold:
// //    • Mobile:  wrap with Scaffold(drawer: SideMenu())
// //    • Tablet:  use SideMenu() as the left widget in a Row
// //    • Web:     use SideMenu() as the left widget in a Row
// //
// //  The widget itself always renders the right variant based on screen width.
// // ─────────────────────────────────────────────────────────────────────────────
// class SideMenu extends StatelessWidget {
//   const SideMenu({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (AppBreakpoints.isMobile(context)) {
//       return _DrawerMenu(context: context);
//     } else if (AppBreakpoints.isTablet(context)) {
//       return _RailMenu(context: context);
//     } else {
//       return _FullSidebar(context: context);
//     }
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  MOBILE — Drawer  (use as Scaffold(drawer: SideMenu()))
// // ─────────────────────────────────────────────────────────────────────────────
// class _DrawerMenu extends StatelessWidget {
//   final BuildContext context;
//   const _DrawerMenu({required this.context});

//   @override
//   Widget build(BuildContext ctx) {
//     return Drawer(
//       child: Container(
//         color: Theme.of(ctx).scaffoldBackgroundColor,
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             // _Logo(height: 80, padding: const EdgeInsets.all(16)),
//             DrawerHeader(
//               child: Image.asset("assets/images/logo.png"),
//             ),
//             ..._menuItems.map((item) => _DrawerTile(item: item)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  TABLET — NavigationRail  (icon-only, 56px)
// // ─────────────────────────────────────────────────────────────────────────────
// class _RailMenu extends StatelessWidget {
//   final BuildContext context;
//   const _RailMenu({required this.context});

//   @override
//   Widget build(BuildContext ctx) {
//     // Track selected index via ValueNotifier to avoid needing a StatefulWidget
//     return ValueListenableBuilder<int>(
//       valueListenable: _selectedIndex,
//       builder: (context, selected, _) {
//         return NavigationRail(
//           selectedIndex: selected,
//           minWidth: 56,
//           backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
//           // No labels on rail — icon only
//           labelType: NavigationRailLabelType.none,
//           // leading: _Logo(
//           //     height: 40, padding: const EdgeInsets.symmetric(vertical: 12)),
//           leading: DrawerHeader(
//             child: Image.asset("assets/images/logo.png"),
//           ),
//           onDestinationSelected: (index) {
//             _selectedIndex.value = index;
//             ctx.mainScreenProvider.navigateToScreen(_menuItems[index].route);
//           },
//           destinations: _menuItems.map((item) {
//             return NavigationRailDestination(
//               padding: EdgeInsets.zero,
//               icon: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: SvgPicture.asset(
//                   item.svgSrc,
//                   colorFilter:
//                       const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
//                   height: 20,
//                 ),
//               ),
//               selectedIcon: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: SvgPicture.asset(
//                   item.svgSrc,
//                   colorFilter:
//                       const ColorFilter.mode(Colors.white, BlendMode.srcIn),
//                   height: 20,
//                 ),
//               ),
//               label: Text(item.title),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  WEB — Full sidebar  (icon + label, 250px)
// // ─────────────────────────────────────────────────────────────────────────────
// class _FullSidebar extends StatelessWidget {
//   final BuildContext context;
//   const _FullSidebar({required this.context});

//   @override
//   Widget build(BuildContext ctx) {
//     return Container(
//       width: 250,
//       color: Theme.of(ctx).scaffoldBackgroundColor,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // _Logo(height: 80, padding: const EdgeInsets.all(defaultPadding)),
//           DrawerHeader(
//             child: Image.asset("assets/images/logo.png"),
//           ),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children:
//                   _menuItems.map((item) => _SidebarTile(item: item)).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  SHARED: Logo widget
// // ─────────────────────────────────────────────────────────────────────────────
// class _Logo extends StatelessWidget {
//   final double height;
//   final EdgeInsets padding;
//   const _Logo({required this.height, required this.padding});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding,
//       child: Image.asset(
//         "assets/images/logo.png",
//         height: height,
//         fit: BoxFit.contain,
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  SHARED: Drawer tile  (mobile)
// // ─────────────────────────────────────────────────────────────────────────────
// class _DrawerTile extends StatelessWidget {
//   final _MenuItem item;
//   const _DrawerTile({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {
//         context.mainScreenProvider.navigateToScreen(item.route);
//         Navigator.of(context).pop(); // close drawer
//       },
//       horizontalTitleGap: 0,
//       leading: SvgPicture.asset(
//         item.svgSrc,
//         colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
//         height: 18,
//       ),
//       title: Text(
//         item.title,
//         style: const TextStyle(color: Colors.white54, fontSize: 14),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  SHARED: Sidebar tile  (web full sidebar)
// // ─────────────────────────────────────────────────────────────────────────────
// class _SidebarTile extends StatelessWidget {
//   final _MenuItem item;
//   const _SidebarTile({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<int>(
//       valueListenable: _selectedIndex,
//       builder: (context, selected, _) {
//         final isSelected =
//             _menuItems.indexWhere((m) => m.route == item.route) == selected;

//         return ListTile(
//           onTap: () {
//             _selectedIndex.value =
//                 _menuItems.indexWhere((m) => m.route == item.route);
//             context.mainScreenProvider.navigateToScreen(item.route);
//           },
//           horizontalTitleGap: 0,
//           // Highlight selected item
//           tileColor:
//               isSelected ? Colors.white.withOpacity(0.07) : Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           leading: SvgPicture.asset(
//             item.svgSrc,
//             colorFilter: ColorFilter.mode(
//               isSelected ? Colors.white : Colors.white54,
//               BlendMode.srcIn,
//             ),
//             height: 18,
//           ),
//           title: Text(
//             item.title,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.white54,
//               fontSize: AppFontSize.body(context),
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  SHARED: selected index state (lightweight, no StatefulWidget needed)
// // ─────────────────────────────────────────────────────────────────────────────
// final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

// // ─────────────────────────────────────────────────────────────────────────────
// //  LEGACY EXPORT — keeps existing call sites working unchanged
// // ─────────────────────────────────────────────────────────────────────────────
// class DrawerListTile extends StatelessWidget {
//   final String title;
//   final String svgSrc;
//   final VoidCallback press;

//   const DrawerListTile({
//     Key? key,
//     required this.title,
//     required this.svgSrc,
//     required this.press,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: press,
//       horizontalTitleGap: 0,
//       leading: SvgPicture.asset(
//         svgSrc,
//         colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
//         height: 18,
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: Colors.white54,
//           fontSize: AppFontSize.body(context),
//         ),
//       ),
//     );
//   }
// }
import 'package:admin/models/user.dart';
import 'package:admin/screens/login/provider/user_provider.dart';

import '../../../utility/extensions.dart';
import '../../../utility/responsive_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  MENU ITEMS — single source of truth with role-based filtering
// ─────────────────────────────────────────────────────────────────────────────
class _MenuItem {
  final String title;
  final String svgSrc;
  final String route;
  final String? requiredRole; // 'superAdmin', 'admin', or null for all

  const _MenuItem(this.title, this.svgSrc, this.route, [this.requiredRole]);
}

// Function to get menu items based on user role
List<_MenuItem> _getMenuItems(User? currentUser) {
  final bool isSuperAdmin = currentUser?.role == 'superAdmin';

  final items = <_MenuItem>[
    _MenuItem("Dashboard", "assets/icons/menu_dashboard.svg", "Dashboard"),
  ];

  // Add Super Admin only items
  if (isSuperAdmin) {
    items.add(_MenuItem(
        "Users", "assets/icons/menu_users.svg", "Users", "superAdmin"));
    items.add(_MenuItem(
        "Sales ", "assets/icons/menu_sales.svg", "Sales", "superAdmin"));
  }

  // Add common items for all admin roles
  items.addAll([
    _MenuItem(
        "Category", "assets/icons/menu_tran.svg", "Category", "superAdmin"),
    _MenuItem("Sub Category", "assets/icons/menu_task.svg", "SubCategory",
        "superAdmin"),
    _MenuItem("Brands", "assets/icons/menu_doc.svg", "Brands"),
    _MenuItem("Variant Type", "assets/icons/menu_store.svg", "VariantType"),
    _MenuItem("Variants", "assets/icons/menu_notification.svg", "Variants"),
    _MenuItem("Orders", "assets/icons/menu_profile.svg", "Order"),
    _MenuItem("Coupons", "assets/icons/menu_setting.svg", "Coupon"),
    _MenuItem("Posters", "assets/icons/menu_doc.svg", "Poster"),
    _MenuItem(
        "Notifications", "assets/icons/menu_notification.svg", "Notifications"),
  ]);

  return items;
}

// ─────────────────────────────────────────────────────────────────────────────
//  SIDE MENU — auto-switches between three modes:
//
//    Mobile  (<768px)   → Drawer  (hidden, opened via hamburger)
//    Tablet  (768–1023) → NavigationRail (icon-only, 56px wide)
//    Web     (1024px+)  → Full sidebar  (icon + label, 250px wide)
//
//  Usage in your scaffold:
//    • Mobile:  wrap with Scaffold(drawer: SideMenu())
//    • Tablet:  use SideMenu() as the left widget in a Row
//    • Web:     use SideMenu() as the left widget in a Row
//
//  The widget itself always renders the right variant based on screen width.
// ─────────────────────────────────────────────────────────────────────────────
class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AppBreakpoints.isMobile(context)) {
      return _DrawerMenu(context: context);
    } else if (AppBreakpoints.isTablet(context)) {
      return _RailMenu(context: context);
    } else {
      return _FullSidebar(context: context);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  MOBILE — Drawer  (use as Scaffold(drawer: SideMenu()))
// ─────────────────────────────────────────────────────────────────────────────
class _DrawerMenu extends StatelessWidget {
  final BuildContext context;
  const _DrawerMenu({required this.context});

  @override
  Widget build(BuildContext ctx) {
    // Get user role from provider
    final userProvider = Provider.of<UserProvider>(ctx, listen: false);
    final menuItems = _getMenuItems(userProvider.user);

    return Drawer(
      child: Container(
        color: Theme.of(ctx).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: _Logo(
                height: 80,
                padding: const EdgeInsets.all(16),
              ),
            ),
            ...menuItems.map((item) => _DrawerTile(item: item)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  TABLET — NavigationRail  (icon-only, 56px)
// ─────────────────────────────────────────────────────────────────────────────
class _RailMenu extends StatelessWidget {
  final BuildContext context;
  const _RailMenu({required this.context});

  @override
  Widget build(BuildContext ctx) {
    // Track selected index via ValueNotifier to avoid needing a StatefulWidget
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndex,
      builder: (context, selected, _) {
        // Get user role from provider
        final userProvider = Provider.of<UserProvider>(ctx, listen: false);
        final menuItems = _getMenuItems(userProvider.user);

        return NavigationRail(
          selectedIndex: selected,
          minWidth: 56,
          backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
          labelType: NavigationRailLabelType.none,
          leading: DrawerHeader(
            child: _Logo(
              height: 80,
              padding: const EdgeInsets.all(16),
            ),
          ),
          onDestinationSelected: (index) {
            _selectedIndex.value = index;
            ctx.mainScreenProvider
                .navigateToScreen(menuItems[index].route, ctx);
          },
          destinations: menuItems.map((item) {
            return NavigationRailDestination(
              padding: EdgeInsets.zero,
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SvgPicture.asset(
                  item.svgSrc,
                  colorFilter:
                      const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
                  height: 20,
                ),
              ),
              selectedIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: SvgPicture.asset(
                  item.svgSrc,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  height: 20,
                ),
              ),
              label: Text(item.title),
            );
          }).toList(),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  WEB — Full sidebar  (icon + label, 250px)
// ─────────────────────────────────────────────────────────────────────────────
class _FullSidebar extends StatelessWidget {
  final BuildContext context;
  const _FullSidebar({required this.context});

  @override
  Widget build(BuildContext ctx) {
    // Get user role from provider
    final userProvider = Provider.of<UserProvider>(ctx, listen: false);
    final menuItems = _getMenuItems(userProvider.user);

    return Container(
      width: 250,
      color: Theme.of(ctx).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            child: _Logo(
              height: 80,
              padding: const EdgeInsets.all(16),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children:
                  menuItems.map((item) => _SidebarTile(item: item)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SHARED: Logo widget
// ─────────────────────────────────────────────────────────────────────────────
class _Logo extends StatelessWidget {
  final double height;
  final EdgeInsets padding;
  const _Logo({required this.height, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Image.asset(
        'assets/logo/Karachi shopping logo.png',
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SHARED: Drawer tile  (mobile)
// ─────────────────────────────────────────────────────────────────────────────
class _DrawerTile extends StatelessWidget {
  final _MenuItem item;
  const _DrawerTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.mainScreenProvider.navigateToScreen(item.route, context);
        Navigator.of(context).pop(); // close drawer
      },
      horizontalTitleGap: 0,
      leading: SvgPicture.asset(
        item.svgSrc,
        colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 18,
      ),
      title: Text(
        item.title,
        style: const TextStyle(color: Colors.white54, fontSize: 14),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SHARED: Sidebar tile  (web full sidebar)
// ─────────────────────────────────────────────────────────────────────────────
class _SidebarTile extends StatelessWidget {
  final _MenuItem item;
  const _SidebarTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndex,
      builder: (context, selected, _) {
        // Get current menu items to find index
        final userProvider = context.userProvider;
        final menuItems = _getMenuItems(userProvider.user);
        final itemIndex = menuItems.indexWhere((m) => m.route == item.route);
        final isSelected = itemIndex == selected;

        return ListTile(
          onTap: () {
            _selectedIndex.value = itemIndex;
            context.mainScreenProvider.navigateToScreen(item.route, context);
          },
          horizontalTitleGap: 0,
          tileColor:
              isSelected ? Colors.white.withOpacity(0.07) : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          leading: SvgPicture.asset(
            item.svgSrc,
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.white : Colors.white54,
              BlendMode.srcIn,
            ),
            height: 18,
          ),
          title: Text(
            item.title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white54,
              fontSize: AppFontSize.body(context),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SHARED: selected index state (lightweight, no StatefulWidget needed)
// ─────────────────────────────────────────────────────────────────────────────
final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

// ─────────────────────────────────────────────────────────────────────────────
//  LEGACY EXPORT — keeps existing call sites working unchanged
// ─────────────────────────────────────────────────────────────────────────────
class DrawerListTile extends StatelessWidget {
  final String title;
  final String svgSrc;
  final VoidCallback press;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 18,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white54,
          fontSize: AppFontSize.body(context),
        ),
      ),
    );
  }
}
