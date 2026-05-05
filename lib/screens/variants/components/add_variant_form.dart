// import '../../../models/variant.dart';
// import '../../../models/variant_type.dart';
// import '../provider/variant_provider.dart';
// import '../../../utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
// import '../../../widgets/custom_dropdown.dart';
// import '../../../widgets/custom_text_field.dart';

// class VariantSubmitForm extends StatelessWidget {
//   final Variant? variant;

//   const VariantSubmitForm({super.key, this.variant});

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     context.variantProvider.setDataForUpdateVariant(variant);
//     return SingleChildScrollView(
//       child: Form(
//         key: context.variantProvider.addVariantsFormKey,
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
//                     child: Consumer<VariantsProvider>(
//                       builder: (context, variantProvider, child) {
//                         return CustomDropdown(
//                           initialValue: variantProvider.selectedVariantType,
//                           items: context.dataProvider.variantTypes,
//                           hintText: variantProvider.selectedVariantType?.name ??
//                               'Select Variant Type',
//                           displayItem: (VariantType? variantType) =>
//                               variantType?.name ?? '',
//                           onChanged: (newValue) {
//                             variantProvider.selectedVariantType = newValue;
//                             variantProvider.updateUI();
//                           },
//                           validator: (value) {
//                             if (value == null) {
//                               return 'Please select a Variant Type';
//                             }
//                             return null;
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.variantProvider.variantCtrl,
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
//                       if (context
//                           .variantProvider.addVariantsFormKey.currentState!
//                           .validate()) {
//                         context.variantProvider.addVariantsFormKey.currentState!
//                             .save();

//                         context.variantProvider.submitVariant();
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
// void showAddVariantForm(BuildContext context, Variant? variant) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         title: Center(
//             child: Text('Add Variant'.toUpperCase(),
//                 style: TextStyle(color: primaryColor))),
//         content: VariantSubmitForm(variant: variant),
//       );
//     },
//   );
// }
import '../../../models/variant.dart';
import '../../../models/variant_type.dart';
import '../provider/variant_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

class VariantSubmitForm extends StatelessWidget {
  final Variant? variant;
  const VariantSubmitForm({super.key, this.variant});

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final padding = AppSpacing.cardPadding(context);
    final gap = AppSpacing.sectionGap(context);

    context.variantProvider.setDataForUpdateVariant(variant);

    return SingleChildScrollView(
      child: Form(
        key: context.variantProvider.addVariantsFormKey,
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
              isMobile
                  ? Column(children: [
                      _variantTypeDropdown(context),
                      Gap(gap),
                      _variantNameField(context),
                    ])
                  : Row(children: [
                      Expanded(child: _variantTypeDropdown(context)),
                      SizedBox(width: AppSpacing.itemGap(context)),
                      Expanded(child: _variantNameField(context)),
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
                      if (context
                          .variantProvider.addVariantsFormKey.currentState!
                          .validate()) {
                        context.variantProvider.addVariantsFormKey.currentState!
                            .save();
                        context.variantProvider.submitVariant();
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

  Widget _variantTypeDropdown(BuildContext context) {
    return Consumer<VariantsProvider>(
      builder: (context, variantProvider, child) {
        return CustomDropdown(
          initialValue: variantProvider.selectedVariantType,
          items: context.dataProvider.variantTypes,
          hintText: variantProvider.selectedVariantType?.name ??
              'Select Variant Type',
          displayItem: (VariantType? vt) => vt?.name ?? '',
          onChanged: (newValue) {
            variantProvider.selectedVariantType = newValue;
            variantProvider.updateUI();
          },
          validator: (value) =>
              value == null ? 'Please select a Variant Type' : null,
        );
      },
    );
  }

  Widget _variantNameField(BuildContext context) => CustomTextField(
        controller: context.variantProvider.variantCtrl,
        labelText: 'Variant Name',
        onSave: (val) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a variant name';
          }
          return null;
        },
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  DIALOG LAUNCHER
// ─────────────────────────────────────────────────────────────────────────────
void showAddVariantForm(BuildContext context, Variant? variant) {
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
            'ADD VARIANT',
            style: TextStyle(
              color: primaryColor,
              fontSize: AppFontSize.lg(context),
            ),
          ),
        ),
        content: SizedBox(
          width: dialogWidth,
          child: VariantSubmitForm(variant: variant),
        ),
      );
    },
  );
}
