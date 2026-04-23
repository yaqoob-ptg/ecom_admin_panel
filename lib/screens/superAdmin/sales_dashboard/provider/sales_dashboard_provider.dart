// // // lib/screens/superAdmin/sales_dashboard/provider/sales_dashboard_provider.dart

// // import 'dart:developer';
// // import 'package:admin/models/sales_dashboard.dart';
// // import 'package:flutter/material.dart';
// // import '../../../../models/order.dart';
// // import '../../../../services/http_services.dart';
// // import '../../../../utility/snack_bar_helper.dart';

// // class SalesDashboardProvider extends ChangeNotifier {
// //   HttpService service = HttpService();

// //   bool isLoading = false;
// //   SalesPeriod selectedPeriod = SalesPeriod.overall;

// //   // Raw orders — we compute everything client-side from this
// //   List<Order> _allOrders = [];

// //   // ── Derived stats (recomputed on period change) ────────────────────────────
// //   SalesSummary summary = SalesSummary();
// //   List<AdminSalesStat> adminStats = [];
// //   List<ProductSalesStat> topProducts = [];
// //   List<ProductSalesStat> allProductSales = [];
// //   List<WeeklySalePoint> chartPoints = [];

// //   // ─── Fetch ────────────────────────────────────────────────────────────────

// //   Future<void> loadDashboard({bool showSnack = false}) async {
// //     try {
// //       isLoading = true;
// //       notifyListeners();

// //       // Use super-admin orders endpoint (no adminId filter)
// //       final response = await service.getItems(endpointUrl: 'orders');

// //       if (response.isOk) {
// //         final List raw = response.body['data'] ?? [];
// //         _allOrders = raw.map((j) => Order.fromJson(j)).toList();
// //         _recompute();
// //         if (showSnack)
// //           SnackBarHelper.showSuccessSnackBar('Dashboard refreshed');
// //       } else {
// //         if (showSnack)
// //           SnackBarHelper.showErrorSnackBar(
// //               response.body?['message'] ?? 'Failed to load data');
// //       }
// //     } catch (e) {
// //       log('SalesDashboard load error: $e');
// //       if (showSnack) SnackBarHelper.showErrorSnackBar('Error: $e');
// //     } finally {
// //       isLoading = false;
// //       notifyListeners();
// //     }
// //   }

// //   void setPeriod(SalesPeriod period) {
// //     selectedPeriod = period;
// //     _recompute();
// //   }

// //   // ─── Computation ──────────────────────────────────────────────────────────

// //   void _recompute() {
// //     final filtered = _filterByPeriod(_allOrders, selectedPeriod);
// //     final today = _filterByPeriod(_allOrders, SalesPeriod.today);

// //     summary = _buildSummary(filtered, today);
// //     adminStats = _buildAdminStats(filtered);
// //     allProductSales = _buildProductStats(filtered);
// //     topProducts = [...allProductSales]
// //       ..sort((a, b) => b.totalQuantity.compareTo(a.totalQuantity));
// //     topProducts = topProducts.take(10).toList();
// //     chartPoints = _buildChartPoints(filtered, selectedPeriod);

// //     notifyListeners();
// //   }

// //   List<Order> _filterByPeriod(List<Order> orders, SalesPeriod period) {
// //     if (period == SalesPeriod.overall) return orders;

// //     final now = DateTime.now();
// //     final todayStart = DateTime(now.year, now.month, now.day);

// //     return orders.where((o) {
// //       final date = _parseDate(o.orderDate);
// //       if (date == null) return false;

// //       switch (period) {
// //         case SalesPeriod.today:
// //           return date.isAfter(todayStart) || date.isAtSameMomentAs(todayStart);
// //         case SalesPeriod.week:
// //           final weekStart =
// //               todayStart.subtract(Duration(days: now.weekday - 1));
// //           return date.isAfter(weekStart) || date.isAtSameMomentAs(weekStart);
// //         case SalesPeriod.month:
// //           return date.year == now.year && date.month == now.month;
// //         default:
// //           return true;
// //       }
// //     }).toList();
// //   }

// //   SalesSummary _buildSummary(List<Order> filtered, List<Order> today) {
// //     double totalRevenue = 0;
// //     double todayRevenue = 0;
// //     int pending = 0, shipped = 0, delivered = 0, cancelled = 0;

// //     for (final o in filtered) {
// //       totalRevenue += (o.orderTotal?.total ?? o.totalPrice ?? 0).toDouble();
// //       switch (o.orderStatus) {
// //         case 'pending':
// //           pending++;
// //           break;
// //         case 'shipped':
// //           shipped++;
// //           break;
// //         case 'delivered':
// //           delivered++;
// //           break;
// //         case 'cancelled':
// //           cancelled++;
// //           break;
// //       }
// //     }
// //     for (final o in today) {
// //       todayRevenue += (o.orderTotal?.total ?? o.totalPrice ?? 0).toDouble();
// //     }

