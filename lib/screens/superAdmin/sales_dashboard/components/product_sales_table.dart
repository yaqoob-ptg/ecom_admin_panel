// lib/screens/superAdmin/sales_dashboard/components/product_sales_table.dart

import 'package:admin/models/sales_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utility/constants.dart';
import '../../../../utility/responsive.dart';
import '../provider/sales_dashboard_provider.dart';

class ProductSalesTable extends StatefulWidget {
  const ProductSalesTable({Key? key}) : super(key: key);

  @override
  State<ProductSalesTable> createState() => _ProductSalesTableState();
}

class _ProductSalesTableState extends State<ProductSalesTable> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _keyword = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesDashboardProvider>(
      builder: (_, prov, __) {
        final all = prov.allProductSales;
        final filtered = _keyword.isEmpty
            ? all
            : all.where((p) {
                return p.productName.toLowerCase().contains(_keyword) ||
                    p.adminName.toLowerCase().contains(_keyword);
              }).toList()
          ..sort((a, b) => b.totalRevenue.compareTo(a.totalRevenue));

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: [
                  Text('Sales per Product',
                      style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(
                    width: 240,
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: (v) =>
                          setState(() => _keyword = v.toLowerCase()),
                      decoration: InputDecoration(
                        hintText: 'Search product or admin…',
                        hintStyle: const TextStyle(fontSize: 12),
                        fillColor: bgColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.search_rounded, size: 18),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (filtered.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text('No products found',
                        style: TextStyle(color: Colors.white38)),
                  ),
                )
              else
                Responsive.isMobile(context)
                    ? _MobileProductList(products: filtered)
                    : _DesktopProductTable(products: filtered),
            ],
          ),
        );
      },
    );
  }
}

// ── Desktop ─────────────────────────────────────────────────────────────────

class _DesktopProductTable extends StatelessWidget {
  final List<ProductSalesStat> products;
  const _DesktopProductTable({required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: constraints.maxWidth,
        child: DataTable(
          horizontalMargin: 8,
          columnSpacing: 12,
          dataRowMinHeight: 48,
          dataRowMaxHeight: 56,
          headingRowColor:
              WidgetStateProperty.all(Colors.white.withOpacity(0.05)),
          columns: const [
            DataColumn(label: Expanded(flex: 1, child: Text('#'))),
            DataColumn(label: Expanded(flex: 5, child: Text('Product'))),
            DataColumn(label: Expanded(flex: 3, child: Text('Admin'))),
            DataColumn(label: Expanded(flex: 2, child: Text('Qty Sold'))),
            DataColumn(label: Expanded(flex: 3, child: Text('Revenue'))),
            DataColumn(label: Expanded(flex: 2, child: Text('Orders'))),
          ],
          rows: products.asMap().entries.map((e) {
            final i = e.key + 1;
            final p = e.value;
            return DataRow(cells: [
              DataCell(Expanded(
                  flex: 1,
                  child: Text('$i',
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12)))),
              DataCell(Expanded(
                  flex: 5,
                  child: Text(p.productName,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis))),
              DataCell(Expanded(
                  flex: 3,
                  child: Text(p.adminName,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.white54),
                      overflow: TextOverflow.ellipsis))),
              DataCell(Expanded(
                  flex: 2,
                  child: Text('${p.totalQuantity}',
                      style: const TextStyle(fontSize: 13)))),
              DataCell(Expanded(
                  flex: 3,
                  child: Text('\$${_fmt(p.totalRevenue)}',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50))))),
              DataCell(Expanded(
                  flex: 2,
                  child: Text('${p.orderCount}',
                      style: const TextStyle(fontSize: 13)))),
            ]);
          }).toList(),
        ),
      );
    });
  }
}

// ── Mobile ──────────────────────────────────────────────────────────────────

class _MobileProductList extends StatelessWidget {
  final List<ProductSalesStat> products;
  const _MobileProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      separatorBuilder: (_, __) =>
          const Divider(color: Colors.white12, height: 1),
      itemBuilder: (_, i) {
        final p = products[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Text('${i + 1}.',
                  style: const TextStyle(color: Colors.white38, fontSize: 12)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.productName,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                    Text('by ${p.adminName}',
                        style: const TextStyle(
                            fontSize: 10, color: Colors.white38)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('\$${_fmt(p.totalRevenue)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                          fontSize: 13)),
                  Text('${p.totalQuantity} units',
                      style:
                          const TextStyle(fontSize: 10, color: Colors.white54)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

String _fmt(double v) {
  if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
  if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
  return v.toStringAsFixed(2);
}
