// import 'package:admin/utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../core/data/data_provider.dart';
// import '../../../models/product_summery_info.dart';
// import '../../../utility/constants.dart';
// import 'product_summery_card.dart';

// class ProductSummerySection extends StatelessWidget {
//   const ProductSummerySection({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;

//     return Consumer<DataProvider>(
//       builder: (context, dataProvider, _) {
//         int totalProduct = 1;
//         totalProduct =
//             context.dataProvider.calculateProductWithQuantity(quantity: null);
//         int outOfStockProduct =
//             context.dataProvider.calculateProductWithQuantity(quantity: 0);
//         int limitedStockProduct =
//             context.dataProvider.calculateProductWithQuantity(quantity: 5);
//         int otherStockProduct =
//             totalProduct - outOfStockProduct - limitedStockProduct;

//         List<ProductSummeryInfo> productSummeryItems = [
//           ProductSummeryInfo(
//             title: "All Product",
//             productsCount: totalProduct,
//             svgSrc: "assets/icons/Product.svg",
//             color: primaryColor,
//             percentage: 100,
//           ),
//           ProductSummeryInfo(
//             title: "Out of Stock",
//             productsCount: outOfStockProduct,
//             svgSrc: "assets/icons/Product2.svg",
//             color: Color(0xFFEA3829),
//             percentage: totalProduct != 0
//                 ? (outOfStockProduct / totalProduct) * 100
//                 : 0,
//           ),
//           ProductSummeryInfo(
//             title: "Limited Stock",
//             productsCount: limitedStockProduct,
//             svgSrc: "assets/icons/Product3.svg",
//             color: Color(0xFFECBE23),
//             percentage: totalProduct != 0
//                 ? (limitedStockProduct / totalProduct) * 100
//                 : 0,
//           ),
//           ProductSummeryInfo(
//             title: "Other Stock",
//             productsCount: otherStockProduct,
//             svgSrc: "assets/icons/Product4.svg",
//             color: Color(0xFF47e228),
//             percentage: totalProduct != 0
//                 ? (otherStockProduct / totalProduct) * 100
//                 : 0,
//           ),
//         ];

//         return Column(
//           children: [
//             GridView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: productSummeryItems.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 crossAxisSpacing: defaultPadding,
//                 mainAxisSpacing: defaultPadding,
//                 childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
//               ),
//               itemBuilder: (context, index) => ProductSummeryCard(
//                 info: productSummeryItems[index],
//                 onTap: (productType) {
//                   context.dataProvider
//                       .filterProductsByQuantity(productType ?? '');
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

//responsive code
import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/product_summery_info.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import 'product_summery_card.dart';

class ProductSummerySection extends StatelessWidget {
  const ProductSummerySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, _) {
        final int totalProduct =
            context.dataProvider.calculateProductWithQuantity(quantity: null);
        final int outOfStockProduct =
            context.dataProvider.calculateProductWithQuantity(quantity: 0);
        final int limitedStockProduct =
            context.dataProvider.calculateProductWithQuantity(quantity: 5);
        final int otherStockProduct =
            totalProduct - outOfStockProduct - limitedStockProduct;

        final List<ProductSummeryInfo> items = [
          ProductSummeryInfo(
            title: "All Product",
            productsCount: totalProduct,
            svgSrc: "assets/icons/Product.svg",
            color: primaryColor,
            percentage: 100,
          ),
          ProductSummeryInfo(
            title: "Out of Stock",
            productsCount: outOfStockProduct,
            svgSrc: "assets/icons/Product2.svg",
            color: const Color(0xFFEA3829),
            percentage: totalProduct != 0
                ? (outOfStockProduct / totalProduct) * 100
                : 0,
          ),
          ProductSummeryInfo(
            title: "Limited Stock",
            productsCount: limitedStockProduct,
            svgSrc: "assets/icons/Product3.svg",
            color: const Color(0xFFECBE23),
            percentage: totalProduct != 0
                ? (limitedStockProduct / totalProduct) * 100
                : 0,
          ),
          ProductSummeryInfo(
            title: "Other Stock",
            productsCount: otherStockProduct,
            svgSrc: "assets/icons/Product4.svg",
            color: const Color(0xFF47e228),
            percentage: totalProduct != 0
                ? (otherStockProduct / totalProduct) * 100
                : 0,
          ),
        ];

        final w = MediaQuery.of(context).size.width;

        // ── Grid column count ──────────────────────────────────────────────
        // Mobile S  (<480)  → 1 col
        // Mobile L  (<768)  → 2 cols
        // Tablet    (<1024) → 2 cols  (cards have more breathing room)
        // Web S     (<1280) → 4 cols
        // Web L     (1280+) → 4 cols
        final int crossAxisCount = () {
          if (w < AppBreakpoints.mobileS) return 2;
          if (w < AppBreakpoints.tablet) return 2; // covers mobileL + tablet
          return 4;
        }();

        // ── Card aspect ratio ─────────────────────────────────────────────
        // Taller on small screens (content needs more vertical room),
        // wider on large screens.
        final double aspectRatio = () {
          if (w < AppBreakpoints.mobileS) return 1.6; // 1-col → wide card
          if (w < AppBreakpoints.mobileL) return 1.3; // 2-col mobile
          if (w < AppBreakpoints.tablet) return 1.7; // 2-col tablet
          if (w < AppBreakpoints.webS) return 0.9; // 4-col web S
          return w < 1400 ? 1.1 : 1.4; // 4-col web L (original logic)
        }();

        final double spacing = AppSpacing.itemGap(context);

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) => ProductSummeryCard(
            info: items[index],
            onTap: (productType) {
              context.dataProvider.filterProductsByQuantity(productType ?? '');
            },
          ),
        );
      },
    );
  }
}
