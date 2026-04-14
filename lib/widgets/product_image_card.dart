// // import 'dart:io';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';

// // class ProductImageCard extends StatelessWidget {
// //   final String labelText;
// //   final String? imageUrlForUpdateImage;
// //   final File? imageFile;
// //   final VoidCallback onTap;
// //   final VoidCallback? onRemoveImage;

// //   const ProductImageCard({
// //     Key? key,
// //     required this.labelText,
// //     this.imageFile,
// //     required this.onTap,
// //     this.imageUrlForUpdateImage,
// //     this.onRemoveImage,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     var size = MediaQuery.of(context).size;
// //     return Stack(
// //       alignment: Alignment.topRight,
// //       children: [
// //         Card(
// //           child: Container(
// //             height: 130,
// //             width: size.width * 0.12,
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(8),
// //               color: Colors.grey[200],
// //             ),
// //             child: GestureDetector(
// //               onTap: onTap,
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: <Widget>[
// //                   if (imageFile != null)
// //                     ClipRRect(
// //                       borderRadius: BorderRadius.circular(8),
// //                       child: kIsWeb
// //                           ? Image.network(
// //                         imageFile?.path ?? '',
// //                         width: double.infinity,
// //                         height: 80,
// //                         fit: BoxFit.scaleDown,
// //                       )
// //                           : Image.file(
// //                         imageFile!,
// //                         width: double.infinity,
// //                         height: 80,
// //                         fit: BoxFit.scaleDown,
// //                       ),
// //                     )
// //                   else if (imageUrlForUpdateImage != null)
// //                     ClipRRect(
// //                       borderRadius: BorderRadius.circular(8),
// //                       child: Image.network(
// //                         imageUrlForUpdateImage ?? '',
// //                         width: double.infinity,
// //                         height: 80,
// //                         fit: BoxFit.scaleDown,
// //                       ),
// //                     )
// //                   else
// //                     Icon(Icons.camera_alt, size: 50, color: Colors.grey[600]),
// //                   SizedBox(height: 8),
// //                   Text(
// //                     labelText,
// //                     style: TextStyle(
// //                       fontSize: 14,
// //                       color: Colors.grey[800],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //         if ( imageFile != null && onRemoveImage != null)
// //           Positioned(
// //             top: 0,
// //             right: 0,
// //             child: IconButton(
// //               icon: Icon(Icons.close,color: Colors.red,),
// //               onPressed: onRemoveImage,
// //             ),
// //           ),
// //       ],
// //     );
// //   }
// // }

// //responsive
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import '../utility/responsive_constants.dart';

// class ProductImageCard extends StatelessWidget {
//   final String labelText;
//   final String? imageUrlForUpdateImage;
//   final File? imageFile;
//   final VoidCallback onTap;
//   final VoidCallback? onRemoveImage;

//   const ProductImageCard({
//     Key? key,
//     required this.labelText,
//     this.imageFile,
//     required this.onTap,
//     this.imageUrlForUpdateImage,
//     this.onRemoveImage,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;

//     // ── Card dimensions ────────────────────────────────────────────────────
//     // On web the dialog is wide enough for 5 cards in a row at ~12% each.
//     // On tablet the dialog is ~85% wide so each card gets ~17% → cap at 110.
//     // On mobile the form stacks cards in a Wrap(3-per-row) so each is ~30%
//     // of the dialog width — we just honour the SizedBox passed by the parent
//     // and let height match proportionally via a fixed ratio.
//     final double cardWidth = () {
//       if (w < AppBreakpoints.mobileS) return w * 0.26;
//       if (w < AppBreakpoints.mobileL) return w * 0.26;
//       if (w < AppBreakpoints.tablet) return 100.0;
//       if (w < AppBreakpoints.webS) return 110.0;
//       return w * 0.10; // web: roughly size.width * 0.12 feel inside dialog
//     }();

//     // Height scales with width to keep a consistent portrait ratio
//     final double cardHeight = cardWidth * 1.15;

//     // Image preview height (portion of card height)
//     final double imageHeight = cardHeight * 0.62;

//     // Icon size for the camera placeholder
//     final double iconSize = AppResponsive.value(
//       context,
//       mobile: 32.0,
//       tablet: 40.0,
//       web: 50.0,
//     );

//     // Label font size
//     final double labelSize = AppFontSize.xs(context);

//     // Close button icon size
//     final double closeIconSize = AppResponsive.value(
//       context,
//       mobile: 16.0,
//       tablet: 18.0,
//       web: 20.0,
//     );

//     final bool hasImage = imageFile != null || imageUrlForUpdateImage != null;

//     return Stack(
//       alignment: Alignment.topRight,
//       clipBehavior: Clip.none,
//       children: [
//         // ── Card ──────────────────────────────────────────────────────────
//         Card(
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppRadius.sm(context)),
//           ),
//           child: GestureDetector(
//             onTap: onTap,
//             child: Container(
//               height: cardHeight,
//               width: cardWidth,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(AppRadius.sm(context)),
//                 color: Colors.grey[200],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // ── Image preview ──────────────────────────────────────
//                   if (imageFile != null)
//                     _ImagePreview(
//                       child: kIsWeb
//                           ? Image.network(
//                               imageFile?.path ?? '',
//                               width: double.infinity,
//                               height: imageHeight,
//                               fit: BoxFit.scaleDown,
//                             )
//                           : Image.file(
//                               imageFile!,
//                               width: double.infinity,
//                               height: imageHeight,
//                               fit: BoxFit.scaleDown,
//                             ),
//                       radius: AppRadius.sm(context),
//                     )
//                   else if (imageUrlForUpdateImage != null)
//                     _ImagePreview(
//                       child: Image.network(
//                         imageUrlForUpdateImage ?? '',
//                         width: double.infinity,
//                         height: imageHeight,
//                         fit: BoxFit.scaleDown,
//                         errorBuilder: (_, __, ___) => Icon(
//                           Icons.broken_image,
//                           size: iconSize,
//                           color: Colors.grey[500],
//                         ),
//                       ),
//                       radius: AppRadius.sm(context),
//                     )
//                   else
//                     Icon(
//                       Icons.camera_alt,
//                       size: iconSize,
//                       color: Colors.grey[600],
//                     ),

