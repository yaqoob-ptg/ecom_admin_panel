// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SnackBarHelper {
//   static void showErrorSnackBar(String message, {String title = "Error"}) {
//     final screenWidth = MediaQuery.of(Get.context!).size.width;
//     final margin = screenWidth >= 300 ? EdgeInsets.symmetric(horizontal: 300) : EdgeInsets.zero;

//     Get.snackbar(
//       title,
//       message,
//       backgroundColor: Colors.red,
//       colorText: Colors.white,
//       borderRadius: 20,
//       margin: margin,
//       duration: Duration(seconds: 3),
//       icon: Icon(Icons.error, color: Colors.white),
//     );
//   }

//   static void showSuccessSnackBar(String message, {String title = "Success"}) {
//     final screenWidth = MediaQuery.of(Get.context!).size.width;
//     final margin = screenWidth >= 300 ? EdgeInsets.symmetric(horizontal: 300) : EdgeInsets.zero;

//     Get.snackbar(
//       title,
//       message,
//       backgroundColor: Colors.green,
//       colorText: Colors.white,
//       borderRadius: 20,
//       margin: margin,
//       duration: Duration(seconds: 3),
//       icon: Icon(Icons.check_circle, color: Colors.white),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utility/responsive_constants.dart';

class SnackBarHelper {
  // ── Shared snackbar launcher ───────────────────────────────────────────────
  static void _show({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData iconData,
  }) {
    final context = Get.context;
    if (context == null) return;

    final double screenWidth = MediaQuery.of(context).size.width;

    // ── Horizontal margin ────────────────────────────────────────────────────
    // Mobile S  (<480):   no margin — snackbar takes full width
    // Mobile L  (<768):   small margin (12px) so it doesn't touch edges
    // Tablet    (<1024):  moderate margin, keeps it readable
    // Web S     (<1280):  centered with generous margin
    // Web L     (1280+):  fixed cap so it doesn't stretch too wide
    final EdgeInsets margin = () {
      if (screenWidth < AppBreakpoints.mobileS) {
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 16);
      }
      if (screenWidth < AppBreakpoints.mobileL) {
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
      }
      if (screenWidth < AppBreakpoints.tablet) {
        return const EdgeInsets.symmetric(horizontal: 40, vertical: 16);
      }
      if (screenWidth < AppBreakpoints.webS) {
        return EdgeInsets.symmetric(
          horizontal: screenWidth * 0.20,
          vertical: 16,
        );
      }
      // Web L: cap at a fixed comfortable width (max ~640px wide snackbar)
      return EdgeInsets.symmetric(
        horizontal: (screenWidth - 640) / 2,
        vertical: 16,
      );
    }();

    // ── Font size ────────────────────────────────────────────────────────────
    final double titleSize = AppResponsive.value(
      context,
      mobile: 13.0,
      tablet: 14.0,
      web: 14.0,
    );
    final double messageSize = AppResponsive.value(
      context,
      mobile: 12.0,
      tablet: 13.0,
      web: 13.0,
    );

    // ── Icon size ────────────────────────────────────────────────────────────
    final double iconSize = AppResponsive.value(
      context,
      mobile: 20.0,
      tablet: 22.0,
      web: 24.0,
    );

    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      borderRadius: 12,
      margin: margin,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
      snackPosition: SnackPosition.TOP,
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: titleSize,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white.withOpacity(0.92),
          fontSize: messageSize,
        ),
      ),
      icon: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Icon(iconData, color: Colors.white, size: iconSize),
      ),
      shouldIconPulse: false,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOut,
    );
  }

  // ── Public API ─────────────────────────────────────────────────────────────
  static void showErrorSnackBar(String message, {String title = "Error"}) {
    _show(
      title: title,
      message: message,
      backgroundColor: const Color(0xFFD32F2F),
      iconData: Icons.error_outline_rounded,
    );
  }

  static void showSuccessSnackBar(String message, {String title = "Success"}) {
    _show(
      title: title,
      message: message,
      backgroundColor: const Color(0xFF2E7D32),
      iconData: Icons.check_circle_outline_rounded,
    );
  }

  // ── Optional extras ────────────────────────────────────────────────────────
  static void showWarningSnackBar(String message, {String title = "Warning"}) {
    _show(
      title: title,
      message: message,
      backgroundColor: const Color(0xFFF57F17),
      iconData: Icons.warning_amber_rounded,
    );
  }

  static void showInfoSnackBar(String message, {String title = "Info"}) {
    _show(
      title: title,
      message: message,
      backgroundColor: const Color(0xFF1565C0),
      iconData: Icons.info_outline_rounded,
    );
  }
}
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import '../utility/responsive_constants.dart';