// //     return SalesSummary(
// //       totalRevenue: totalRevenue,
// //       totalOrders: filtered.length,
// //       todayRevenue: todayRevenue,
// //       todayOrders: today.length,
// //       pendingOrders: pending,
// //       shippedOrders: shipped,
// //       deliveredOrders: delivered,
// //       cancelledOrders: cancelled,
// //     );
// //   }

// //   List<AdminSalesStat> _buildAdminStats(List<Order> orders) {
// //     final Map<String, Map<String, dynamic>> map = {};

// //     for (final o in orders) {
// //       final adminId = o.adminId ?? 'unknown';
// //       final adminName = o.adminName ?? 'Unknown Admin';
// //       final revenue = (o.orderTotal?.total ?? o.totalPrice ?? 0).toDouble();

// //       map.putIfAbsent(
// //           adminId,
// //           () => {
// //                 'adminId': adminId,
// //                 'adminName': adminName,
// //                 'adminEmail': o.adminEmail ?? '',
// //                 'totalSales': 0.0,
// //                 'orderCount': 0,
// //                 'pendingOrders': 0,
// //                 'shippedOrders': 0,
// //                 'deliveredOrders': 0,
// //                 'cancelledOrders': 0,
// //               });

// //       map[adminId]!['totalSales'] =
// //           (map[adminId]!['totalSales'] as double) + revenue;
// //       map[adminId]!['orderCount'] = (map[adminId]!['orderCount'] as int) + 1;

// //       switch (o.orderStatus) {
// //         case 'pending':
// //           map[adminId]!['pendingOrders'] =
// //               (map[adminId]!['pendingOrders'] as int) + 1;
// //           break;
// //         case 'shipped':
// //           map[adminId]!['shippedOrders'] =
// //               (map[adminId]!['shippedOrders'] as int) + 1;
// //           break;
// //         case 'delivered':
// //           map[adminId]!['deliveredOrders'] =
// //               (map[adminId]!['deliveredOrders'] as int) + 1;
// //           break;
// //         case 'cancelled':
// //           map[adminId]!['cancelledOrders'] =
// //               (map[adminId]!['cancelledOrders'] as int) + 1;
// //           break;
// //       }
// //     }

// //     final list = map.values.map((m) => AdminSalesStat.fromJson(m)).toList();
// //     list.sort((a, b) => b.totalSales.compareTo(a.totalSales));
// //     return list;
// //   }

// //   List<ProductSalesStat> _buildProductStats(List<Order> orders) {
// //     final Map<String, Map<String, dynamic>> map = {};

// //     for (final o in orders) {
// //       for (final item in (o.items ?? [])) {
// //         final key = '${item.productID ?? item.productName}';
// //         map.putIfAbsent(
// //             key,
// //             () => {
// //                   'productId': item.productID ?? '',
// //                   'productName': item.productName ?? 'Unknown',
// //                   'adminName': o.adminName ?? 'Unknown Admin',
// //                   'totalQuantity': 0,
// //                   'totalRevenue': 0.0,
// //                   'orderCount': 0,
// //                 });
// //         map[key]!['totalQuantity'] =
// //             (map[key]!['totalQuantity'] as int) + (item.quantity ?? 0);
// //         map[key]!['totalRevenue'] = (map[key]!['totalRevenue'] as double) +
// //             ((item.price ?? 0) * (item.quantity ?? 0)).toDouble();
// //         map[key]!['orderCount'] = (map[key]!['orderCount'] as int) + 1;
// //       }
// //     }

// //     return map.values.map((m) => ProductSalesStat.fromJson(m)).toList();
// //   }

// //   List<WeeklySalePoint> _buildChartPoints(
// //       List<Order> orders, SalesPeriod period) {
// //     if (period == SalesPeriod.today) {
// //       // Group by hour (0–23)
// //       final Map<int, Map<String, dynamic>> byHour = {};
// //       for (int i = 0; i < 24; i += 3) {
// //         byHour[i] = {'revenue': 0.0, 'orders': 0};
// //       }
// //       for (final o in orders) {
// //         final dt = _parseDate(o.orderDate);
// //         if (dt == null) continue;
// //         final bucket = (dt.hour ~/ 3) * 3;
// //         byHour.putIfAbsent(bucket, () => {'revenue': 0.0, 'orders': 0});
// //         byHour[bucket]!['revenue'] = (byHour[bucket]!['revenue'] as double) +
// //             (o.orderTotal?.total ?? o.totalPrice ?? 0).toDouble();
// //         byHour[bucket]!['orders'] = (byHour[bucket]!['orders'] as int) + 1;
// //       }
// //       return byHour.entries
// //           .map((e) => WeeklySalePoint(
// //                 label: '${e.key}:00',
// //                 revenue: e.value['revenue'] as double,
// //                 orders: e.value['orders'] as int,
// //               ))
// //           .toList();
// //     }

