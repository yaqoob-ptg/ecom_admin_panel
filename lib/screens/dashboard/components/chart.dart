// import 'package:admin/utility/extensions.dart';

// import '../../../core/data/data_provider.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';

// class Chart extends StatelessWidget {
//   const Chart({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: Stack(
//         children: [
//           PieChart(
//             PieChartData(
//               sectionsSpace: 0,
//               centerSpaceRadius: 70,
//               startDegreeOffset: -90,
//               sections: _buildPieChartSelectionData(context),
//             ),
//           ),
//           Positioned.fill(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: defaultPadding),
//                 Consumer<DataProvider>(
//                   builder: (context, dataProvider, child) {
//                     return Text(
//                       '${context.dataProvider.calculateOrdersWithStatus()}',
//                       style:
//                           Theme.of(context).textTheme.headlineMedium!.copyWith(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 height: 0.5,
//                               ),
//                     );
//                   },
//                 ),
//                 SizedBox(height: defaultPadding),
//                 Text("Order")
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<PieChartSectionData> _buildPieChartSelectionData(BuildContext context) {
//     final DataProvider dataProvider = Provider.of<DataProvider>(context);

//     //TODO: should complete Make this order number dynamic bt calling calculateOrdersWithStatus
//     int totalOrder = context.dataProvider.calculateOrdersWithStatus();
//     int pendingOrder =
//         context.dataProvider.calculateOrdersWithStatus(status: 'pending');
//     int processingOrder =
//         context.dataProvider.calculateOrdersWithStatus(status: 'processing');
//     int cancelledOrder =
//         context.dataProvider.calculateOrdersWithStatus(status: 'cancelled');
//     int shippedOrder =
//         context.dataProvider.calculateOrdersWithStatus(status: 'shipped');
//     int deliveredOrder =
//         context.dataProvider.calculateOrdersWithStatus(status: 'delivered');

//     List<PieChartSectionData> pieChartSelectionData = [
//       PieChartSectionData(
//         color: Color(0xFFFFCF26),
//         value: pendingOrder.toDouble(),
//         showTitle: false,
//         radius: 20,
//       ),
//       PieChartSectionData(
//         color: Color(0xFFEE2727),
//         value: cancelledOrder.toDouble(),
//         showTitle: false,
//         radius: 20,
//       ),
//       PieChartSectionData(
//         color: Color(0xFF2697FF),
//         value: shippedOrder.toDouble(),
//         showTitle: false,
//         radius: 20,
//       ),
//       PieChartSectionData(
//         color: Color(0xFF26FF31),
//         value: deliveredOrder.toDouble(),
//         showTitle: false,
//         radius: 20,
//       ),
//       PieChartSectionData(
//         color: Colors.white,
//         value: processingOrder.toDouble(),
//         showTitle: false,
//         radius: 20,
//       ),
//     ];

//     return pieChartSelectionData;
//   }
// }

//responsive
import 'package:admin/utility/extensions.dart';
import '../../../core/data/data_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Chart scales: compact on mobile, generous on web
    final double chartHeight = AppResponsive.value(
      context,
      mobile: 160.0,
      tablet: 180.0,
      web: 200.0,
    );
    final double centerRadius = AppResponsive.value(
      context,
      mobile: 52.0,
      tablet: 60.0,
      web: 70.0,
    );
    final double sliceRadius = AppResponsive.value(
      context,
      mobile: 14.0,
      tablet: 17.0,
      web: 20.0,
    );

    return SizedBox(
      height: chartHeight,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: centerRadius,
              startDegreeOffset: -90,
              sections: _buildPieChartSelectionData(context, sliceRadius),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppSpacing.sm(context)),
                Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return Text(
                      '${context.dataProvider.calculateOrdersWithStatus()}',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: AppFontSize.xl(context),
                                height: 0.5,
                              ),
                    );
                  },
                ),
                SizedBox(height: AppSpacing.sm(context)),
                Text(
                  "Order",
                  style: TextStyle(fontSize: AppFontSize.sm(context)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSelectionData(
      BuildContext context, double radius) {
    Provider.of<DataProvider>(context);

    final int pendingOrder =
        context.dataProvider.calculateOrdersWithStatus(status: 'pending');
    final int processingOrder =
        context.dataProvider.calculateOrdersWithStatus(status: 'processing');
    final int cancelledOrder =
        context.dataProvider.calculateOrdersWithStatus(status: 'cancelled');
    final int shippedOrder =
        context.dataProvider.calculateOrdersWithStatus(status: 'shipped');
    final int deliveredOrder =
        context.dataProvider.calculateOrdersWithStatus(status: 'delivered');

    return [
      PieChartSectionData(
        color: const Color(0xFFFFCF26),
        value: pendingOrder.toDouble(),
        showTitle: false,
        radius: radius,
      ),
      PieChartSectionData(
        color: const Color(0xFFEE2727),
        value: cancelledOrder.toDouble(),
        showTitle: false,
        radius: radius,
      ),
      PieChartSectionData(
        color: const Color(0xFF2697FF),
        value: shippedOrder.toDouble(),
        showTitle: false,
        radius: radius,
      ),
      PieChartSectionData(
        color: const Color(0xFF26FF31),
        value: deliveredOrder.toDouble(),
        showTitle: false,
        radius: radius,
      ),
      PieChartSectionData(
        color: Colors.white,
        value: processingOrder.toDouble(),
        showTitle: false,
        radius: radius,
      ),
    ];
  }
}