// // class SnackBarHelper {
// //   // ── Shared snackbar launcher ───────────────────────────────────────────────
// //   static void _show({
// //     required String title,
// //     required String message,
// //     required Color backgroundColor,
// //     required IconData iconData,
// //     Duration duration = const Duration(seconds: 3),
// //     bool withProgressIndicator = true,
// //     bool withShadow = true,
// //     AnimationType animationType = AnimationType.slideFade,
// //   }) {
// //     final context = Get.context;
// //     if (context == null) return;

// //     final double screenWidth = MediaQuery.of(context).size.width;

// //     // ── Horizontal margin ────────────────────────────────────────────────────
// //     final EdgeInsets margin = () {
// //       if (screenWidth < AppBreakpoints.mobileS) {
// //         return const EdgeInsets.symmetric(horizontal: 8, vertical: 16);
// //       }
// //       if (screenWidth < AppBreakpoints.mobileL) {
// //         return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
// //       }
// //       if (screenWidth < AppBreakpoints.tablet) {
// //         return const EdgeInsets.symmetric(horizontal: 40, vertical: 16);
// //       }
// //       if (screenWidth < AppBreakpoints.webS) {
// //         return EdgeInsets.symmetric(
// //           horizontal: screenWidth * 0.20,
// //           vertical: 16,
// //         );
// //       }
// //       return EdgeInsets.symmetric(
// //         horizontal: (screenWidth - 640) / 2,
// //         vertical: 16,
// //       );
// //     }();

// //     // ── Font size ────────────────────────────────────────────────────────────
// //     final double titleSize = AppResponsive.value(
// //       context,
// //       mobile: 13.0,
// //       tablet: 14.0,
// //       web: 14.0,
// //     );
// //     final double messageSize = AppResponsive.value(
// //       context,
// //       mobile: 12.0,
// //       tablet: 13.0,
// //       web: 13.0,
// //     );

// //     // ── Icon size ────────────────────────────────────────────────────────────
// //     final double iconSize = AppResponsive.value(
// //       context,
// //       mobile: 20.0,
// //       tablet: 22.0,
// //       web: 24.0,
// //     );

// //     // Get custom animation curves based on type
// //     final animationConfig = _getAnimationConfig(animationType);

// //     Get.snackbar(
// //       title,
// //       message,
// //       backgroundColor: backgroundColor,
// //       colorText: Colors.white,
// //       borderRadius: 16,
// //       margin: margin,
// //       duration: duration,
// //       animationDuration: const Duration(milliseconds: 500),
// //       snackPosition: SnackPosition.TOP,
// //       snackStyle: SnackStyle.FLOATING,

// //       // Enhanced shadow
// //       boxShadows: withShadow
// //           ? [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.2),
// //                 blurRadius: 12,
// //                 offset: const Offset(0, 4),
// //                 spreadRadius: 2,
// //               ),
// //             ]
// //           : null,

// //       // Title text with animation
// //       titleText: _buildAnimatedTitle(title, titleSize, animationType),

// //       // Message text with animation
// //       messageText: _buildAnimatedMessage(message, messageSize),

// //       // Animated icon
// //       icon: _buildAnimatedIcon(iconData, iconSize, animationType),

// //       // Progress indicator - using a TextButton that contains the progress bar
// //       mainButton: withProgressIndicator ? _buildProgressButton(duration) : null,

// //       shouldIconPulse: true,
// //       isDismissible: true,
// //       forwardAnimationCurve: animationConfig.forwardCurve,
// //       reverseAnimationCurve: animationConfig.reverseCurve,

// //       // Add border for extra visual flair
// //       borderColor: Colors.white.withOpacity(0.3),
// //       borderWidth: 1,
// //     );
// //   }