// //     if (period == SalesPeriod.week ||
// //         period == SalesPeriod.overall && orders.length < 200) {
// //       // Group by weekday
// //       final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
// //       final Map<int, Map<String, dynamic>> byDay = {
// //         for (int i = 1; i <= 7; i++) i: {'revenue': 0.0, 'orders': 0}
// //       };
// //       for (final o in orders) {
// //         final dt = _parseDate(o.orderDate);
// //         if (dt == null) continue;
// //         byDay[dt.weekday]!['revenue'] =
// //             (byDay[dt.weekday]!['revenue'] as double) +
// //                 (o.orderTotal?.total ?? o.totalPrice ?? 0).toDouble();
// //         byDay[dt.weekday]!['orders'] =
// //             (byDay[dt.weekday]!['orders'] as int) + 1;
// //       }
// //       return byDay.entries
// //           .map((e) => WeeklySalePoint(
// //                 label: days[e.key - 1],
// //                 revenue: e.value['revenue'] as double,
// //                 orders: e.value['orders'] as int,
// //               ))
// //           .toList();
// //     }

// //     // Month / overall — group by week number in month or by month
// //     if (period == SalesPeriod.month) {
// //       final Map<int, Map<String, dynamic>> byWeek = {
// //         for (int i = 1; i <= 5; i++) i: {'revenue': 0.0, 'orders': 0}
// //       };
// //       for (final o in orders) {
// //         final dt = _parseDate(o.orderDate);
// //         if (dt == null) continue;
// //         final week = ((dt.day - 1) ~/ 7) + 1;
// //         byWeek[week]!['revenue'] = (byWeek[week]!['revenue'] as double) +
// //             (o.orderTotal?.total ?? o.totalPrice ?? 0).toDouble();
// //         byWeek[week]!['orders'] = (byWeek[week]!['orders'] as int) + 1;
// //       }
// //       return byWeek.entries
// //           .where((e) =>
// //               (e.value['revenue'] as double) > 0 ||
// //               (e.value['orders'] as int) > 0)
// //           .map((e) => WeeklySalePoint(
// //                 label: 'Wk ${e.key}',
// //                 revenue: e.value['revenue'] as double,
// //                 orders: e.value['orders'] as int,
// //               ))
// //           .toList();
// //     }

// //     // Overall — group by month
// //     final Map<int, Map<String, dynamic>> byMonth = {};
// //     final monthNames = [
// //       'Jan',
// //       'Feb',
// //       'Mar',
// //       'Apr',
// //       'May',
// //       'Jun',
// //       'Jul',
// //       'Aug',
// //       'Sep',
// //       'Oct',
// //       'Nov',
// //       'Dec'
// //     ];
// //     for (final o in orders) {
// //       final dt = _parseDate(o.orderDate);
// //       if (dt == null) continue;
// //       byMonth.putIfAbsent(dt.month, () => {'revenue': 0.0, 'orders': 0});
// //       byMonth[dt.month]!['revenue'] =
// //           (byMonth[dt.month]!['revenue'] as double) +
// //               (o.orderTotal?.total ?? o.totalPrice ?? 0).toDouble();
// //       byMonth[dt.month]!['orders'] = (byMonth[dt.month]!['orders'] as int) + 1;
// //     }
// //     final sorted = byMonth.entries.toList()
// //       ..sort((a, b) => a.key.compareTo(b.key));
// //     return sorted
// //         .map((e) => WeeklySalePoint(
// //               label: monthNames[e.key - 1],
// //               revenue: e.value['revenue'] as double,
// //               orders: e.value['orders'] as int,
// //             ))
// //         .toList();
// //   }

// //   DateTime? _parseDate(dynamic raw) {
// //     if (raw == null) return null;
// //     if (raw is DateTime) return raw;
// //     try {
// //       return DateTime.parse(raw.toString());
// //     } catch (_) {
// //       return null;
// //     }
// //   }

// //   // ── Totals for the revenue bar chart (max for scaling)
// //   double get maxChartRevenue => chartPoints.isEmpty
// //       ? 1
// //       : chartPoints.map((p) => p.revenue).reduce((a, b) => a > b ? a : b);
// // }

// // lib/screens/superAdmin/sales_dashboard/provider/sales_dashboard_provider.dart

// import 'dart:developer';
// import 'package:admin/models/sales_dashboard.dart';
// import 'package:flutter/material.dart';
// import '../../../../models/order.dart';
// import '../../../../services/http_services.dart';
// import '../../../../utility/snack_bar_helper.dart';

// class SalesDashboardProvider extends ChangeNotifier {
//   HttpService service = HttpService();

//   bool isLoading = false;
//   SalesPeriod selectedPeriod = SalesPeriod.overall;

//   List<Order> _allOrders = [];

//   SalesSummary summary = SalesSummary();
//   List<AdminSalesStat> adminStats = [];
//   List<ProductSalesStat> topProducts = [];
//   List<ProductSalesStat> allProductSales = [];
//   List<WeeklySalePoint> chartPoints = [];

//   // ─── Fetch ────────────────────────────────────────────────────────────────

//   Future<void> loadDashboard({bool showSnack = false}) async {
//     try {
//       isLoading = true;
//       notifyListeners();

//       final response = await service.getItems(endpointUrl: 'orders');

