// // import '../../../models/sub_category.dart';
// // import '../provider/sub_category_provider.dart';
// // import '../../../utility/extensions.dart';
// // import 'package:flutter/material.dart';
// // import 'package:gap/gap.dart';
// // import 'package:provider/provider.dart';
// // import '../../../models/category.dart';
// // import '../../../utility/constants.dart';
// // import '../../../widgets/custom_dropdown.dart';
// // import '../../../widgets/custom_text_field.dart';

// // class SubCategorySubmitForm extends StatelessWidget {
// //   final SubCategory? subCategory;

// //   const SubCategorySubmitForm({super.key, this.subCategory});

// //   @override
// //   Widget build(BuildContext context) {
// //     context.subCategoryProvider.setDataForUpdateSubCategory(subCategory);
// //     var size = MediaQuery.of(context).size;
// //     return SingleChildScrollView(
// //       child: Form(
// //         key: context.subCategoryProvider.addSubCategoryFormKey,
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
// //                     child: Consumer<SubCategoryProvider>(
// //                       builder: (context, subCatProvider, child) {
// //                         return CustomDropdown(
// //                           initialValue: subCatProvider.selectedCategory,
// //                           hintText: subCatProvider.selectedCategory?.name ??
// //                               'Select category',
// //                           items: context.dataProvider.categories,
// //                           displayItem: (Category? category) =>
// //                               category?.name ?? '',
// //                           onChanged: (newValue) {
// //                             if (newValue != null) {
// //                               subCatProvider.selectedCategory = newValue;
// //                               // subCatProvider.updateUi();
// //                             }
// //                           },
// //                           validator: (value) {
// //                             if (value == null) {
// //                               return 'Please select a category';
// //                             }
// //                             return null;
// //                           },
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                   Expanded(
// //                     child: CustomTextField(
// //                       controller:
// //                           context.subCategoryProvider.subCategoryNameCtrl,
// //                       labelText: 'Sub Category Name',
// //                       onSave: (val) {},
// //                       validator: (value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Please enter a sub category name';
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
// //                   Gap(defaultPadding),
// //                   ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       foregroundColor: Colors.white,
// //                       backgroundColor: primaryColor,
// //                     ),
// //                     onPressed: () {
// //                       // Validate and save the form
// //                       if (context.subCategoryProvider.addSubCategoryFormKey
// //                           .currentState!
// //                           .validate()) {
// //                         context.subCategoryProvider.addSubCategoryFormKey
// //                             .currentState!
// //                             .save();
// //                         context.subCategoryProvider.submitSubCategory();

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
// // void showAddSubCategoryForm(BuildContext context, SubCategory? subCategory) {
// //   showDialog(
// //     context: context,
// //     builder: (BuildContext context) {
// //       return AlertDialog(
// //         backgroundColor: bgColor,
// //         title: Center(
// //             child: Text('Add Sub Category'.toUpperCase(),
// //                 style: TextStyle(color: primaryColor))),
// //         content: SubCategorySubmitForm(subCategory: subCategory),
// //       );
// //     },
// //   );
// // }

// import '../../../models/sub_category.dart';
// import '../provider/sub_category_provider.dart';
// import '../../../utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import '../../../models/category.dart';
// import '../../../utility/constants.dart';
// import '../../../utility/responsive_constants.dart';
// import '../../../widgets/custom_dropdown.dart';
// import '../../../widgets/custom_text_field.dart';

// class SubCategorySubmitForm extends StatelessWidget {
//   final SubCategory? subCategory;
//   const SubCategorySubmitForm({super.key, this.subCategory});

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = AppBreakpoints.isMobile(context);
//     final padding = AppSpacing.cardPadding(context);
//     final gap = AppSpacing.sectionGap(context);

//     context.subCategoryProvider.setDataForUpdateSubCategory(subCategory);

//     return SingleChildScrollView(
//       child: Form(
//         key: context.subCategoryProvider.addSubCategoryFormKey,
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

//               // ── Category dropdown + Name field ─────────────────────────
//               // Mobile: stacked; Tablet+: side by side
//               isMobile
//                   ? Column(
//                       children: [
//                         _categoryDropdown(context),
//                         Gap(gap),
//                         _nameField(context),
//                       ],
//                     )
//                   : Row(
//                       children: [
//                         Expanded(child: _categoryDropdown(context)),
//                         SizedBox(width: AppSpacing.itemGap(context)),
//                         Expanded(child: _nameField(context)),
//                       ],
//                     ),

//               Gap(gap * 1.5),

//               // ── Action buttons ─────────────────────────────────────────
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
//                       if (context.subCategoryProvider.addSubCategoryFormKey
//                           .currentState!
//                           .validate()) {
//                         context.subCategoryProvider.addSubCategoryFormKey
//                             .currentState!
//                             .save();
//                         context.subCategoryProvider.submitSubCategory();
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

//   Widget _categoryDropdown(BuildContext context) {
//     return Consumer<SubCategoryProvider>(
//       builder: (context, subCatProvider, child) {
//         return CustomDropdown(
//           initialValue: subCatProvider.selectedCategory,
//           hintText: subCatProvider.selectedCategory?.name ?? 'Select category',
//           items: context.dataProvider.categories,
//           displayItem: (Category? category) => category?.name ?? '',
//           onChanged: (newValue) {
//             if (newValue != null) {
//               subCatProvider.selectedCategory = newValue;
//             }
//           },
//           validator: (value) =>
//               value == null ? 'Please select a category' : null,
//         );
//       },
//     );
//   }

//   Widget _nameField(BuildContext context) {
//     return CustomTextField(
//       controller: context.subCategoryProvider.subCategoryNameCtrl,
//       labelText: 'Sub Category Name',
//       onSave: (val) {},
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter a sub category name';
//         }
//         return null;
//       },
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  DIALOG LAUNCHER
// // ─────────────────────────────────────────────────────────────────────────────
// void showAddSubCategoryForm(BuildContext context, SubCategory? subCategory) {
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
//             'ADD SUB CATEGORY',
//             style: TextStyle(
//               color: primaryColor,
//               fontSize: AppFontSize.lg(context),
//             ),
//           ),
//         ),
//         content: SizedBox(
//           width: dialogWidth,
//           child: SubCategorySubmitForm(subCategory: subCategory),
//         ),
//       );
//     },
//   );
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  CONFIRMATION DELETE DIALOG  (reusable across screens)
// // ─────────────────────────────────────────────────────────────────────────────
// Future<bool> showDeleteConfirmationDialog(
//   BuildContext context, {
//   String title = 'Delete Item',
//   String message =
//       'Are you sure you want to delete this item? This action cannot be undone.',
// }) async {
//   final bool? result = await showDialog<bool>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppRadius.md(context)),
//         ),
//         title: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: Colors.red.withOpacity(0.12),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.delete_outline_rounded,
//                 color: Colors.redAccent,
//                 size: AppIconSize.md(context),
//               ),
//             ),
//             SizedBox(width: AppSpacing.itemGap(context)),
//             Expanded(
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: AppFontSize.lg(context),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         content: Text(
//           message,
//           style: TextStyle(
//             color: Colors.white70,
//             fontSize: AppFontSize.body(context),
//             height: 1.5,
//           ),
//         ),
//         actionsPadding: EdgeInsets.fromLTRB(
//           AppSpacing.md(context),
//           0,
//           AppSpacing.md(context),
//           AppSpacing.md(context),
//         ),
//         actions: [
//           // Cancel
//           OutlinedButton(
//             style: OutlinedButton.styleFrom(
//               foregroundColor: Colors.white70,
//               side: const BorderSide(color: Colors.white24),
//               padding: EdgeInsets.symmetric(
//                 horizontal: AppSpacing.md(context),
//                 vertical: AppSpacing.sm(context),
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(AppRadius.sm(context)),
//               ),
//             ),
//             onPressed: () => Navigator.of(context).pop(false),
//             child: Text('Cancel',
//                 style: TextStyle(fontSize: AppFontSize.body(context))),
//           ),
//           // Delete
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.redAccent,
//               foregroundColor: Colors.white,
//               padding: EdgeInsets.symmetric(
//                 horizontal: AppSpacing.md(context),
//                 vertical: AppSpacing.sm(context),
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(AppRadius.sm(context)),
//               ),
//             ),
//             onPressed: () => Navigator.of(context).pop(true),
//             child: Text('Delete',
//                 style: TextStyle(fontSize: AppFontSize.body(context))),
//           ),
//         ],
//       );
//     },
//   );
//   return result ?? false;
// }

import '../../../models/sub_category.dart';
import '../provider/sub_category_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../models/category.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

class SubCategorySubmitForm extends StatelessWidget {
  final SubCategory? subCategory;
  const SubCategorySubmitForm({super.key, this.subCategory});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final padding = AppSpacing.cardPadding(context);
    final gap = AppSpacing.sectionGap(context);

    context.subCategoryProvider.setDataForUpdateSubCategory(subCategory);

    return SingleChildScrollView(
      child: Form(
        key: context.subCategoryProvider.addSubCategoryFormKey,
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

              // ── Category dropdown + Name field ─────────────────────────
              // Mobile: stacked; Tablet+: side by side
              isMobile
                  ? Column(
                      children: [
                        _categoryDropdown(context),
                        Gap(gap),
                        _nameField(context),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(child: _categoryDropdown(context)),
                        SizedBox(width: AppSpacing.itemGap(context)),
                        Expanded(child: _nameField(context)),
                      ],
                    ),

              Gap(gap * 1.5),

              // ── Action buttons ─────────────────────────────────────────
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
                      if (context.subCategoryProvider.addSubCategoryFormKey
                          .currentState!
                          .validate()) {
                        context.subCategoryProvider.addSubCategoryFormKey
                            .currentState!
                            .save();
                        context.subCategoryProvider.submitSubCategory();
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

  Widget _categoryDropdown(BuildContext context) {
    return Consumer<SubCategoryProvider>(
      builder: (context, subCatProvider, child) {
        return CustomDropdown(
          initialValue: subCatProvider.selectedCategory,
          hintText: subCatProvider.selectedCategory?.name ?? 'Select category',
          items: context.dataProvider.categories,
          displayItem: (Category? category) => category?.name ?? '',
          onChanged: (newValue) {
            if (newValue != null) {
              subCatProvider.selectedCategory = newValue;
            }
          },
          validator: (value) =>
              value == null ? 'Please select a category' : null,
        );
      },
    );
  }

  Widget _nameField(BuildContext context) {
    return CustomTextField(
      controller: context.subCategoryProvider.subCategoryNameCtrl,
      labelText: 'Sub Category Name',
      onSave: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a sub category name';
        }
        return null;
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DIALOG LAUNCHER
// ─────────────────────────────────────────────────────────────────────────────
void showAddSubCategoryForm(BuildContext context, SubCategory? subCategory) {
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
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.symmetric(
          horizontal: (w - dialogWidth) / 2,
          vertical: 24,
        ),
        title: Center(
          child: Text(
            'ADD SUB CATEGORY',
            style: TextStyle(
              color: primaryColor,
              fontSize: AppFontSize.lg(context),
            ),
          ),
        ),
        content: SizedBox(
          width: dialogWidth,
          child: SubCategorySubmitForm(subCategory: subCategory),
        ),
      );
    },
  );
}

// ─────────────────────────────────────────────────────────────────────────────
//  CONFIRMATION DELETE DIALOG  (reusable across screens)
// ─────────────────────────────────────────────────────────────────────────────
Future<bool> showDeleteConfirmationDialog(
  BuildContext context, {
  String title = 'Delete Item',
  String message =
      'Are you sure you want to delete this item? This action cannot be undone.',
}) async {
  final bool? result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md(context)),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
                size: AppIconSize.md(context),
              ),
            ),
            SizedBox(width: AppSpacing.itemGap(context)),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppFontSize.lg(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white70,
            fontSize: AppFontSize.body(context),
            height: 1.5,
          ),
        ),
        actionsPadding: EdgeInsets.fromLTRB(
          AppSpacing.md(context),
          0,
          AppSpacing.md(context),
          AppSpacing.md(context),
        ),
        actions: [
          // Cancel
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: const BorderSide(color: Colors.white24),
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md(context),
                vertical: AppSpacing.sm(context),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm(context)),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel',
                style: TextStyle(fontSize: AppFontSize.body(context))),
          ),
          // Delete
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md(context),
                vertical: AppSpacing.sm(context),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm(context)),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete',
                style: TextStyle(fontSize: AppFontSize.body(context))),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
