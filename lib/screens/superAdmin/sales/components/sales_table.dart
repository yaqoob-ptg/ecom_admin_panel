// import 'package:admin/screens/superAdmin/sales/provider/sales_provider.dart';
// import 'package:admin/utility/constants.dart';
// import 'package:admin/utility/responsive_constants.dart';
// import 'package:flutter/material.dart';

// class SalesPerAdminTable extends StatelessWidget {
//   final List<SalesPerAdmin> salesData;

//   const SalesPerAdminTable({Key? key, required this.salesData})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = AppBreakpoints.isMobile(context);
//     final padding = AppSpacing.cardPadding(context);

//     return Container(
//       padding: padding,
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: BorderRadius.all(Radius.circular(AppRadius.md(context))),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Sales Performance by Admin',
//             style: TextStyle(
//               fontSize: AppFontSize.lg(context),
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: AppSpacing.sectionGap(context)),
//           if (salesData.isEmpty)
//             Center(
//               child: Padding(
//                 padding: EdgeInsets.all(AppSpacing.lg(context)),
//                 child: Text(
//                   'No sales data available',
//                   style: TextStyle(color: Colors.grey[400]),
//                 ),
//               ),
//             )
//           else if (isMobile)
//             _MobileSalesList(salesData: salesData)
//           else
//             _DesktopSalesTable(salesData: salesData),
//         ],
//       ),
//     );
//   }
// }

// class _DesktopSalesTable extends StatelessWidget {
//   final List<SalesPerAdmin> salesData;

//   const _DesktopSalesTable({required this.salesData});

//   @override
//   Widget build(BuildContext context) {
//     final totalSales =
//         salesData.fold(0.0, (sum, item) => sum + item.totalSales);

//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         columnSpacing: 20,
//         headingTextStyle: TextStyle(
//           fontSize: AppFontSize.sm(context),
//           fontWeight: FontWeight.w600,
//           color: Colors.white70,
//         ),
//         dataTextStyle: TextStyle(
//           fontSize: AppFontSize.sm(context),
//           color: Colors.white,
//         ),
//         columns: const [
//           DataColumn(label: Text('Admin Name')),
//           DataColumn(label: Text('Email')),
//           DataColumn(label: Text('Total Orders')),
//           DataColumn(label: Text('Total Sales')),
//           DataColumn(label: Text('Contribution')),
//         ],
//         rows: salesData.map((admin) {
//           final contribution = totalSales > 0
//               ? (admin.totalSales / totalSales * 100).toStringAsFixed(1)
//               : '0';

//           return DataRow(cells: [
//             DataCell(Text(admin.adminName)),
//             DataCell(Text(admin.adminEmail)),
//             DataCell(Text(admin.orderCount.toString())),
//             DataCell(Text('\$${admin.totalSales.toStringAsFixed(2)}')),
//             DataCell(
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.green.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   '$contribution%',
//                   style: const TextStyle(color: Colors.greenAccent),
//                 ),
//               ),
//             ),
//           ]);
//         }).toList(),
//       ),
//     );
//   }
// }

// class _MobileSalesList extends StatelessWidget {
//   final List<SalesPerAdmin> salesData;

//   const _MobileSalesList({required this.salesData});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: salesData.length,
//       separatorBuilder: (_, __) => SizedBox(height: AppSpacing.sm(context)),
//       itemBuilder: (context, index) {
//         final admin = salesData[index];
//         return Container(
//           padding: EdgeInsets.all(AppSpacing.md(context)),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(AppRadius.sm(context)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: primaryColor.withOpacity(0.2),
//                     child: Text(
//                       admin.adminName[0].toUpperCase(),
//                       style: const TextStyle(color: primaryColor),
//                     ),
//                   ),
//                   SizedBox(width: AppSpacing.sm(context)),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           admin.adminName,
//                           style: const TextStyle(fontWeight: FontWeight.w600),
//                         ),
//                         Text(
//                           admin.adminEmail,
//                           style:
//                               TextStyle(fontSize: 12, color: Colors.grey[400]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: AppSpacing.sm(context)),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _InfoChip(
//                     label: 'Orders: ${admin.orderCount}',
//                     icon: Icons.shopping_cart,
//                   ),
//                   _InfoChip(
//                     label: '\$${admin.totalSales.toStringAsFixed(2)}',
//                     icon: Icons.attach_money,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class _InfoChip extends StatelessWidget {
//   final String label;
//   final IconData icon;

//   const _InfoChip({required this.label, required this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: Colors.grey[400]),
//           const SizedBox(width: 4),
//           Text(label, style: const TextStyle(fontSize: 12)),
//         ],
//       ),
//     );
//   }
// }
