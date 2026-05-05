// import '../provider/poster_provider.dart';
// import '../../../utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import '../../../models/poster.dart';
// import '../../../utility/constants.dart';
// import '../../../widgets/category_image_card.dart';
// import '../../../widgets/custom_text_field.dart';

// class PosterSubmitForm extends StatelessWidget {
//   final Poster? poster;

//   const PosterSubmitForm({super.key, this.poster});

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     context.posterProvider.setDataForUpdatePoster(poster);
//     return SingleChildScrollView(
//       child: Form(
//         key: context.posterProvider.addPosterFormKey,
//         child: Container(
//           padding: EdgeInsets.all(defaultPadding),
//           width: size.width * 0.3,
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Gap(defaultPadding),
//               Consumer<PosterProvider>(
//                 builder: (context, posterProvider, child) {
//                   return CategoryImageCard(
//                     labelText: "Poster",
//                     imageFile: posterProvider.selectedImage,
//                     imageUrlForUpdateImage: poster?.fullUrl,
//                     onTap: () {
//                       posterProvider.pickImage();
//                     },
//                   );
//                 },
//               ),
//               Gap(defaultPadding),
//               CustomTextField(
//                 controller: context.posterProvider.posterNameCtrl,
//                 labelText: 'Poster Name',
//                 onSave: (val) {},
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a poster name';
//                   }
//                   return null;
//                 },
//               ),
//               Gap(defaultPadding * 2),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: secondaryColor,
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the popup
//                     },
//                     child: Text('Cancel'),
//                   ),
//                   Gap(defaultPadding),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: primaryColor,
//                     ),
//                     onPressed: () {
//                       // Validate and save the form
//                       if (context.posterProvider.addPosterFormKey.currentState!
//                           .validate()) {
//                         context.posterProvider.addPosterFormKey.currentState!
//                             .save();
//                         context.posterProvider.submitPoster();
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     child: Text('Submit'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // How to show the category popup
// void showAddPosterForm(BuildContext context, Poster? poster) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         title: Center(
//             child: Text('Add Poster'.toUpperCase(),
//                 style: TextStyle(color: primaryColor))),
//         content: PosterSubmitForm(poster: poster),
//       );
//     },
//   );
// }

import '../provider/poster_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../models/poster.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_text_field.dart';

class PosterSubmitForm extends StatelessWidget {
  final Poster? poster;
  const PosterSubmitForm({super.key, this.poster});

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.cardPadding(context);
    final gap = AppSpacing.sectionGap(context);

    context.posterProvider.setDataForUpdatePoster(poster);

    return SingleChildScrollView(
      child: Form(
        key: context.posterProvider.addPosterFormKey,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(gap),

              // Image card — centred
              Consumer<PosterProvider>(
                builder: (context, posterProvider, child) {
                  return Center(
                    child: CategoryImageCard(
                      labelText: "Poster Image",
                      imageFile: posterProvider.selectedImage,
                      imageUrlForUpdateImage: poster?.fullUrl,
                      onTap: () => posterProvider.pickImage(),
                    ),
                  );
                },
              ),

              Gap(gap),

              // Poster name
              CustomTextField(
                controller: context.posterProvider.posterNameCtrl,
                labelText: 'Poster Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a poster name';
                  }
                  return null;
                },
              ),

              Gap(gap * 1.5),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md(context),
                        vertical: AppSpacing.sm(context),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel',
                        style: TextStyle(fontSize: AppFontSize.body(context))),
                  ),
                  Gap(gap),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.md(context),
                        vertical: AppSpacing.sm(context),
                      ),
                    ),
                    onPressed: () {
                      if (context.posterProvider.addPosterFormKey.currentState!
                          .validate()) {
                        context.posterProvider.addPosterFormKey.currentState!
                            .save();
                        context.posterProvider.submitPoster();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit',
                        style: TextStyle(fontSize: AppFontSize.body(context))),
                  ),
                ],
              ),

              Gap(gap * 0.5),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DIALOG LAUNCHER
// ─────────────────────────────────────────────────────────────────────────────
void showAddPosterForm(BuildContext context, Poster? poster) {
  final w = MediaQuery.of(context).size.width;

  // Same width profile as CategorySubmitForm — simple single-image form
  final double dialogWidth = () {
    if (w < AppBreakpoints.mobileS) return w * 0.92;
    if (w < AppBreakpoints.mobileL) return w * 0.88;
    if (w < AppBreakpoints.tablet) return w * 0.70;
    if (w < AppBreakpoints.webS) return w * 0.45;
    return w * 0.35;
  }();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        insetPadding: EdgeInsets.symmetric(
          horizontal: (w - dialogWidth) / 2,
          vertical: 24,
        ),
        title: Center(
          child: Text(
            'ADD POSTER',
            style: TextStyle(
              color: primaryColor,
              fontSize: AppFontSize.lg(context),
            ),
          ),
        ),
        content: SizedBox(
          width: dialogWidth,
          child: PosterSubmitForm(poster: poster),
        ),
      );
    },
  );
}