// //   // Helper method for animation configuration
// //   static _AnimationConfig _getAnimationConfig(AnimationType type) {
// //     switch (type) {
// //       case AnimationType.slideFade:
// //         return _AnimationConfig(
// //           forwardCurve: Curves.easeOutCubic,
// //           reverseCurve: Curves.easeInCubic,
// //         );
// //       case AnimationType.scale:
// //         return _AnimationConfig(
// //           forwardCurve: Curves.elasticOut,
// //           reverseCurve: Curves.easeInBack,
// //         );
// //       case AnimationType.rotate:
// //         return _AnimationConfig(
// //           forwardCurve: Curves.easeOutBack,
// //           reverseCurve: Curves.easeInCubic,
// //         );
// //       case AnimationType.bounce:
// //         return _AnimationConfig(
// //           forwardCurve: Curves.bounceOut,
// //           reverseCurve: Curves.easeIn,
// //         );
// //     }
// //   }

// //   // Animated title widget
// //   static Widget _buildAnimatedTitle(
// //       String title, double fontSize, AnimationType animationType) {
// //     return TweenAnimationBuilder<double>(
// //       tween: Tween<double>(begin: 0, end: 1),
// //       duration: const Duration(milliseconds: 400),
// //       builder: (context, value, child) {
// //         Widget animatedChild = Opacity(
// //           opacity: value,
// //           child: Transform.translate(
// //             offset: Offset(0, 20 * (1 - value)),
// //             child: Text(
// //               title,
// //               style: TextStyle(
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.w600,
// //                 fontSize: fontSize,
// //                 letterSpacing: 0.5,
// //               ),
// //             ),
// //           ),
// //         );

// //         // Add bounce effect for bounce animation type
// //         if (animationType == AnimationType.bounce) {
// //           animatedChild = Transform.scale(
// //             scale: 0.5 + (value * 0.5),
// //             child: animatedChild,
// //           );
// //         }

// //         return animatedChild;
// //       },
// //     );
// //   }

// //   // Animated message widget
// //   static Widget _buildAnimatedMessage(String message, double fontSize) {
// //     return TweenAnimationBuilder<double>(
// //       tween: Tween<double>(begin: 0, end: 1),
// //       duration: const Duration(milliseconds: 500),
// //       builder: (context, value, child) {
// //         return Opacity(
// //           opacity: value,
// //           child: Transform.translate(
// //             offset: Offset(0, 15 * (1 - value)),
// //             child: Text(
// //               message,
// //               style: TextStyle(
// //                 color: Colors.white.withOpacity(0.92),
// //                 fontSize: fontSize,
// //                 height: 1.4,
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   // Animated icon widget
// //   static Widget _buildAnimatedIcon(
// //       IconData iconData, double iconSize, AnimationType animationType) {
// //     return TweenAnimationBuilder<double>(
// //       tween: Tween<double>(begin: 0, end: 1),
// //       duration: const Duration(milliseconds: 600),
// //       curve: animationType == AnimationType.bounce
// //           ? Curves.elasticOut
// //           : Curves.easeOutBack,
// //       builder: (context, scale, child) {
// //         Widget icon = Transform.scale(
// //           scale: scale,
// //           child: Container(
// //             padding: const EdgeInsets.all(4),
// //             decoration: BoxDecoration(
// //               color: Colors.white.withOpacity(0.2),
// //               borderRadius: BorderRadius.circular(30),
// //             ),
// //             child: Icon(iconData, color: Colors.white, size: iconSize),
// //           ),
// //         );

// //         if (animationType == AnimationType.rotate) {
// //           icon = Transform.rotate(
// //             angle: 3.14159 * (1 - scale),
// //             child: icon,
// //           );
// //         }

// //         return icon;
// //       },
// //     );
// //   }

