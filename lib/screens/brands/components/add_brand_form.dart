// // import '../../../models/sub_category.dart';
// // import '../provider/brand_provider.dart';
// // import '../../../utility/extensions.dart';
// // import 'package:flutter/material.dart';
// // import 'package:gap/gap.dart';
// // import 'package:provider/provider.dart';
// // import '../../../models/brand.dart';
// // import '../../../utility/constants.dart';
// // import '../../../widgets/custom_dropdown.dart';
// // import '../../../widgets/custom_text_field.dart';

// // class BrandSubmitForm extends StatelessWidget {
// //   final Brand? brand;

// //   const BrandSubmitForm({super.key, this.brand});

// //   @override
// //   Widget build(BuildContext context) {
// //     var size = MediaQuery.of(context).size;
// //     context.brandProvider.setDataForUpdateBrand(brand);
// //     return SingleChildScrollView(
// //       child: Form(
// //         key: context.brandProvider.addBrandFormKey,
// //         child: Container(
// //           padding: EdgeInsets.all(defaultPadding),
// //           width: size.width * 0.5,
// //           decoration: BoxDecoration(
// //             color: bgColor,
// //             borderRadius: BorderRadius.circular(12.0),
// //           ),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Gap(defaultPadding),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: Consumer<BrandProvider>(
// //                       builder: (context, brandProvider, child) {
// //                         return CustomDropdown(
// //                           initialValue: brandProvider.selectedSubCategory,
// //                           items: context.dataProvider.subCategories,
// //                           hintText: brandProvider.selectedSubCategory?.name ??
// //                               'Select Sub Category',
// //                           displayItem: (SubCategory? subCategory) =>
// //                               subCategory?.name ?? '',
// //                           onChanged: (newValue) {
// //                             brandProvider.selectedSubCategory = newValue;
// //                             brandProvider.updateUI();
// //                           },
// //                           validator: (value) {
// //                             if (value == null) {
// //                               return 'Please select a Sub Category';
// //                             }
// //                             return null;
// //                           },
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                   Expanded(
// //                     child: CustomTextField(
// //                       controller: context.brandProvider.brandNameCtrl,
// //                       labelText: 'Brand Name',
// //                       onSave: (val) {},
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Please enter a brand name';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               Gap(defaultPadding * 2),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       foregroundColor: Colors.white,
// //                       backgroundColor: secondaryColor,
// //                     ),
// //                     onPressed: () {
// //                       Navigator.of(context).pop(); // Close the popup
// //                     },
// //                     child: Text('Cancel'),
// //                   ),
// //                   SizedBox(width: defaultPadding),
// //                   ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       foregroundColor: Colors.white,
// //                       backgroundColor: primaryColor,
// //                     ),
// //                     onPressed: () {
// //                       // Validate and save the form
// //                       if (context.brandProvider.addBrandFormKey.currentState!
// //                           .validate()) {
// //                         context.brandProvider.addBrandFormKey.currentState!
// //                             .save();

// //                         context.brandProvider.submitBrand();
// //                         Navigator.of(context).pop();
// //                       }
// //                     },
// //                     child: Text('Submit'),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // How to show the category popup
// // void showBrandForm(BuildContext context, Brand? brand) {
// //   showDialog(
// //     context: context,
// //     builder: (BuildContext context) {
// //       return AlertDialog(
// //         backgroundColor: bgColor,
// //         title: Center(
// //             child: Text('Add Brand'.toUpperCase(),
// //                 style: TextStyle(color: primaryColor))),
// //         content: BrandSubmitForm(
// //           brand: brand,
// //         ),
// //       );
// //     },
// //   );
// // }

// import '../../../models/sub_category.dart';
// import '../provider/brand_provider.dart';
// import '../../../utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import '../../../models/brand.dart';
// import '../../../utility/constants.dart';
// import '../../../utility/responsive_constants.dart';
// import '../../../widgets/custom_dropdown.dart';
// import '../../../widgets/custom_text_field.dart';

// class BrandSubmitForm extends StatelessWidget {
//   final Brand? brand;
//   const BrandSubmitForm({super.key, this.brand});

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = AppBreakpoints.isMobile(context);
//     final padding = AppSpacing.cardPadding(context);
//     final gap = AppSpacing.sectionGap(context);

//     context.brandProvider.setDataForUpdateBrand(brand);

//     return SingleChildScrollView(
//       child: Form(
//         key: context.brandProvider.addBrandFormKey,
//         child: Container(
//           padding: padding,
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Gap(gap),

//               // Sub category dropdown + Brand name field
//               // Mobile: stacked | Tablet+: side by side
//               isMobile
//                   ? Column(children: [
//                       _subCategoryDropdown(context),
//                       Gap(gap),
//                       _brandNameField(context),
//                     ])
//                   : Row(children: [
//                       Expanded(child: _subCategoryDropdown(context)),
//                       SizedBox(width: AppSpacing.itemGap(context)),
//                       Expanded(child: _brandNameField(context)),
//                     ]),

//               Gap(gap * 1.5),

//               // Action buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: secondaryColor,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: AppSpacing.md(context),
//                         vertical: AppSpacing.sm(context),
//                       ),
//                     ),
//                     onPressed: () => Navigator.of(context).pop(),
//                     child: Text('Cancel',
//                         style: TextStyle(fontSize: AppFontSize.body(context))),
//                   ),
//                   Gap(gap),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: primaryColor,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: AppSpacing.md(context),
//                         vertical: AppSpacing.sm(context),
//                       ),
//                     ),
//                     onPressed: () {
//                       if (context.brandProvider.addBrandFormKey.currentState!
//                           .validate()) {
//                         context.brandProvider.addBrandFormKey.currentState!
//                             .save();
//                         context.brandProvider.submitBrand();
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     child: Text('Submit',
//                         style: TextStyle(fontSize: AppFontSize.body(context))),
//                   ),
//                 ],
//               ),

//               Gap(gap * 0.5),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _subCategoryDropdown(BuildContext context) {
//     return Consumer<BrandProvider>(
//       builder: (context, brandProvider, child) {
//         return CustomDropdown(
//           initialValue: brandProvider.selectedSubCategory,
//           items: context.dataProvider.subCategories,
//           hintText:
//               brandProvider.selectedSubCategory?.name ?? 'Select Sub Category',
//           displayItem: (SubCategory? s) => s?.name ?? '',
//           onChanged: (newValue) {
//             brandProvider.selectedSubCategory = newValue;
//             brandProvider.updateUI();
//           },
//           validator: (value) =>
//               value == null ? 'Please select a Sub Category' : null,
//         );
//       },
//     );
//   }

//   Widget _brandNameField(BuildContext context) {
//     return CustomTextField(
//       controller: context.brandProvider.brandNameCtrl,
//       labelText: 'Brand Name',
//       onSave: (val) {},
//       validator: (value) {
//         if (value == null || value.isEmpty) return 'Please enter a brand name';
//         return null;
//       },
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  DIALOG LAUNCHER
// // ─────────────────────────────────────────────────────────────────────────────
// void showBrandForm(BuildContext context, Brand? brand) {
//   final w = MediaQuery.of(context).size.width;

//   final double dialogWidth = () {
//     if (w < AppBreakpoints.mobileS) return w * 0.92;
//     if (w < AppBreakpoints.mobileL) return w * 0.88;
//     if (w < AppBreakpoints.tablet) return w * 0.75;
//     if (w < AppBreakpoints.webS) return w * 0.52;
//     return w * 0.42;
//   }();

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         insetPadding: EdgeInsets.symmetric(
//           horizontal: (w - dialogWidth) / 2,
//           vertical: 24,
//         ),
//         title: Center(
//           child: Text(
//             'ADD BRAND',
//             style: TextStyle(
//               color: primaryColor,
//               fontSize: AppFontSize.lg(context),
//             ),
//           ),
//         ),
//         content: SizedBox(
//           width: dialogWidth,
//           child: BrandSubmitForm(brand: brand),
//         ),
//       );
//     },
//   );
// }

import '../../../models/sub_category.dart';
import '../provider/brand_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../models/brand.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

class BrandSubmitForm extends StatelessWidget {
  final Brand? brand;
  const BrandSubmitForm({super.key, this.brand});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final padding = AppSpacing.cardPadding(context);
    final gap = AppSpacing.sectionGap(context);

    context.brandProvider.setDataForUpdateBrand(brand);

    return SingleChildScrollView(
      child: Form(
        key: context.brandProvider.addBrandFormKey,
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

              // Sub category dropdown + Brand name field
              // Mobile: stacked | Tablet+: side by side
              isMobile
                  ? Column(children: [
                      _subCategoryDropdown(context),
                      Gap(gap),
                      _brandNameField(context),
                    ])
                  : Row(children: [
                      Expanded(child: _subCategoryDropdown(context)),
                      SizedBox(width: AppSpacing.itemGap(context)),
                      Expanded(child: _brandNameField(context)),
                    ]),

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
                      if (context.brandProvider.addBrandFormKey.currentState!
                          .validate()) {
                        context.brandProvider.addBrandFormKey.currentState!
                            .save();
                        context.brandProvider.submitBrand();
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

  Widget _subCategoryDropdown(BuildContext context) {
    return Consumer<BrandProvider>(
      builder: (context, brandProvider, child) {
        return CustomDropdown(
          initialValue: brandProvider.selectedSubCategory,
          items: context.dataProvider.subCategories,
          hintText:
              brandProvider.selectedSubCategory?.name ?? 'Select Sub Category',
          displayItem: (SubCategory? s) => s?.name ?? '',
          onChanged: (newValue) {
            brandProvider.selectedSubCategory = newValue;
            brandProvider.updateUI();
          },
          validator: (value) =>
              value == null ? 'Please select a Sub Category' : null,
        );
      },
    );
  }

  Widget _brandNameField(BuildContext context) {
    return CustomTextField(
      controller: context.brandProvider.brandNameCtrl,
      labelText: 'Brand Name',
      onSave: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter a brand name';
        return null;
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DIALOG LAUNCHER
// ─────────────────────────────────────────────────────────────────────────────
void showBrandForm(BuildContext context, Brand? brand) {
  final w = MediaQuery.of(context).size.width;

  final double dialogWidth = () {
    if (w < AppBreakpoints.mobileS) return w * 0.92;
    if (w < AppBreakpoints.mobileL) return w * 0.88;
    if (w < AppBreakpoints.tablet) return w * 0.75;
    if (w < AppBreakpoints.webS) return w * 0.52;
    return w * 0.42;
  }();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        // Remove AlertDialog's built-in content padding so dialogWidth
        // is the actual available width — prevents Row overflow.
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.symmetric(
          horizontal: (w - dialogWidth) / 2,
          vertical: 24,
        ),
        title: Center(
          child: Text(
            brand == null ? 'ADD BRAND' : 'UPDATE BRAND',
            style: TextStyle(
              color: primaryColor,
              fontSize: AppFontSize.lg(context),
            ),
          ),
        ),
        content: SizedBox(
          width: dialogWidth,
          child: BrandSubmitForm(brand: brand),
        ),
      );
    },
  );
}
