// import '../../brands/brand_screen.dart';
// import '../../category/category_screen.dart';
// import '../../coupon_code/coupon_code_screen.dart';
// import '../../dashboard/dashboard_screen.dart';
// import '../../notification/notification_screen.dart';
// import '../../order/order_screen.dart';
// import '../../posters/poster_screen.dart';
// import '../../variants/variants_screen.dart';
// import '../../variants_type/variants_type_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../sub_category/sub_category_screen.dart';

// class MainScreenProvider extends ChangeNotifier{
//   Widget selectedScreen = DashboardScreen();

//   navigateToScreen(String screenName) {
//     switch (screenName) {
//       case 'Dashboard':
//         selectedScreen = DashboardScreen();
//         break; // Break statement needed here
//       case 'Category':
//         selectedScreen = CategoryScreen();
//         break;
//       case 'SubCategory':
//         selectedScreen = SubCategoryScreen();
//         break;
//       case 'Brands':
//         selectedScreen = BrandScreen();
//         break;
//       case 'VariantType':
//         selectedScreen = VariantsTypeScreen();
//         break;
//       case 'Variants':
//         selectedScreen = VariantsScreen();
//         break;
//       case 'Coupon':
//         selectedScreen = CouponCodeScreen();
//         break;
//       case 'Poster':
//         selectedScreen = PosterScreen();
//         break;
//       case 'Order':
//         selectedScreen = OrderScreen();
//         break;
//       case 'Notifications':
//         selectedScreen = NotificationScreen();
//         break;
//       default:
//         selectedScreen = DashboardScreen();
//     }
//     notifyListeners();
//   }

// }

import 'package:admin/screens/superAdmin/sales/sales_Dashboard_screen.dart';
import 'package:admin/screens/superAdmin/all_users/all_users_screen.dart';
import 'package:admin/screens/superAdmin/sales_dashboard/sales_dashboard_screen.dart';
import 'package:admin/utility/extensions.dart';

import '../../brands/brand_screen.dart';
import '../../category/category_screen.dart';
import '../../coupon_code/coupon_code_screen.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../notification/notification_screen.dart';
import '../../order/order_screen.dart';
import '../../posters/poster_screen.dart';
import '../../variants/variants_screen.dart';
import '../../variants_type/variants_type_screen.dart';
import 'package:flutter/material.dart';
import '../../sub_category/sub_category_screen.dart';

class MainScreenProvider extends ChangeNotifier {
  Widget selectedScreen = DashboardScreen();

  void navigateToScreen(String screenName, BuildContext context) {
    print('Navigating to: $screenName');

    // Get user role from context extension
    final userRole = context.userProvider.user?.role;
    final isSuperAdmin = userRole == 'superAdmin';

    print('User role: $userRole');
    print('Is Super Admin: $isSuperAdmin');

    // Role-based access control
    if (screenName == 'Users' && !isSuperAdmin) {
      print('Access denied: Users screen only for Super Admin');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Access denied. Super Admin only.')),
      );
      return;
    }

    switch (screenName) {
      case 'Dashboard':
        // if (isSuperAdmin) {
        //   selectedScreen = const SalesDashboard();
        // } else {
        selectedScreen = DashboardScreen();
        // }
        break;

      case 'Users':
        print('Loading Users Screen');
        selectedScreen = const AllUsersScreen();
        break;
      case 'Sales':
        print('Loading Sales Screen');
        selectedScreen = const SalesDashboardScreen();
        break;
      case 'Category':
        selectedScreen = CategoryScreen();
        break;

      case 'SubCategory':
        selectedScreen = SubCategoryScreen();
        break;

      case 'Brands':
        selectedScreen = BrandScreen();
        break;

      case 'VariantType':
        selectedScreen = VariantsTypeScreen();
        break;

      case 'Variants':
        selectedScreen = VariantsScreen();
        break;

      case 'Coupon':
        selectedScreen = CouponCodeScreen();
        break;

      case 'Poster':
        selectedScreen = PosterScreen();
        break;

      case 'Order':
        selectedScreen = OrderScreen();
        break;

      case 'Notifications':
        selectedScreen = NotificationScreen();
        break;

      default:
        // if (isSuperAdmin) {
        //   selectedScreen = const SalesDashboard();
        // } else {
        selectedScreen = DashboardScreen();
      // }
    }
    notifyListeners();
  }
}