// //   // Progress indicator as TextButton (required by Get.snackbar)
// //   static TextButton _buildProgressButton(Duration duration) {
// //     return TextButton(
// //       onPressed: () {
// //         // Close the snackbar when pressed
// //         if (Get.isSnackbarOpen) {
// //           Get.closeCurrentSnackbar();
// //         }
// //       },
// //       style: TextButton.styleFrom(
// //         padding: EdgeInsets.zero,
// //         minimumSize: const Size(4, 30),
// //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //       ),
// //       child: SizedBox(
// //         width: 4,
// //         height: 30,
// //         child: TweenAnimationBuilder<double>(
// //           tween: Tween<double>(begin: 1, end: 0),
// //           duration: duration,
// //           builder: (context, value, child) {
// //             return ClipRRect(
// //               borderRadius: BorderRadius.circular(2),
// //               child: LinearProgressIndicator(
// //                 value: value,
// //                 backgroundColor: Colors.white.withOpacity(0.3),
// //                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   // ── Public API with animation options ──────────────────────────────────────
// //   static void showErrorSnackBar(
// //     String message, {
// //     String title = "Error",
// //     bool withProgressIndicator = true,
// //     AnimationType animationType = AnimationType.slideFade,
// //   }) {
// //     _show(
// //       title: title,
// //       message: message,
// //       backgroundColor: const Color(0xFFD32F2F),
// //       iconData: Icons.error_outline_rounded,
// //       withProgressIndicator: withProgressIndicator,
// //       animationType: animationType,
// //     );
// //   }

// //   static void showSuccessSnackBar(
// //     String message, {
// //     String title = "Success",
// //     bool withProgressIndicator = true,
// //     AnimationType animationType = AnimationType.bounce,
// //   }) {
// //     _show(
// //       title: title,
// //       message: message,
// //       backgroundColor: const Color(0xFF2E7D32),
// //       iconData: Icons.check_circle_outline_rounded,
// //       withProgressIndicator: withProgressIndicator,
// //       animationType: animationType,
// //     );
// //   }

// //   static void showWarningSnackBar(
// //     String message, {
// //     String title = "Warning",
// //     bool withProgressIndicator = true,
// //     AnimationType animationType = AnimationType.rotate,
// //   }) {
// //     _show(
// //       title: title,
// //       message: message,
// //       backgroundColor: const Color(0xFFF57F17),
// //       iconData: Icons.warning_amber_rounded,
// //       withProgressIndicator: withProgressIndicator,
// //       animationType: animationType,
// //     );
// //   }

// //   static void showInfoSnackBar(
// //     String message, {
// //     String title = "Info",
// //     bool withProgressIndicator = true,
// //     AnimationType animationType = AnimationType.scale,
// //   }) {
// //     _show(
// //       title: title,
// //       message: message,
// //       backgroundColor: const Color(0xFF1565C0),
// //       iconData: Icons.info_outline_rounded,
// //       withProgressIndicator: withProgressIndicator,
// //       animationType: animationType,
// //     );
// //   }

// //   // ── Simple version without progress indicator (for comparison) ────────────
// //   static void showSimpleErrorSnackBar(String message,
// //       {String title = "Error"}) {
// //     Get.snackbar(
// //       title,
// //       message,
// //       backgroundColor: const Color(0xFFD32F2F),
// //       colorText: Colors.white,
// //       borderRadius: 12,
// //       margin: const EdgeInsets.all(16),
// //       duration: const Duration(seconds: 3),
// //       icon: const Icon(Icons.error_outline, color: Colors.white),
// //       snackPosition: SnackPosition.TOP,
// //     );
// //   }

// //   static void showSimpleSuccessSnackBar(String message,
// //       {String title = "Success"}) {
// //     Get.snackbar(
// //       title,
// //       message,
// //       backgroundColor: const Color(0xFF2E7D32),
// //       colorText: Colors.white,
// //       borderRadius: 12,
// //       margin: const EdgeInsets.all(16),
// //       duration: const Duration(seconds: 3),
// //       icon: const Icon(Icons.check_circle_outline, color: Colors.white),
// //       snackPosition: SnackPosition.TOP,
// //     );
// //   }
// // }

// // enum AnimationType {
// //   slideFade,
// //   scale,
// //   rotate,
// //   bounce,
// // }

// // // Internal class for animation configuration
// // class _AnimationConfig {
// //   final Curve forwardCurve;
// //   final Curve reverseCurve;

// //   const _AnimationConfig({
// //     required this.forwardCurve,
// //     required this.reverseCurve,
// //   });
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'dart:math' as math;
// import '../utility/responsive_constants.dart';

