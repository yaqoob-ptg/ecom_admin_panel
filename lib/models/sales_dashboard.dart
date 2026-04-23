// lib/models/sales_dashboard.dart

class SalesSummary {
  final double totalRevenue;
  final int totalOrders;
  final double todayRevenue;
  final int todayOrders;
  final int pendingOrders;
  final int shippedOrders;
  final int deliveredOrders;
  final int cancelledOrders;

  SalesSummary({
    this.totalRevenue = 0,
    this.totalOrders = 0,
    this.todayRevenue = 0,
    this.todayOrders = 0,
    this.pendingOrders = 0,
    this.shippedOrders = 0,
    this.deliveredOrders = 0,
    this.cancelledOrders = 0,
  });
}

class AdminSalesStat {
  final String adminId;
  final String adminName;
  final String adminEmail;
  final double totalSales;
  final int orderCount;
  final int pendingOrders;
  final int shippedOrders;
  final int deliveredOrders;
  final int cancelledOrders;

  AdminSalesStat({
    required this.adminId,
    required this.adminName,
    required this.adminEmail,
    required this.totalSales,
    required this.orderCount,
    required this.pendingOrders,
    required this.shippedOrders,
    required this.deliveredOrders,
    required this.cancelledOrders,
  });

  factory AdminSalesStat.fromJson(Map<String, dynamic> json) {
    return AdminSalesStat(
      adminId: json['adminId'] ?? '',
      adminName: json['adminName'] ?? 'Unknown',
      adminEmail: json['adminEmail'] ?? '',
      totalSales: (json['totalSales'] ?? 0).toDouble(),
      orderCount: json['orderCount'] ?? 0,
      pendingOrders: json['pendingOrders'] ?? 0,
      shippedOrders: json['shippedOrders'] ?? 0,
      deliveredOrders: json['deliveredOrders'] ?? 0,
      cancelledOrders: json['cancelledOrders'] ?? 0,
    );
  }
}

class ProductSalesStat {
  final String productId;
  final String productName;
  final String adminName;
  final int totalQuantity;
  final double totalRevenue;
  final int orderCount;

  ProductSalesStat({
    required this.productId,
    required this.productName,
    required this.adminName,
    required this.totalQuantity,
    required this.totalRevenue,
    required this.orderCount,
  });

  factory ProductSalesStat.fromJson(Map<String, dynamic> json) {
    return ProductSalesStat(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? 'Unknown',
      adminName: json['adminName'] ?? 'Unknown',
      totalQuantity: json['totalQuantity'] ?? 0,
      totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
      orderCount: json['orderCount'] ?? 0,
    );
  }
}

class WeeklySalePoint {
  final String label; // e.g. "Mon", "Tue" or "Week 1"
  final double revenue;
  final int orders;

  WeeklySalePoint({
    required this.label,
    required this.revenue,
    required this.orders,
  });

  factory WeeklySalePoint.fromJson(Map<String, dynamic> json) {
    return WeeklySalePoint(
      label: json['label'] ?? '',
      revenue: (json['revenue'] ?? 0).toDouble(),
      orders: json['orders'] ?? 0,
    );
  }
}

enum SalesPeriod { today, week, month, overall }

extension SalesPeriodLabel on SalesPeriod {
  String get label {
    switch (this) {
      case SalesPeriod.today:   return 'Today';
      case SalesPeriod.week:    return 'This Week';
      case SalesPeriod.month:   return 'This Month';
      case SalesPeriod.overall: return 'Overall';
    }
  }
  String get queryParam {
    switch (this) {
      case SalesPeriod.today:   return 'today';
      case SalesPeriod.week:    return 'week';
      case SalesPeriod.month:   return 'month';
      case SalesPeriod.overall: return 'overall';
    }
  }
}
