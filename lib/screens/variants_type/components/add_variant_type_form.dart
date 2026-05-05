// import '../../../models/variant_type.dart';
// import '../../../utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../utility/constants.dart';
// import '../../../widgets/custom_text_field.dart';

// class VariantTypeSubmitForm extends StatelessWidget {
//   final VariantType? variantType;

//   const VariantTypeSubmitForm({super.key, this.variantType});

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     context.variantTypeProvider.setDataForUpdateVariantTYpe(variantType);
//     return SingleChildScrollView(
//       child: Form(
//         key: context.variantTypeProvider.addVariantsTypeFormKey,
//         child: Container(
//           padding: EdgeInsets.all(defaultPadding),
//           width: size.width * 0.5,
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(height: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.variantTypeProvider.variantNameCtrl,
//                       labelText: 'Variant Name',
//                       onSave: (val) {},
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a variant name';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.variantTypeProvider.variantTypeCtrl,
//                       labelText: 'Variant Type',
//                       onSave: (val) {},
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a type name';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: defaultPadding * 2),
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
//                   SizedBox(width: defaultPadding),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: primaryColor,
//                     ),
//                     onPressed: () {
//                       // Validate and save the form
//                       if (context.variantTypeProvider.addVariantsTypeFormKey
//                           .currentState!
//                           .validate()) {
//                         context.variantTypeProvider.addVariantsTypeFormKey
//                             .currentState!
//                             .save();

//                         context.variantTypeProvider.submitVariantType();
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
// void showAddVariantsTypeForm(BuildContext context, VariantType? variantType) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         title: Center(
//             child: Text('Add Variant Type'.toUpperCase(),
//                 style: TextStyle(color: primaryColor))),
//         content: VariantTypeSubmitForm(variantType: variantType),
//       );
//     },
//   );
// }
import '../../../models/variant_type.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../widgets/custom_text_field.dart';

class VariantTypeSubmitForm extends StatelessWidget {
  final VariantType? variantType;
  const VariantTypeSubmitForm({super.key, this.variantType});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final padding = AppSpacing.cardPadding(context);
    final gap = AppSpacing.sectionGap(context);

    context.variantTypeProvider.setDataForUpdateVariantTYpe(variantType);

    return SingleChildScrollView(
      child: Form(
        key: context.variantTypeProvider.addVariantsTypeFormKey,
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

              // Variant Name + Variant Type fields
              // Mobile: stacked | Tablet+: side by side
              isMobile
                  ? Column(children: [
                      _variantNameField(context),
                      Gap(gap),
                      _variantTypeField(context),
                    ])
                  : Row(children: [
                      Expanded(child: _variantNameField(context)),
                      SizedBox(width: AppSpacing.itemGap(context)),
                      Expanded(child: _variantTypeField(context)),
                    ]),

              Gap(gap * 1.5),

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
                      if (context.variantTypeProvider.addVariantsTypeFormKey
                          .currentState!
                          .validate()) {
                        context.variantTypeProvider.addVariantsTypeFormKey
                            .currentState!
                            .save();
                        context.variantTypeProvider.submitVariantType();
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

  Widget _variantNameField(BuildContext context) => CustomTextField(
        controller: context.variantTypeProvider.variantNameCtrl,
        labelText: 'Variant Name',
        onSave: (val) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a variant name';
          }
          return null;
        },
      );

  Widget _variantTypeField(BuildContext context) => CustomTextField(
        controller: context.variantTypeProvider.variantTypeCtrl,
        labelText: 'Variant Type',
        onSave: (val) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a type name';
          }
          return null;
        },
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  DIALOG LAUNCHER
// ─────────────────────────────────────────────────────────────────────────────
void showAddVariantsTypeForm(BuildContext context, VariantType? variantType) {
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
        insetPadding: EdgeInsets.symmetric(
          horizontal: (w - dialogWidth) / 2,
          vertical: 24,
        ),
        title: Center(
          child: Text(
            'ADD VARIANT TYPE',
            style: TextStyle(
              color: primaryColor,
              fontSize: AppFontSize.lg(context),
            ),
          ),
        ),
        content: SizedBox(
          width: dialogWidth,
          child: VariantTypeSubmitForm(variantType: variantType),
        ),
      );
    },
  );
}