// class SnackBarHelper {
//   // ── Futuristic Snackbar with Neon Effects ─────────────────────────────────
//   static void _show({
//     required String title,
//     required String message,
//     required Color neonColor,
//     required IconData iconData,
//     Duration duration = const Duration(seconds: 3),
//     bool withScanLine = true,
//     bool withGlitch = false,
//     FuturisticEffect effect = FuturisticEffect.neonPulse,
//   }) {
//     final context = Get.context;
//     if (context == null) return;

//     final double screenWidth = MediaQuery.of(context).size.width;

//     // Futuristic responsive margins
//     final EdgeInsets margin = () {
//       if (screenWidth < AppBreakpoints.mobileS) {
//         return const EdgeInsets.symmetric(horizontal: 12, vertical: 20);
//       }
//       if (screenWidth < AppBreakpoints.mobileL) {
//         return const EdgeInsets.symmetric(horizontal: 20, vertical: 20);
//       }
//       if (screenWidth < AppBreakpoints.tablet) {
//         return const EdgeInsets.symmetric(horizontal: 60, vertical: 20);
//       }
//       if (screenWidth < AppBreakpoints.webS) {
//         return EdgeInsets.symmetric(
//             horizontal: screenWidth * 0.25, vertical: 20);
//       }
//       return EdgeInsets.symmetric(
//           horizontal: (screenWidth - 500) / 2, vertical: 20);
//     }();

//     Get.snackbar(
//       title,
//       message,
//       backgroundColor: Colors.transparent,
//       colorText: Colors.white,
//       borderRadius: 8,
//       margin: margin,
//       duration: duration,
//       animationDuration: const Duration(milliseconds: 400),
//       snackPosition: SnackPosition.TOP,
//       snackStyle: SnackStyle.FLOATING,

//       // Futuristic glass morphism with neon border
//       boxShadows: [
//         BoxShadow(
//           color: neonColor.withOpacity(0.3),
//           blurRadius: 20,
//           spreadRadius: 2,
//           offset: const Offset(0, 0),
//         ),
//         BoxShadow(
//           color: neonColor.withOpacity(0.1),
//           blurRadius: 40,
//           spreadRadius: 5,
//           offset: const Offset(0, 0),
//         ),
//       ],

//       titleText: _buildFuturisticTitle(title, neonColor, effect, withGlitch),
//       messageText: _buildFuturisticMessage(message, neonColor, effect),
//       icon: _buildFuturisticIcon(iconData, neonColor, effect),

//       mainButton: withScanLine ? _buildScanLineButton(duration) : null,

//       shouldIconPulse: true,
//       isDismissible: true,
//       forwardAnimationCurve: Curves.easeOutCubic,
//       reverseAnimationCurve: Curves.easeInCubic,
//       overlayBlur: 2,

//       // Neon border effect
//       borderColor: neonColor.withOpacity(0.8),
//       borderWidth: 1.5,

//       // Futuristic background gradient
//       backgroundGradient: LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [
//           Colors.black.withOpacity(0.95),
//           Colors.black.withOpacity(0.85),
//         ],
//       ),
//     );
//   }

//   // Futuristic Title with Glitch Effect
//   static Widget _buildFuturisticTitle(
//       String title, Color neonColor, FuturisticEffect effect, bool withGlitch) {
//     if (withGlitch) {
//       return Stack(
//         children: [
//           // Glitch offset layers
//           Positioned(
//             left: 2,
//             child: Text(
//               title,
//               style: TextStyle(
//                 color: Colors.cyan.withOpacity(0.5),
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 2,
//                 fontFamily: 'Courier',
//               ),
//             ),
//           ),
//           Positioned(
//             left: -2,
//             child: Text(
//               title,
//               style: TextStyle(
//                 color: Colors.purpleAccent.withOpacity(0.5),
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 2,
//                 fontFamily: 'Courier',
//               ),
//             ),
//           ),
//           // Main text with animation
//           TweenAnimationBuilder<double>(
//             tween: Tween<double>(begin: 0, end: 1),
//             duration: const Duration(milliseconds: 300),
//             builder: (context, value, child) {
//               return Opacity(
//                 opacity: value,
//                 child: Transform.translate(
//                   offset: Offset(10 * (1 - value), 0),
//                   child: _buildNeonText(title, neonColor, effect),
//                 ),
//               );
//             },
//           ),
//         ],
//       );
//     }

