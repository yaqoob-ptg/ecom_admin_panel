// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../utility/constants.dart';
// import '../../../models/product_summery_info.dart';

// class ProductSummeryCard extends StatelessWidget {
//   const ProductSummeryCard({
//     Key? key,
//     required this.info, required this.onTap,
//   }) : super(key: key);

//   final ProductSummeryInfo info;
//   final Function(String?) onTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//         onTap(info.title);
//       },
//       child: Container(
//         padding: EdgeInsets.all(defaultPadding),
//         decoration: BoxDecoration(
//           color: secondaryColor,
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(defaultPadding * 0.75),
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     color: info.color!.withOpacity(0.1),
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: SvgPicture.asset(
//                     info.svgSrc!,
//                     colorFilter: ColorFilter.mode(
//                         info.color ?? Colors.black, BlendMode.srcIn),
//                   ),
//                 ),
//                 Icon(Icons.more_vert, color: Colors.white54)
//               ],
//             ),
//             Text(
//               info.title!,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             ProgressLine(
//               color: info.color,
//               percentage: info.percentage,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "${info.productsCount} Product",
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodySmall!
//                       .copyWith(color: Colors.white70),
//                 ),
//               ],
//             )
//           ],
//         ),
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

//responsive
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../models/product_summery_info.dart';

class ProductSummeryCard extends StatelessWidget {
  const ProductSummeryCard({
    Key? key,
    required this.info,
    required this.onTap,
  }) : super(key: key);

  final ProductSummeryInfo info;
  final Function(String?) onTap;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final padding = AppSpacing.cardPadding(context);

    // Icon container scales: small on mobile, larger on web
    final double iconBoxSize = () {
      if (w < AppBreakpoints.mobileS) return 32.0;
      if (w < AppBreakpoints.mobileL) return 36.0;
      if (w < AppBreakpoints.tablet) return 38.0;
      return 42.0;
    }();

    final double iconPadding = iconBoxSize * 0.22;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md(context)),
      onTap: () => onTap(info.title),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(AppRadius.md(context)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ── Top row: icon + overflow menu ───────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(iconPadding),
                  height: iconBoxSize,
                  width: iconBoxSize,
                  decoration: BoxDecoration(
                    color: (info.color ?? Colors.blue).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm(context)),
                  ),
                  child: SvgPicture.asset(
                    info.svgSrc!,
                    colorFilter: ColorFilter.mode(
                      info.color ?? Colors.blue,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.white54,
                  size: AppIconSize.sm(context),
                ),
              ],
            ),

            // ── Title ────────────────────────────────────────────────
            Text(
              info.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: AppFontSize.body(context),
                color: Colors.white,
              ),
            ),

            // ── Progress bar ─────────────────────────────────────────
            ProgressLine(
              color: info.color,
              percentage: info.percentage,
            ),

            // ── Product count ────────────────────────────────────────
            Text(
              "${info.productsCount} Product",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white70,
                    fontSize: AppFontSize.sm(context),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  PROGRESS LINE  (unchanged logic, just consistent border radius)
// ─────────────────────────────────────────────────────────────────────────────
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
        // Track
        Container(
          width: double.infinity,
          height: barHeight,
          decoration: BoxDecoration(
            color: (color ?? primaryColor).withOpacity(0.1),
            borderRadius: const BorderRadius.all(barRadius),
          ),
        ),
        // Fill
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