//       if (response.isOk) {
//         final List raw = response.body['data'] ?? [];
//         _allOrders = raw.map((j) => Order.fromJson(j)).toList();
//         _recompute();
//         if (showSnack)
//           SnackBarHelper.showSuccessSnackBar('Dashboard refreshed');
//       } else {
//         if (showSnack)
//           SnackBarHelper.showErrorSnackBar(
//               response.body?['message'] ?? 'Failed to load data');
//       }
//     } catch (e) {
//       log('SalesDashboard load error: $e');
//       if (showSnack) SnackBarHelper.showErrorSnackBar('Error: $e');
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   void setPeriod(SalesPeriod period) {
//     selectedPeriod = period;
//     _recompute();
//   }

//   // ─── Computation ──────────────────────────────────────────────────────────

//   void _recompute() {
//     final filtered = _filterByPeriod(_allOrders, selectedPeriod);
//     // Today is always computed from ALL orders regardless of selected period
//     final todayOrders = _filterByPeriod(_allOrders, SalesPeriod.today);

//     summary = _buildSummary(filtered, todayOrders);
//     adminStats = _buildAdminStats(filtered);
//     allProductSales = _buildProductStats(filtered);
//     topProducts = (List<ProductSalesStat>.from(allProductSales)
//           ..sort((a, b) => b.totalQuantity.compareTo(a.totalQuantity)))
//         .take(10)
//         .toList();
//     chartPoints = _buildChartPoints(filtered, selectedPeriod);

//     notifyListeners();
//   }

//   // ─── Date filtering ───────────────────────────────────────────────────────
//   // All order dates come from MongoDB as UTC ISO strings.
//   // We convert them to LOCAL time before comparing so "today" matches the
//   // user's actual calendar day, not UTC midnight.

//   List<Order> _filterByPeriod(List<Order> orders, SalesPeriod period) {
//     if (period == SalesPeriod.overall) return orders;

//     final now = DateTime.now(); // local time
//     final todayLocal = DateTime(now.year, now.month, now.day); // local midnight

//     return orders.where((o) {
//       final utcDate = _parseDate(o.orderDate);
//       if (utcDate == null) return false;
//       // Convert UTC → local before comparing
//       final local = utcDate.toLocal();
//       final localDay = DateTime(local.year, local.month, local.day);

//       switch (period) {
//         case SalesPeriod.today:
//           // Same calendar day in local time
//           return localDay.isAtSameMomentAs(todayLocal);

//         case SalesPeriod.week:
//           // Monday of the current local week
//           final monday =
//               todayLocal.subtract(Duration(days: todayLocal.weekday - 1));
//           return !localDay.isBefore(monday);

//         case SalesPeriod.month:
//           // Same year+month in local time
//           return local.year == now.year && local.month == now.month;

//         case SalesPeriod.overall:
//           return true;
//       }
//     }).toList();
//   }

//   // ─── Summary KPIs ─────────────────────────────────────────────────────────

//   SalesSummary _buildSummary(List<Order> filtered, List<Order> todayOrders) {
//     double totalRevenue = 0;
//     double todayRevenue = 0;
//     int pending = 0, shipped = 0, delivered = 0, cancelled = 0;

//     for (final o in filtered) {
//       totalRevenue += _orderTotal(o);
//       switch (o.orderStatus) {
//         case 'pending':
//           pending++;
//           break;
//         case 'shipped':
//           shipped++;
//           break;
//         case 'delivered':
//           delivered++;
//           break;
//         case 'cancelled':
//           cancelled++;
//           break;
//       }
//     }
//     for (final o in todayOrders) {
//       todayRevenue += _orderTotal(o);
//     }

//     return SalesSummary(
//       totalRevenue: totalRevenue,
//       totalOrders: filtered.length,
//       todayRevenue: todayRevenue,
//       todayOrders: todayOrders.length,
//       pendingOrders: pending,
//       shippedOrders: shipped,
//       deliveredOrders: delivered,
//       cancelledOrders: cancelled,
//     );
//   }

//   // ─── Admin stats ──────────────────────────────────────────────────────────

//   List<AdminSalesStat> _buildAdminStats(List<Order> orders) {
//     final Map<String, Map<String, dynamic>> map = {};

//     for (final o in orders) {
//       final adminId = o.adminId ?? 'unknown';
//       final adminName = o.adminName ?? 'Unknown Admin';
//       final revenue = _orderTotal(o);

//       map.putIfAbsent(
//           adminId,
//           () => {
//                 'adminId': adminId,
//                 'adminName': adminName,
//                 'adminEmail': o.adminEmail ?? '',
//                 'totalSales': 0.0,
//                 'orderCount': 0,
//                 'pendingOrders': 0,
//                 'shippedOrders': 0,
//                 'deliveredOrders': 0,
//                 'cancelledOrders': 0,
//               });

//       map[adminId]!['totalSales'] =
//           (map[adminId]!['totalSales'] as double) + revenue;
//       map[adminId]!['orderCount'] = (map[adminId]!['orderCount'] as int) + 1;

//       switch (o.orderStatus) {
//         case 'pending':
//           map[adminId]!['pendingOrders'] =
//               (map[adminId]!['pendingOrders'] as int) + 1;
//           break;
//         case 'shipped':
//           map[adminId]!['shippedOrders'] =
//               (map[adminId]!['shippedOrders'] as int) + 1;
//           break;
//         case 'delivered':
//           map[adminId]!['deliveredOrders'] =
//               (map[adminId]!['deliveredOrders'] as int) + 1;
//           break;
//         case 'cancelled':
//           map[adminId]!['cancelledOrders'] =
//               (map[adminId]!['cancelledOrders'] as int) + 1;
//           break;
//       }
//     }

//     return (map.values.map((m) => AdminSalesStat.fromJson(m)).toList()
//       ..sort((a, b) => b.totalSales.compareTo(a.totalSales)));
//   }

//   // ─── Product stats ────────────────────────────────────────────────────────

//   List<ProductSalesStat> _buildProductStats(List<Order> orders) {
//     final Map<String, Map<String, dynamic>> map = {};

//     for (final o in orders) {
//       for (final item in (o.items ?? [])) {
//         final key = '${item.productID ?? item.productName}';
//         map.putIfAbsent(
//             key,
//             () => {
//                   'productId': item.productID ?? '',
//                   'productName': item.productName ?? 'Unknown',
//                   'adminName': o.adminName ?? 'Unknown Admin',
//                   'totalQuantity': 0,
//                   'totalRevenue': 0.0,
//                   'orderCount': 0,
//                 });
//         map[key]!['totalQuantity'] =
//             (map[key]!['totalQuantity'] as int) + (item.quantity ?? 0);
//         map[key]!['totalRevenue'] = (map[key]!['totalRevenue'] as double) +
//             ((item.price ?? 0) * (item.quantity ?? 0)).toDouble();
//         map[key]!['orderCount'] = (map[key]!['orderCount'] as int) + 1;
//       }
//     }
//     return map.values.map((m) => ProductSalesStat.fromJson(m)).toList();
//   }

//   // ─── Chart points ─────────────────────────────────────────────────────────
//   // Each period gets the most meaningful grouping:
//   //   today   → 3-hour buckets  (0:00, 3:00, 6:00 … 21:00)
//   //   week    → day of week     (Mon … Sun)
//   //   month   → week number     (Wk 1 … Wk 5)
//   //   overall → calendar month  (Jan … Dec)
//   //
//   // All timestamps are converted to LOCAL time before bucketing.

//   List<WeeklySalePoint> _buildChartPoints(
//       List<Order> orders, SalesPeriod period) {
//     switch (period) {
//       case SalesPeriod.today:
//         return _groupByHour(orders);
//       case SalesPeriod.week:
//         return _groupByWeekday(orders);
//       case SalesPeriod.month:
//         return _groupByWeekOfMonth(orders);
//       case SalesPeriod.overall:
//         return _groupByMonth(orders);
//     }
//   }

//   // ── Today: 3-hour buckets 0–21 ───────────────────────────────────────────
//   List<WeeklySalePoint> _groupByHour(List<Order> orders) {
//     // Pre-fill all 8 buckets (0,3,6…21)
//     final Map<int, _Bucket> buckets = {
//       for (int h = 0; h < 24; h += 3) h: _Bucket()
//     };

//     for (final o in orders) {
//       final dt = _parseDate(o.orderDate)?.toLocal();
//       if (dt == null) continue;
//       final bucket = (dt.hour ~/ 3) * 3;
//       buckets.putIfAbsent(bucket, () => _Bucket());
//       buckets[bucket]!.add(_orderTotal(o));
//     }

//     final sorted = buckets.entries.toList()
//       ..sort((a, b) => a.key.compareTo(b.key));
//     return sorted
//         .map((e) => WeeklySalePoint(
//               label: '${e.key.toString().padLeft(2, '0')}:00',
//               revenue: e.value.revenue,
//               orders: e.value.orders,
//             ))
//         .toList();
//   }

//   // ── Week: Mon–Sun ─────────────────────────────────────────────────────────
//   List<WeeklySalePoint> _groupByWeekday(List<Order> orders) {
//     const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     final Map<int, _Bucket> buckets = {
//       for (int i = 1; i <= 7; i++) i: _Bucket()
//     };

//     for (final o in orders) {
//       final dt = _parseDate(o.orderDate)?.toLocal();
//       if (dt == null) continue;
//       buckets[dt.weekday]!.add(_orderTotal(o));
//     }

//     return (buckets.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
//         .map((e) => WeeklySalePoint(
//               label: days[e.key - 1],
//               revenue: e.value.revenue,
//               orders: e.value.orders,
//             ))
//         .toList();
//   }

//   // ── Month: Wk 1–5 ────────────────────────────────────────────────────────
//   List<WeeklySalePoint> _groupByWeekOfMonth(List<Order> orders) {
//     final Map<int, _Bucket> buckets = {
//       for (int w = 1; w <= 5; w++) w: _Bucket()
//     };

//     for (final o in orders) {
//       final dt = _parseDate(o.orderDate)?.toLocal();
//       if (dt == null) continue;
//       final week = ((dt.day - 1) ~/ 7) + 1; // 1–5
//       buckets[week]!.add(_orderTotal(o));
//     }

//     // Only show weeks that have any orders or precede the current week
//     final now = DateTime.now();
//     final currentWk = ((now.day - 1) ~/ 7) + 1;

//     return (buckets.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
//         .where((e) => e.key <= currentWk) // hide future weeks
//         .map((e) => WeeklySalePoint(
//               label: 'Wk ${e.key}',
//               revenue: e.value.revenue,
//               orders: e.value.orders,
//             ))
//         .toList();
//   }

//   // ── Overall: Jan–Dec ──────────────────────────────────────────────────────
//   List<WeeklySalePoint> _groupByMonth(List<Order> orders) {
//     const monthNames = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec'
//     ];
//     // Pre-fill Jan–current month so the axis always shows them
//     final now = DateTime.now();
//     final Map<int, _Bucket> buckets = {
//       for (int m = 1; m <= now.month; m++) m: _Bucket()
//     };

//     for (final o in orders) {
//       final dt = _parseDate(o.orderDate)?.toLocal();
//       if (dt == null) continue;
//       buckets.putIfAbsent(dt.month, () => _Bucket());
//       buckets[dt.month]!.add(_orderTotal(o));
//     }

//     return (buckets.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
//         .map((e) => WeeklySalePoint(
//               label: monthNames[e.key - 1],
//               revenue: e.value.revenue,
//               orders: e.value.orders,
//             ))
//         .toList();
//   }

//   // ─── Helpers ──────────────────────────────────────────────────────────────

//   double _orderTotal(Order o) =>
//       (o.orderTotal?.total ?? o.totalPrice ?? 0).toDouble();

//   DateTime? _parseDate(dynamic raw) {
//     if (raw == null) return null;
//     if (raw is DateTime) return raw;
//     try {
//       return DateTime.parse(raw.toString());
//     } catch (_) {
//       return null;
//     }
//   }

//   double get maxChartRevenue => chartPoints.isEmpty
//       ? 1
//       : chartPoints.map((p) => p.revenue).reduce((a, b) => a > b ? a : b);
// }

// // ─── Internal bucket helper ───────────────────────────────────────────────────
// class _Bucket {
//   double revenue = 0;
//   int orders = 0;
//   void add(double r) {
//     revenue += r;
//     orders++;
//   }
// }

// lib/screens/superAdmin/sales_dashboard/provider/sales_dashboard_provider.dart

import 'dart:developer';
import 'package:admin/models/sales_dashboard.dart';
import 'package:flutter/material.dart';
import '../../../../models/order.dart';
import '../../../../services/http_services.dart';
import '../../../../utility/snack_bar_helper.dart';

class SalesDashboardProvider extends ChangeNotifier {
  HttpService service = HttpService();

  bool isLoading = false;
  SalesPeriod selectedPeriod = SalesPeriod.overall;

  List<Order> _allOrders = [];

  SalesSummary summary = SalesSummary();
  List<AdminSalesStat> adminStats = [];
  List<ProductSalesStat> topProducts = [];
  List<ProductSalesStat> allProductSales = [];
  List<WeeklySalePoint> chartPoints = [];

  // ─── Fetch ────────────────────────────────────────────────────────────────

  Future<void> loadDashboard({bool showSnack = false}) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await service.getItems(endpointUrl: 'orders');

      if (response.isOk) {
        final List raw = response.body['data'] ?? [];
        _allOrders = raw.map((j) => Order.fromJson(j)).toList();
        _recompute();
        if (showSnack)
          SnackBarHelper.showSuccessSnackBar('Dashboard refreshed');
      } else {
        if (showSnack)
          SnackBarHelper.showErrorSnackBar(
              response.body?['message'] ?? 'Failed to load data');
      }
    } catch (e) {
      log('SalesDashboard load error: $e');
      if (showSnack) SnackBarHelper.showErrorSnackBar('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setPeriod(SalesPeriod period) {
    selectedPeriod = period;
    _recompute();
  }

  // ─── Computation ──────────────────────────────────────────────────────────

  void _recompute() {
    final filtered = _filterByPeriod(_allOrders, selectedPeriod);
    // Today is always computed from ALL orders regardless of selected period
    final todayOrders = _filterByPeriod(_allOrders, SalesPeriod.today);

    summary = _buildSummary(filtered, todayOrders);
    adminStats = _buildAdminStats(filtered);
    allProductSales = _buildProductStats(filtered);
    topProducts = (List<ProductSalesStat>.from(allProductSales)
          ..sort((a, b) => b.totalQuantity.compareTo(a.totalQuantity)))
        .take(10)
        .toList();
    chartPoints = _buildChartPoints(filtered, selectedPeriod);

    notifyListeners();
  }

  // ─── Date filtering ───────────────────────────────────────────────────────
  // All order dates come from MongoDB as UTC ISO strings.
  // We convert them to LOCAL time before comparing so "today" matches the
  // user's actual calendar day, not UTC midnight.

  List<Order> _filterByPeriod(List<Order> orders, SalesPeriod period) {
    if (period == SalesPeriod.overall) return orders;

    final now = DateTime.now(); // local time
    final todayLocal = DateTime(now.year, now.month, now.day); // local midnight

    return orders.where((o) {
      final utcDate = _parseDate(o.orderDate);
      if (utcDate == null) return false;
      // Convert UTC → local before comparing
      final local = utcDate.toLocal();
      final localDay = DateTime(local.year, local.month, local.day);

      switch (period) {
        case SalesPeriod.today:
          // Same calendar day in local time
          return localDay.isAtSameMomentAs(todayLocal);

        case SalesPeriod.week:
          // Monday of the current local week
          final monday =
              todayLocal.subtract(Duration(days: todayLocal.weekday - 1));
          return !localDay.isBefore(monday);

        case SalesPeriod.month:
          // Same year+month in local time
          return local.year == now.year && local.month == now.month;

        case SalesPeriod.overall:
          return true;
      }
    }).toList();
  }

  // ─── Summary KPIs ─────────────────────────────────────────────────────────

  SalesSummary _buildSummary(List<Order> filtered, List<Order> todayOrders) {
    double totalRevenue = 0;
    double todayRevenue = 0;
    int pending = 0, shipped = 0, delivered = 0, cancelled = 0;

    for (final o in filtered) {
      totalRevenue += _orderTotal(o);
      switch (o.orderStatus) {
        case 'pending':
          pending++;
          break;
        case 'shipped':
          shipped++;
          break;
        case 'delivered':
          delivered++;
          break;
        case 'cancelled':
          cancelled++;
          break;
      }
    }
    for (final o in todayOrders) {
      todayRevenue += _orderTotal(o);
    }

    return SalesSummary(
      totalRevenue: totalRevenue,
      totalOrders: filtered.length,
      todayRevenue: todayRevenue,
      todayOrders: todayOrders.length,
      pendingOrders: pending,
      shippedOrders: shipped,
      deliveredOrders: delivered,
      cancelledOrders: cancelled,
    );
  }

  // ─── Admin stats ──────────────────────────────────────────────────────────

  List<AdminSalesStat> _buildAdminStats(List<Order> orders) {
    final Map<String, Map<String, dynamic>> map = {};

    for (final o in orders) {
      final adminId = o.adminId ?? 'unknown';
      final adminName = o.adminName ?? 'Unknown Admin';
      final revenue = _orderTotal(o);

      map.putIfAbsent(
          adminId,
          () => {
                'adminId': adminId,
                'adminName': adminName,
                'adminEmail': o.adminEmail ?? '',
                'totalSales': 0.0,
                'orderCount': 0,
                'pendingOrders': 0,
                'shippedOrders': 0,
                'deliveredOrders': 0,
                'cancelledOrders': 0,
              });

      map[adminId]!['totalSales'] =
          (map[adminId]!['totalSales'] as double) + revenue;
      map[adminId]!['orderCount'] = (map[adminId]!['orderCount'] as int) + 1;

      switch (o.orderStatus) {
        case 'pending':
          map[adminId]!['pendingOrders'] =
              (map[adminId]!['pendingOrders'] as int) + 1;
          break;
        case 'shipped':
          map[adminId]!['shippedOrders'] =
              (map[adminId]!['shippedOrders'] as int) + 1;
          break;
        case 'delivered':
          map[adminId]!['deliveredOrders'] =
              (map[adminId]!['deliveredOrders'] as int) + 1;
          break;
        case 'cancelled':
          map[adminId]!['cancelledOrders'] =
              (map[adminId]!['cancelledOrders'] as int) + 1;
          break;
      }
    }

    return (map.values.map((m) => AdminSalesStat.fromJson(m)).toList()
      ..sort((a, b) => b.totalSales.compareTo(a.totalSales)));
  }

  // ─── Product stats ────────────────────────────────────────────────────────

  List<ProductSalesStat> _buildProductStats(List<Order> orders) {
    final Map<String, Map<String, dynamic>> map = {};

    for (final o in orders) {
      for (final item in (o.items ?? [])) {
        final key = '${item.productID ?? item.productName}';
        map.putIfAbsent(
            key,
            () => {
                  'productId': item.productID ?? '',
                  'productName': item.productName ?? 'Unknown',
                  'adminName': o.adminName ?? 'Unknown Admin',
                  'totalQuantity': 0,
                  'totalRevenue': 0.0,
                  'orderCount': 0,
                });
        map[key]!['totalQuantity'] =
            (map[key]!['totalQuantity'] as int) + (item.quantity ?? 0);
        map[key]!['totalRevenue'] = (map[key]!['totalRevenue'] as double) +
            ((item.price ?? 0) * (item.quantity ?? 0)).toDouble();
        map[key]!['orderCount'] = (map[key]!['orderCount'] as int) + 1;
      }
    }
    return map.values.map((m) => ProductSalesStat.fromJson(m)).toList();
  }

  // ─── Chart points ─────────────────────────────────────────────────────────
  // Each period gets the most meaningful grouping:
  //   today   → 3-hour buckets  (0:00, 3:00, 6:00 … 21:00)
  //   week    → day of week     (Mon … Sun)
  //   month   → week number     (Wk 1 … Wk 5)
  //   overall → calendar month  (Jan … Dec)
  //
  // All timestamps are converted to LOCAL time before bucketing.

  List<WeeklySalePoint> _buildChartPoints(
      List<Order> orders, SalesPeriod period) {
    switch (period) {
      case SalesPeriod.today:
        return _groupByHour(orders);
      case SalesPeriod.week:
        return _groupByWeekday(orders);
      case SalesPeriod.month:
        return _groupByWeekOfMonth(orders);
      case SalesPeriod.overall:
        return _groupByMonth(orders);
    }
  }

  // ── Today: 3-hour buckets 0–21 ───────────────────────────────────────────
  List<WeeklySalePoint> _groupByHour(List<Order> orders) {
    // Pre-fill all 8 buckets (0,3,6…21)
    final Map<int, _Bucket> buckets = {
      for (int h = 0; h < 24; h += 3) h: _Bucket()
    };

    for (final o in orders) {
      final dt = _parseDate(o.orderDate)?.toLocal();
      if (dt == null) continue;
      final bucket = (dt.hour ~/ 3) * 3;
      buckets.putIfAbsent(bucket, () => _Bucket());
      buckets[bucket]!.add(_orderTotal(o));
    }

    final sorted = buckets.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return sorted
        .map((e) => WeeklySalePoint(
              label: '${e.key.toString().padLeft(2, '0')}:00',
              revenue: e.value.revenue,
              orders: e.value.orders,
            ))
        .toList();
  }

  // ── Week: Mon–Sun ─────────────────────────────────────────────────────────
  List<WeeklySalePoint> _groupByWeekday(List<Order> orders) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final Map<int, _Bucket> buckets = {
      for (int i = 1; i <= 7; i++) i: _Bucket()
    };

    for (final o in orders) {
      final dt = _parseDate(o.orderDate)?.toLocal();
      if (dt == null) continue;
      buckets[dt.weekday]!.add(_orderTotal(o));
    }

    return (buckets.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
        .map((e) => WeeklySalePoint(
              label: days[e.key - 1],
              revenue: e.value.revenue,
              orders: e.value.orders,
            ))
        .toList();
  }

  // ── Month: Wk 1–5 ────────────────────────────────────────────────────────
  List<WeeklySalePoint> _groupByWeekOfMonth(List<Order> orders) {
    final Map<int, _Bucket> buckets = {
      for (int w = 1; w <= 5; w++) w: _Bucket()
    };

    for (final o in orders) {
      final dt = _parseDate(o.orderDate)?.toLocal();
      if (dt == null) continue;
      final week = ((dt.day - 1) ~/ 7) + 1; // 1–5
      buckets[week]!.add(_orderTotal(o));
    }

    // Only show weeks that have any orders or precede the current week
    final now = DateTime.now();
    final currentWk = ((now.day - 1) ~/ 7) + 1;

    return (buckets.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
        .where((e) => e.key <= currentWk) // hide future weeks
        .map((e) => WeeklySalePoint(
              label: 'Wk ${e.key}',
              revenue: e.value.revenue,
              orders: e.value.orders,
            ))
        .toList();
  }

  // ── Overall: Jan–Dec ──────────────────────────────────────────────────────
  List<WeeklySalePoint> _groupByMonth(List<Order> orders) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    // Pre-fill Jan–current month so the axis always shows them
    final now = DateTime.now();
    final Map<int, _Bucket> buckets = {
      for (int m = 1; m <= now.month; m++) m: _Bucket()
    };

    for (final o in orders) {
      final dt = _parseDate(o.orderDate)?.toLocal();
      if (dt == null) continue;
      buckets.putIfAbsent(dt.month, () => _Bucket());
      buckets[dt.month]!.add(_orderTotal(o));
    }

    return (buckets.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))
        .map((e) => WeeklySalePoint(
              label: monthNames[e.key - 1],
              revenue: e.value.revenue,
              orders: e.value.orders,
            ))
        .toList();
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  /// Returns the order's revenue contribution.
  /// Cancelled orders contribute $0 — they were never fulfilled.
  double _orderTotal(Order o) {
    if (o.orderStatus == 'cancelled') return 0.0;
    return (o.orderTotal?.total ?? o.totalPrice ?? 0).toDouble();
  }

  DateTime? _parseDate(dynamic raw) {
    if (raw == null) return null;
    if (raw is DateTime) return raw;
    try {
      return DateTime.parse(raw.toString());
    } catch (_) {
      return null;
    }
  }

  double get maxChartRevenue => chartPoints.isEmpty
      ? 1
      : chartPoints.map((p) => p.revenue).reduce((a, b) => a > b ? a : b);
}

// ─── Internal bucket helper ───────────────────────────────────────────────────
class _Bucket {
  double revenue = 0;
  int orders = 0;
  void add(double r) {
    revenue += r;
    orders++;
  }
}