//     return TweenAnimationBuilder<double>(
//       tween: Tween<double>(begin: 0, end: 1),
//       duration: const Duration(milliseconds: 300),
//       builder: (context, value, child) {
//         return Opacity(
//           opacity: value,
//           child: Transform.translate(
//             offset: Offset(20 * (1 - value), 0),
//             child: _buildNeonText(title, neonColor, effect),
//           ),
//         );
//       },
//     );
//   }

//   static Widget _buildNeonText(
//       String text, Color neonColor, FuturisticEffect effect) {
//     if (effect == FuturisticEffect.cyberpunk) {
//       return Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//             decoration: BoxDecoration(
//               border: Border(
//                 left: BorderSide(color: neonColor, width: 3),
//                 bottom: BorderSide(color: neonColor, width: 1),
//               ),
//             ),
//             child: Text(
//               text.toUpperCase(),
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 3,
//                 fontFamily: 'Courier',
//                 shadows: [
//                   Shadow(blurRadius: 8, color: neonColor),
//                   Shadow(blurRadius: 15, color: neonColor.withOpacity(0.5)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       );
//     }

//     return Text(
//       text,
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 14,
//         fontWeight: FontWeight.bold,
//         letterSpacing: 2,
//         shadows: [
//           Shadow(blurRadius: 10, color: neonColor),
//           Shadow(blurRadius: 20, color: neonColor.withOpacity(0.5)),
//           if (effect == FuturisticEffect.hologram)
//             Shadow(blurRadius: 30, color: neonColor.withOpacity(0.3)),
//         ],
//       ),
//     );
//   }

//   // Futuristic Message
//   static Widget _buildFuturisticMessage(
//       String message, Color neonColor, FuturisticEffect effect) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween<double>(begin: 0, end: 1),
//       duration: const Duration(milliseconds: 400),
//       builder: (context, value, child) {
//         return Opacity(
//           opacity: value,
//           child: Transform.translate(
//             offset: Offset(15 * (1 - value), 0),
//             child: Container(
//               padding: const EdgeInsets.only(top: 4),
//               child: Text(
//                 message,
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.9),
//                   fontSize: 12,
//                   fontFamily:
//                       effect == FuturisticEffect.cyberpunk ? 'Courier' : null,
//                   height: 1.4,
//                   shadows: effect == FuturisticEffect.hologram
//                       ? [
//                           Shadow(
//                               blurRadius: 5, color: neonColor.withOpacity(0.5))
//                         ]
//                       : null,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Futuristic Icon with Energy Pulse
//   static Widget _buildFuturisticIcon(
//       IconData iconData, Color neonColor, FuturisticEffect effect) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween<double>(begin: 0, end: 1),
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.elasticOut,
//       builder: (context, scale, child) {
//         return Container(
//           margin: const EdgeInsets.only(left: 8),
//           child: Stack(
//             children: [
//               // Energy ring
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: neonColor.withOpacity(0.5),
//                     width: 1,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: neonColor.withOpacity(0.3),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 child: Transform.scale(
//                   scale: scale,
//                   child: Icon(iconData, color: neonColor, size: 22),
//                 ),
//               ),
//               // Pulsing energy effect
//               if (effect == FuturisticEffect.neonPulse)
//                 TweenAnimationBuilder<double>(
//                   tween: Tween<double>(begin: 0.8, end: 1.2),
//                   duration: const Duration(milliseconds: 800),
//                   curve: Curves.easeInOut,
//                   builder: (context, pulseScale, child) {
//                     return Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: neonColor.withOpacity(0.3),
//                           width: 2,
//                         ),
//                       ),
//                       child: Transform.scale(scale: pulseScale, child: child),
//                     );
//                   },
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Futuristic Scan Line Button
//   static TextButton _buildScanLineButton(Duration duration) {
//     return TextButton(
//       onPressed: () {
//         if (Get.isSnackbarOpen) {
//           Get.closeCurrentSnackbar();
//         }
//       },
//       style: TextButton.styleFrom(
//         padding: EdgeInsets.zero,
//         minimumSize: const Size(4, 40),
//         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//       ),
//       child: SizedBox(
//         width: 4,
//         height: 40,
//         child: TweenAnimationBuilder<double>(
//           tween: Tween<double>(begin: 1, end: 0),
//           duration: duration,
//           builder: (context, value, child) {
//             return Column(
//               children: [
//                 // Scan line animation
//                 Expanded(
//                   child: Container(
//                     width: 2,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.cyan,
//                           Colors.transparent,
//                           Colors.purpleAccent,
//                         ],
//                         stops: [value, value + 0.3, 1.0],
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Progress indicator
//                 Container(
//                   width: 4,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: Colors.cyan,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.cyan,
//                         blurRadius: 4,
//                         spreadRadius: 1,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // ── Public Futuristic APIs ─────────────────────────────────────────────────

