// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class CategoryImageCard extends StatelessWidget {
//   final String labelText;
//   final String? imageUrlForUpdateImage;
//   final File? imageFile;
//   final VoidCallback onTap;

//   const CategoryImageCard({
//     super.key,
//     required this.labelText,
//     this.imageFile,
//     required this.onTap,
//     this.imageUrlForUpdateImage,
//   });

//   @override
//   Widget build(BuildContext context) {
//     print(imageFile);
//     var size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         child: Container(
//           height: 130,
//           width: size.width * 0.12,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: Colors.grey[200],
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               if (imageFile != null)
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: kIsWeb
//                       ? Image.network(
//                           imageFile?.path ?? '',
//                           width: double.infinity,
//                           height: 80,
//                           fit: BoxFit.cover,
//                         )
//                       : Image.file(
//                           imageFile!,
//                           width: double.infinity,
//                           height: 80,
//                           fit: BoxFit.cover,
//                         ),
//                 )
//               else if (imageUrlForUpdateImage != null)
//                 ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       imageUrlForUpdateImage ?? '',
//                       width: double.infinity,
//                       height: 80,
//                       fit: BoxFit.cover,
//                     ))
//               else
//                 Icon(Icons.camera_alt, size: 50, color: Colors.grey[600]),
//               SizedBox(height: 8),
//               Text(
//                 labelText,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utility/responsive_constants.dart';

class CategoryImageCard extends StatelessWidget {
  final String labelText;
  final String? imageUrlForUpdateImage;
  final File? imageFile;
  final VoidCallback onTap;

  const CategoryImageCard({
    super.key,
    required this.labelText,
    this.imageFile,
    required this.onTap,
    this.imageUrlForUpdateImage,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // ── Card dimensions — mirrors ProductImageCard sizing ─────────────────
    // Category form is simpler (1 image card) so we can afford to be larger
    final double cardWidth = () {
      if (w < AppBreakpoints.mobileS) return w * 0.32;
      if (w < AppBreakpoints.mobileL) return w * 0.30;
      if (w < AppBreakpoints.tablet) return 140.0;
      if (w < AppBreakpoints.webS) return 130.0;
      return 160.0;
    }();

    final double cardHeight = cardWidth * 1.1; // consistent portrait ratio
    const double labelAreaHeight = 28.0; // fixed label strip

    final double iconSize = AppResponsive.value(
      context,
      mobile: 32.0,
      tablet: 40.0,
      web: 48.0,
    );

    final double labelFontSize = AppFontSize.sm(context);
    final double radius = AppRadius.sm(context);
    final bool hasImage = imageFile != null || imageUrlForUpdateImage != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight, // always fixed — no overflow
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: hasImage ? Colors.grey.shade400 : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Image / placeholder — Expanded so it never overflows ───
              Expanded(child: _buildContent(iconSize)),

              // ── Label strip — fixed height ─────────────────────────────
              Container(
                height: labelAreaHeight,
                color: Colors.grey[100],
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 6),
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
    );
  }

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
      child: Icon(Icons.camera_alt_outlined,
          size: iconSize, color: Colors.grey[500]),
    );
  }
}
