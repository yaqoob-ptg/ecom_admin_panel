// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import '../../../utility/constants.dart';

// class NotificationCard extends StatelessWidget {
//   final String text;
//   final Color color;
//   final int number;
//   final double percentage;

//   const NotificationCard({
//     Key? key,
//     required this.text,
//     required this.color,
//     required this.number,
//     required this.percentage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 5),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(defaultPadding * 0.75),
//                 height: 40,
//                 width: 40,
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 ),
//                 child: SvgPicture.asset(
//                   'assets/icons/notification.svg',
//                   colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             "${number}",
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           ProgressLine(
//             color: color,
//             percentage: percentage,
//           ),
//           Gap(5),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "$text",
//                 style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white70),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class ProgressLine extends StatelessWidget {
//   const ProgressLine({
//     Key? key,
//     this.color = primaryColor,
//     required this.percentage,
//   }) : super(key: key);

//   final Color? color;
//   final double? percentage;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 5,
//           decoration: BoxDecoration(
//             color: color!.withOpacity(0.1),
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//         ),
//         LayoutBuilder(
//           builder: (context, constraints) => Container(
//             width: constraints.maxWidth * (percentage! / 100),
//             height: 5,
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';

class NotificationCard extends StatelessWidget {
  final String text;
  final Color color;
  final int number;
  final double percentage;

  const NotificationCard({
    Key? key,
    required this.text,
    required this.color,
    required this.number,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconBoxSize =
        AppResponsive.value(context, mobile: 34.0, tablet: 38.0, web: 40.0);
    final double iconPad = iconBoxSize * 0.22;

    return Container(
      padding: EdgeInsets.all(AppSpacing.sm(context)),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.sm(context))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(iconPad),
            height: iconBoxSize,
            width: iconBoxSize,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset(
              'assets/icons/notification.svg',
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ),

          SizedBox(height: AppSpacing.sm(context)),

          // Count
          Text(
            '$number',
            style: TextStyle(
              fontSize: AppFontSize.xl(context),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: AppSpacing.sm(context) / 2),

          // Progress bar
          ProgressLine(color: color, percentage: percentage),

          Gap(4),

          // Label
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                  fontSize: AppFontSize.sm(context),
                ),
          ),
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final double? percentage;

  @override
  Widget build(BuildContext context) {
    const double barHeight = 5;
    const Radius barRadius = Radius.circular(10);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: barHeight,
          decoration: BoxDecoration(
            color: (color ?? primaryColor).withOpacity(0.1),
            borderRadius: const BorderRadius.all(barRadius),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * ((percentage ?? 0) / 100),
            height: barHeight,
            decoration: BoxDecoration(
              color: color ?? primaryColor,
              borderRadius: const BorderRadius.all(barRadius),
            ),
          ),
        ),
      ],
    );
  }
}
