// import '../../../models/category.dart';
// import '../provider/category_provider.dart';
// import '../../../utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
// import '../../../widgets/category_image_card.dart';
// import '../../../widgets/custom_text_field.dart';

// class CategorySubmitForm extends StatelessWidget {
//   final Category? category;

//   const CategorySubmitForm({super.key, this.category});

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     // call setDataForUpdateCategory
//     context.categoryProvider.setDataForUpdateCategory(category);
//     return SingleChildScrollView(
//       child: Form(
//         key: context.categoryProvider.addCategoryFormKey,
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
//               Consumer<CategoryProvider>(
//                 builder: (context, catProvider, child) {
//                   return CategoryImageCard(
//                     labelText: "Category",
//                     imageFile: catProvider.selectedImage,
//                     imageUrlForUpdateImage: category?.fullUrl,
//                     onTap: () {
//                       catProvider.pickImage();
//                     },
//                   );
//                 },
//               ),
//               Gap(defaultPadding),
//               CustomTextField(
//                 controller: context.categoryProvider.categoryNameCtrl,
//                 labelText: 'Category Name',
//                 onSave: (val) {},
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a category name';
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
//                       if (context
//                           .categoryProvider.addCategoryFormKey.currentState!
//                           .validate()) {
//                         context
//                             .categoryProvider.addCategoryFormKey.currentState!
//                             .save();
//                         context.categoryProvider.submitCategory();

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
// void showAddCategoryForm(BuildContext context, Category? category) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         title: Center(
//             child: Text('Add Category'.toUpperCase(),
//                 style: TextStyle(color: primaryColor))),
//         content: CategorySubmitForm(category: category),
//       );
//     },
//   );
// }

import '../../../models/category.dart';
import '../provider/category_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_text_field.dart';

class CategorySubmitForm extends StatelessWidget {
  final Category? category;
  const CategorySubmitForm({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    // final w = MediaQuery.of(context).size.width;
    final padding = AppSpacing.cardPadding(context);
    final gap = AppSpacing.sectionGap(context);

    context.categoryProvider.setDataForUpdateCategory(category);

    return SingleChildScrollView(
      child: Form(
        key: context.categoryProvider.addCategoryFormKey,
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

              // ── Image card — centred, size handled internally ─────────
              Consumer<CategoryProvider>(
                builder: (context, catProvider, child) {
                  return Center(
                    child: CategoryImageCard(
                      labelText: "Category Image",
                      imageFile: catProvider.selectedImage,
                      imageUrlForUpdateImage: category?.fullUrl,
                      onTap: () => catProvider.pickImage(),
                    ),
                  );
                },
              ),

              Gap(gap),

              // ── Category name ─────────────────────────────────────────
              CustomTextField(
                controller: context.categoryProvider.categoryNameCtrl,
                labelText: 'Category Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category name';
                  }
                  return null;
                },
              ),

              Gap(gap * 1.5),

              // ── Action buttons ────────────────────────────────────────
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
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: AppFontSize.body(context)),
                    ),
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
                      if (context
                          .categoryProvider.addCategoryFormKey.currentState!
                          .validate()) {
                        context
                            .categoryProvider.addCategoryFormKey.currentState!
                            .save();
                        context.categoryProvider.submitCategory();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: AppFontSize.body(context)),
                    ),
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
//  DIALOG LAUNCHER — responsive dialog width
// ─────────────────────────────────────────────────────────────────────────────
void showAddCategoryForm(BuildContext context, Category? category) {
  final w = MediaQuery.of(context).size.width;

  // Category form is simpler than product — can be narrower
  final double dialogWidth = () {
    if (w < AppBreakpoints.mobileS) return w * 0.92;
    if (w < AppBreakpoints.mobileL) return w * 0.88;
    if (w < AppBreakpoints.tablet) return w * 0.70;
    if (w < AppBreakpoints.webS) return w * 0.45;
    return w * 0.35; // web: comfortable narrow dialog
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
            'ADD CATEGORY',
            style: TextStyle(
              color: primaryColor,
              fontSize: AppFontSize.lg(context),
            ),
          ),
        ),
        content: SizedBox(
          width: dialogWidth,
          child: CategorySubmitForm(category: category),
        ),
      );
    },
  );
}
