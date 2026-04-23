// lib/screens/superAdmin/sales_dashboard/sales_dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive.dart';
import 'components/admin_sales_table.dart';
import 'components/kpi_cards.dart';
import 'components/order_status_overview.dart';
import 'components/product_sales_table.dart';
import 'components/revenue_chart.dart';
import 'components/sales_header.dart';
import 'components/today_sales.dart';
import 'components/top_products.dart';
import 'provider/sales_dashboard_provider.dart';

class SalesDashboardScreen extends StatefulWidget {
  const SalesDashboardScreen({Key? key}) : super(key: key);

  @override
  State<SalesDashboardScreen> createState() => _SalesDashboardScreenState();
}

class _SalesDashboardScreenState extends State<SalesDashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SalesDashboardProvider>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<SalesDashboardProvider>(
        builder: (_, prov, __) {
          if (prov.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(defaultPadding),
            child: Responsive.isDesktop(context)
                ? _DesktopLayout()
                : _MobileLayout(),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DESKTOP  — two-column grid for wider sections
// ─────────────────────────────────────────────────────────────────────────────

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header + period filter
        const SalesHeader(),
        SizedBox(height: defaultPadding),

        // Today's sales banner
        const TodaySalesCard(),
        SizedBox(height: defaultPadding),

        // KPI cards
        const KpiCards(),
        SizedBox(height: defaultPadding),

        // Revenue chart + Order status side by side
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: const RevenueChart()),
            SizedBox(width: defaultPadding),
            Expanded(flex: 2, child: const OrderStatusOverview()),
          ],
        ),
        SizedBox(height: defaultPadding),

        // Admin sales (full width)
        const AdminSalesTable(),
        SizedBox(height: defaultPadding),

        // Top products + All product sales side by side
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: const TopProductsSection()),
            SizedBox(width: defaultPadding),
            Expanded(flex: 3, child: const ProductSalesTable()),
          ],
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  MOBILE  — single column stack
// ─────────────────────────────────────────────────────────────────────────────

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SalesHeader(),
        SizedBox(height: defaultPadding),
        const TodaySalesCard(),
        SizedBox(height: defaultPadding),
        const KpiCards(),
        SizedBox(height: defaultPadding),
        const RevenueChart(),
        SizedBox(height: defaultPadding),
        const OrderStatusOverview(),
        SizedBox(height: defaultPadding),
        const AdminSalesTable(),
        SizedBox(height: defaultPadding),
        const TopProductsSection(),
        SizedBox(height: defaultPadding),
        const ProductSalesTable(),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}