//                   const SizedBox(height: 6),

//                   // ── Label ──────────────────────────────────────────────
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4),
//                     child: Text(
//                       labelText,
//                       textAlign: TextAlign.center,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: labelSize,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),

//         // ── Remove button (only when an image is selected) ────────────────
//         if (imageFile != null && onRemoveImage != null)
//           Positioned(
//             top: -6,
//             right: -6,
//             child: GestureDetector(
//               onTap: onRemoveImage,
//               child: Container(
//                 padding: const EdgeInsets.all(2),
//                 decoration: const BoxDecoration(
//                   color: Colors.red,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.close,
//                   size: closeIconSize,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  HELPER — clipped image preview
// // ─────────────────────────────────────────────────────────────────────────────
// class _ImagePreview extends StatelessWidget {
//   final Widget child;
//   final double radius;

//   const _ImagePreview({required this.child, required this.radius});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(radius),
//       child: child,
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utility/responsive_constants.dart';

class ProductImageCard extends StatelessWidget {
  final String labelText;
  final String? imageUrlForUpdateImage;
  final File? imageFile;
  final VoidCallback onTap;
  final VoidCallback? onRemoveImage;

  const ProductImageCard({
    Key? key,
    required this.labelText,
    this.imageFile,
    required this.onTap,
    this.imageUrlForUpdateImage,
    this.onRemoveImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // ── Fixed card width per breakpoint ───────────────────────────────────
    // Parent Wrap controls how many fit per row; here we just define a stable
    // width. Height is derived via a fixed aspect ratio so ALL cards — whether
    // empty or showing an image — are ALWAYS the same size.
    final double cardWidth = () {
      if (w < AppBreakpoints.mobileS) return w * 0.25;
      if (w < AppBreakpoints.mobileL) return w * 0.24;
      if (w < AppBreakpoints.tablet) return 100.0;
      if (w < AppBreakpoints.webS) return 110.0;
      return 120.0;
    }();

    // Aspect ratio 1:1.1 — slightly tall square, consistent regardless of content
    final double cardHeight = cardWidth * 1.1;

    // Fixed label strip height at the bottom
    const double labelAreaHeight = 26.0;

    // Camera icon size for the placeholder state
    final double iconSize = AppResponsive.value(
      context,
      mobile: 26.0,
      tablet: 34.0,
      web: 42.0,
    );

    final double labelFontSize = AppFontSize.xs(context);

    final double closeIconSize = AppResponsive.value(
      context,
      mobile: 13.0,
      tablet: 15.0,
      web: 17.0,
    );

    final double radius = AppRadius.sm(context);
    final bool hasImage = imageFile != null || imageUrlForUpdateImage != null;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ── Card ──────────────────────────────────────────────────────────
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: cardWidth,
            height: cardHeight, // always fixed — no overflow possible
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: hasImage ? Colors.grey.shade400 : Colors.grey.shade300,
                width: 1,
              ),
            ),
            // ClipRRect keeps image within rounded corners
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Image / placeholder — Expanded so it fills leftover ─
                  Expanded(
                    child: _buildContent(iconSize),
                  ),

                  // ── Label strip — fixed height, never pushed out ────────
                  Container(
                    height: labelAreaHeight,
                    color: Colors.grey[100],
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      labelText,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: labelFontSize,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Remove button ─────────────────────────────────────────────────
        if (imageFile != null && onRemoveImage != null)
          Positioned(
            top: -5,
            right: -5,
            child: GestureDetector(
              onTap: onRemoveImage,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child:
                    Icon(Icons.close, size: closeIconSize, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  // ── Content of the image area ──────────────────────────────────────────────
  // SizedBox.expand + BoxFit.cover fills the Expanded parent exactly.
  // No explicit height → no overflow. The Expanded parent clamps it.
  Widget _buildContent(double iconSize) {
    if (imageFile != null) {
      return SizedBox.expand(
        child: kIsWeb
            ? Image.network(imageFile?.path ?? '', fit: BoxFit.cover)
            : Image.file(imageFile!, fit: BoxFit.cover),
      );
    }

    if (imageUrlForUpdateImage != null) {
      return SizedBox.expand(
        child: Image.network(
          imageUrlForUpdateImage ?? '',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder(iconSize),
        ),
      );
    }

    return _placeholder(iconSize);
  }

  Widget _placeholder(double iconSize) {
    return Center(
      child: Icon(
        Icons.camera_alt_outlined,
        size: iconSize,
        color: Colors.grey[500],
      ),
    );
  }
}