//   // Neon Error (Red/Cyan theme)
//   static void showErrorSnackBar(
//     String message, {
//     String title = "ERROR",
//     FuturisticEffect effect = FuturisticEffect.neonPulse,
//     bool withGlitch = true,
//   }) {
//     _show(
//       title: title,
//       message: message,
//       neonColor: const Color(0xFFFF0055),
//       iconData: Icons.error_outline,
//       effect: effect,
//       withGlitch: withGlitch,
//     );
//   }

//   // Neon Success (Green theme)
//   static void showSuccessSnackBar(
//     String message, {
//     String title = "SUCCESS",
//     FuturisticEffect effect = FuturisticEffect.neonPulse,
//     bool withGlitch = false,
//   }) {
//     _show(
//       title: title,
//       message: message,
//       neonColor: const Color(0xFF00FF88),
//       iconData: Icons.check_circle_outline,
//       effect: effect,
//       withGlitch: withGlitch,
//     );
//   }

//   // Cyberpunk Warning (Yellow/Orange theme)
//   static void showWarningSnackBar(
//     String message, {
//     String title = "WARNING",
//     FuturisticEffect effect = FuturisticEffect.cyberpunk,
//     bool withGlitch = true,
//   }) {
//     _show(
//       title: title,
//       message: message,
//       neonColor: const Color(0xFFFFAA00),
//       iconData: Icons.warning_amber_rounded,
//       effect: effect,
//       withGlitch: withGlitch,
//     );
//   }

//   // Hologram Info (Blue theme)
//   static void showInfoSnackBar(
//     String message, {
//     String title = "INFO",
//     FuturisticEffect effect = FuturisticEffect.hologram,
//     bool withGlitch = false,
//   }) {
//     _show(
//       title: title,
//       message: message,
//       neonColor: const Color(0xFF00D4FF),
//       iconData: Icons.info_outline,
//       effect: effect,
//       withGlitch: withGlitch,
//     );
//   }

//   // Ultimate Futuristic Snackbar (All effects combined)
//   static void showUltimateSnackBar({
//     required String title,
//     required String message,
//     required Color neonColor,
//     required IconData iconData,
//     VoidCallback? onTap,
//   }) {
//     final context = Get.context;
//     if (context == null) return;

//     final screenWidth = MediaQuery.of(context).size.width;
//     final margin = screenWidth >= 300
//         ? EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: 20)
//         : const EdgeInsets.symmetric(horizontal: 12, vertical: 20);

//     Get.snackbar(
//       title,
//       message,
//       backgroundColor: Colors.transparent,
//       borderRadius: 16,
//       margin: margin,
//       duration: const Duration(seconds: 5),
//       animationDuration: const Duration(milliseconds: 600),
//       snackPosition: SnackPosition.TOP,
//       snackStyle: SnackStyle.FLOATING,

//       // Extreme futuristic effects
//       boxShadows: [
//         BoxShadow(
//           color: neonColor.withOpacity(0.5),
//           blurRadius: 30,
//           spreadRadius: 5,
//           offset: const Offset(0, 0),
//         ),
//         BoxShadow(
//           color: neonColor.withOpacity(0.2),
//           blurRadius: 60,
//           spreadRadius: 10,
//           offset: const Offset(0, 0),
//         ),
//       ],

