// import 'package:admin/screens/superAdmin/sales/components/cards.dart';
// import 'package:admin/screens/superAdmin/sales/components/header.dart';
// import 'package:admin/screens/superAdmin/sales/components/recent_users_list.dart';
// import 'package:admin/screens/superAdmin/sales/components/sales_table.dart';
// import 'package:admin/screens/superAdmin/sales/provider/sales_provider.dart';
// import 'package:admin/utility/extensions.dart';
// import 'package:admin/utility/responsive_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SalesDashboard extends StatefulWidget {
//   const SalesDashboard({Key? key}) : super(key: key);

//   @override
//   State<SalesDashboard> createState() => _SalesDashboardState();
// }

// class _SalesDashboardState extends State<SalesDashboard> {
//   @override
//   void initState() {
//     super.initState();
//     // Load data when provider is ready
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<SalesProvider>().loadDashboardData();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SalesProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final gap = AppSpacing.sectionGap(context);

//         return SafeArea(
//           child: SingleChildScrollView(
//             padding: AppSpacing.pagePadding(context),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header
//                 // _buildHeader(context),
//                 // // SalesDashboardHeader(),
//                 // SizedBox(height: gap),

//                 // // Stats Cards
//                 // SuperAdminStatsCards(stats: provider.dashboardStats),
//                 // SizedBox(height: gap),

//                 // Sales Per Admin Table
//                 SalesPerAdminTable(salesData: provider.salesPerAdmin),
//                 SizedBox(height: gap),

//                 // Recent Users
//                 // RecentUsersList(
//                 //   users: provider.recentUsers,
//                 //   onViewAll: () {
//                 //     context.mainScreenProvider
//                 //         .navigateToScreen('Users', context);
//                 //   },
//                 // ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Widget _buildHeader(BuildContext context) {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Text(
//   //         'Super Admin Dashboard',
//   //         style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//   //               fontWeight: FontWeight.bold,
//   //             ),
//   //       ),
//   //       const SizedBox(height: 8),
//   //       Text(
//   //         'Overview of platform analytics and admin performance',
//   //         style: TextStyle(
//   //           fontSize: AppFontSize.body(context),
//   //           color: Colors.grey[400],
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }
// }
