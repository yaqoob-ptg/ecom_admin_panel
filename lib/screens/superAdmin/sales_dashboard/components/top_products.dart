// lib/screens/superAdmin/sales_dashboard/components/top_products.dart

import 'package:admin/models/sales_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utility/constants.dart';
import '../../../../utility/responsive.dart';
import '../provider/sales_dashboard_provider.dart';

class TopProductsSection extends StatelessWidget {
  const TopProductsSection({Key? key}) : super(key: key);

  static const _accent = Color(0xFF667EEA);

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesDashboardProvider>(
      builder: (_, prov, __) {
        final products = prov.topProducts;
        final maxQty = products.isEmpty
            ? 1
            : products
                .map((p) => p.totalQuantity)
                .reduce((a, b) => a > b ? a : b);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Top Selling Products',
                      style: Theme.of(context).textTheme.titleMedium),
                  Text('${products.length} products',
                      style:
                          const TextStyle(fontSize: 11, color: Colors.white38)),
                ],
              ),
              const SizedBox(height: 16),
              if (products.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text('No data',
                        style: TextStyle(color: Colors.white38)),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: Colors.white12, height: 16),
                  itemBuilder: (_, i) {
                    final p = products[i];
                    final ratio = maxQty == 0
                        ? 0.0
                        : (p.totalQuantity / maxQty).clamp(0.0, 1.0);

                    return _ProductRow(
                      rank: i + 1,
                      product: p,
                      ratio: ratio,
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ProductRow extends StatelessWidget {
  final int rank;
  final ProductSalesStat product;
  final double ratio;

  const _ProductRow({
    required this.rank,
    required this.product,
    required this.ratio,
  });

  static const _colors = [
    Color(0xFFFFD700),
    Color(0xFFC0C0C0),
    Color(0xFFCD7F32),
    Color(0xFF667EEA),
    Color(0xFF4CAF50),
  ];

  @override
  Widget build(BuildContext context) {
    final color =
        _colors[rank > _colors.length ? _colors.length - 1 : rank - 1];
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Rank badge
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.5)),
              ),
              child: Center(
                child: Text(
                  '$rank',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold, color: color),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Product info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'by ${product.adminName}',
                    style: const TextStyle(fontSize: 10, color: Colors.white38),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Stats
            if (!isMobile)
              Row(children: [
                _chip('${product.totalQuantity} units', Colors.white54),
                const SizedBox(width: 8),
                _chip('Rs. ${_fmt(product.totalRevenue)}',
                    const Color(0xFF4CAF50)),
              ])
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${product.totalQuantity} units',
                      style:
                          const TextStyle(fontSize: 11, color: Colors.white54)),
                  Text('Rs. ${_fmt(product.totalRevenue)}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50))),
                ],
              ),
          ],
        ),
        const SizedBox(height: 8),
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: ratio,
            backgroundColor: Colors.white.withOpacity(0.06),
            valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(0.7)),
            minHeight: 5,
          ),
        ),
      ],
    );
  }

  Widget _chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600, color: color)),
    );
  }

  String _fmt(double v) {
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
    return v.toStringAsFixed(2);
  }
}