//       titleText: Row(
//         children: [
//           // Animated brackets
//           TweenAnimationBuilder<double>(
//             tween: Tween<double>(begin: -10, end: 0),
//             duration: const Duration(milliseconds: 300),
//             builder: (context, value, child) {
//               return Transform.translate(
//                 offset: Offset(value, 0),
//                 child: Text('[',
//                     style: TextStyle(
//                         color: neonColor,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold)),
//               );
//             },
//           ),
//           const SizedBox(width: 4),
//           _buildNeonText(title, neonColor, FuturisticEffect.cyberpunk),
//           const SizedBox(width: 4),
//           TweenAnimationBuilder<double>(
//             tween: Tween<double>(begin: 10, end: 0),
//             duration: const Duration(milliseconds: 300),
//             builder: (context, value, child) {
//               return Transform.translate(
//                 offset: Offset(value, 0),
//                 child: Text(']',
//                     style: TextStyle(
//                         color: neonColor,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold)),
//               );
//             },
//           ),
//         ],
//       ),

//       messageText: Container(
//         margin: const EdgeInsets.only(top: 8),
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border(
//             left: BorderSide(color: neonColor, width: 2),
//             bottom: BorderSide(color: neonColor.withOpacity(0.5), width: 1),
//           ),
//         ),
//         child: Text(
//           message,
//           style: TextStyle(
//             color: Colors.white70,
//             fontSize: 12,
//             fontFamily: 'Courier',
//             letterSpacing: 1,
//           ),
//         ),
//       ),

//       icon: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           gradient: RadialGradient(
//             colors: [neonColor.withOpacity(0.3), Colors.transparent],
//             radius: 1,
//           ),
//           shape: BoxShape.circle,
//         ),
//         child: Icon(iconData, color: neonColor, size: 32),
//       ),

//       shouldIconPulse: true,
//       isDismissible: true,
//       forwardAnimationCurve: Curves.elasticOut,
//       reverseAnimationCurve: Curves.easeInBack,

//       onTap: onTap != null ? (snack) => onTap() : null,

//       borderColor: neonColor,
//       borderWidth: 2,

//       backgroundGradient: RadialGradient(
//         center: Alignment.center,
//         radius: 1.5,
//         colors: [
//           Colors.black.withOpacity(0.95),
//           Colors.black.withOpacity(0.98),
//           Colors.black,
//         ],
//         stops: const [0, 0.7, 1],
//       ),
//     );
//   }
// }

// enum FuturisticEffect {
//   neonPulse, // Pulsing neon glow
//   cyberpunk, // Cyberpunk style with borders and brackets
//   hologram, // Holographic effect with multiple shadows
// }

// // Example usage class to demonstrate all effects
// class FuturisticSnackbarDemo extends StatelessWidget {
//   const FuturisticSnackbarDemo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildButton(
//               'Neon Error',
//               () => SnackBarHelper.showErrorSnackBar(
//                 'System malfunction detected',
//                 effect: FuturisticEffect.neonPulse,
//                 withGlitch: true,
//               ),
//               Colors.red,
//             ),
//             const SizedBox(height: 16),
//             _buildButton(
//               'Cyberpunk Warning',
//               () => SnackBarHelper.showWarningSnackBar(
//                 'Security breach in sector 7',
//                 effect: FuturisticEffect.cyberpunk,
//               ),
//               Colors.orange,
//             ),
//             const SizedBox(height: 16),
//             _buildButton(
//               'Hologram Info',
//               () => SnackBarHelper.showInfoSnackBar(
//                 'New update available',
//                 effect: FuturisticEffect.hologram,
//               ),
//               Colors.cyan,
//             ),
//             const SizedBox(height: 16),
//             _buildButton(
//               'Ultimate Experience',
//               () => SnackBarHelper.showUltimateSnackBar(
//                 title: 'SYSTEM READY',
//                 message: 'All systems operational. Neural interface connected.',
//                 neonColor: Colors.purple,
//                 iconData: Icons.bolt,
//                 onTap: () => print('Snackbar tapped!'),
//               ),
//               Colors.purple,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(String text, VoidCallback onPressed, Color color) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.transparent,
//         foregroundColor: color,
//         side: BorderSide(color: color, width: 2),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.bold,
//           letterSpacing: 2,
//           shadows: [Shadow(blurRadius: 8, color: color)],
//         ),
//       ),
//     );
//   }
// }
