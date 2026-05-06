// lib/screens/superAdmin/sales_dashboard/components/today_sales.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utility/constants.dart';
import '../../../../utility/responsive.dart';
import '../provider/sales_dashboard_provider.dart';

class TodaySalesCard extends StatelessWidget {
  const TodaySalesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesDashboardProvider>(
      builder: (_, prov, __) {
        final s = prov.summary;
        final isMobile = Responsive.isMobile(context);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A1D2E), Color(0xFF252840)],
            ),
            border: Border.all(
              color: const Color(0xFF667EEA).withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.today_rounded,
                        color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Text("Today's Sales",
                      style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  Text(
                    _dateLabel(),
                    style: const TextStyle(fontSize: 11, color: Colors.white38),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _BigStat(
                            'Rs. ${_fmt(s.todayRevenue)}', 'Revenue Today'),
                        const SizedBox(height: 16),
                        Row(children: [
                          Expanded(
                              child: _SmallStat('${s.todayOrders}', 'Orders',
                                  const Color(0xFF667EEA))),
                          Expanded(
                              child: _SmallStat('${s.pendingOrders}', 'Pending',
                                  const Color(0xFFFFC107))),
                          Expanded(
                              child: _SmallStat('${s.deliveredOrders}',
                                  'Delivered', const Color(0xFF4CAF50))),
                        ]),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: _BigStat('Rs. ${_fmt(s.todayRevenue)}',
                                'Revenue Today')),
                        const SizedBox(width: 20),
                        Expanded(
                            child: _SmallStat('${s.todayOrders}',
                                'Total Orders', const Color(0xFF667EEA))),
                        const SizedBox(width: 10),
                        Expanded(
                            child: _SmallStat('${s.pendingOrders}', 'Pending',
                                const Color(0xFFFFC107))),
                        const SizedBox(width: 10),
                        Expanded(
                            child: _SmallStat('${s.deliveredOrders}',
                                'Delivered', const Color(0xFF4CAF50))),
                        const SizedBox(width: 10),
                        Expanded(
                            child: _SmallStat('${s.cancelledOrders}',
                                'Cancelled', const Color(0xFFFF6B6B))),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  String _dateLabel() {
    final now = DateTime.now();
    const months = [
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
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  String _fmt(double v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}K';
    return v.toStringAsFixed(2);
  }
}

class _BigStat extends StatelessWidget {
  final String value;
  final String label;
  const _BigStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5)),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.white54)),
      ],
    );
  }
}

class _SmallStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _SmallStat(this.value, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(fontSize: 10, color: Colors.white54)),
        ],
      ),
    );
  }
}
