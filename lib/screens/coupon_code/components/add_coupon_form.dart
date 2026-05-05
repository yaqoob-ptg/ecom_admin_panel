// import '../../../models/product.dart';
// import '../../../models/sub_category.dart';
// import '../provider/coupon_code_provider.dart';
// import '../../../utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import '../../../models/category.dart';
// import '../../../models/coupon.dart';
// import '../../../utility/constants.dart';
// import '../../../widgets/custom_date_picker.dart';
// import '../../../widgets/custom_dropdown.dart';
// import '../../../widgets/custom_text_field.dart';

// class CouponSubmitForm extends StatelessWidget {
//   final Coupon? coupon;

//   const CouponSubmitForm({Key? key, this.coupon}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     context.couponCodeProvider.setDataForUpdateCoupon(coupon);
//     return SingleChildScrollView(
//       child: Form(
//         key: context.couponCodeProvider.addCouponFormKey,
//         child: Container(
//           width: size.width * 0.7,
//           padding: EdgeInsets.all(defaultPadding),
//           decoration: BoxDecoration(
//             color: bgColor,
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Gap(defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.couponCodeProvider.couponCodeCtrl,
//                       labelText: 'Coupon Code',
//                       onSave: (val) {},
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter coupon code';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomDropdown(
//                       key: GlobalKey(),
//                       hintText: 'Discount Type',
//                       items: ['fixed', 'percentage'],
//                       initialValue:
//                           context.couponCodeProvider.selectedDiscountType,
//                       onChanged: (newValue) {
//                         context.couponCodeProvider.selectedDiscountType =
//                             newValue ?? 'fixed';
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select a discount type';
//                         }
//                         return null;
//                       },
//                       displayItem: (val) => val,
//                     ),
//                   ),
//                 ],
//               ),
//               Gap(defaultPadding),
//               Row(
//                 children: [
//                   // Expanded(
//                   //   child: CustomTextField(
//                   //     controller: context.couponCodeProvider.discountAmountCtrl,
//                   //     labelText:
//                   //         context.couponCodeProvider.selectedDiscountType ==
//                   //                 'fixed'
//                   //             ? 'Discount Amount'
//                   //             : 'Discount Percentage',
//                   //     inputType: TextInputType.number,
//                   //     onSave: (val) {},
//                   //     validator: (value) {
//                   //       if (value == null || value.isEmpty) {
//                   //         return 'Please enter discount amount';
//                   //       }
//                   //       return null;
//                   //     },
//                   //   ),
//                   // ),
//                   Expanded(
//                     child: Consumer<CouponCodeProvider>(
//                       // 2. Wrap the text field to update label/error
//                       builder: (context, provider, child) {
//                         final isFixed =
//                             provider.selectedDiscountType == 'fixed';

//                         return CustomTextField(
//                           controller: provider.discountAmountCtrl,
//                           labelText: isFixed
//                               ? 'Discount Amount'
//                               : 'Discount Percentage',
//                           inputType: TextInputType.number,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return isFixed
//                                   ? 'Please enter discount amount'
//                                   : 'Please enter discount percentage';
//                             }
//                             // Add extra logic for percentage if you want
//                             if (!isFixed && double.tryParse(value)! > 100) {
//                               return 'Percentage cannot exceed 100%';
//                             }
//                             return null;
//                           },
//                           onSave: (String? p1) {},
//                         );
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller:
//                           context.couponCodeProvider.minimumPurchaseAmountCtrl,
//                       labelText: 'Minimum Purchase Amount',
//                       inputType: TextInputType.number,
//                       onSave: (val) {},
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select status';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Gap(defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomDatePicker(
//                       labelText: 'Select Coupon End Date',
//                       controller: context.couponCodeProvider.endDateCtrl,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2100),
//                       onDateSelected: (DateTime date) {
//                         print('Selected Date: $date');
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomDropdown(
//                       key: GlobalKey(),
//                       hintText: 'Status',
//                       initialValue:
//                           context.couponCodeProvider.selectedCouponStatus,
//                       items: ['active', 'inactive'],
//                       displayItem: (val) => val,
//                       onChanged: (newValue) {
//                         context.couponCodeProvider.selectedCouponStatus =
//                             newValue ?? 'active';
//                       },
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please select status';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: defaultPadding,
//               ),
//               Text(
//                 "Apply Coupon On any of the following (optional)",
//                 style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "Note: If you select a category, the coupon will be applied to all products in that category. If you select a sub-category, the coupon will be applied to all products in that sub-category. If you select a product, the coupon will be applied only to that product. If you select none, the coupon will be applied to the entire store.",
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: 12,
//                   fontStyle: FontStyle.italic,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: defaultPadding,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Consumer<CouponCodeProvider>(
//                       builder: (context, couponProvider, child) {
//                         return CustomDropdown(
//                           initialValue: couponProvider.selectedCategory,
//                           hintText: couponProvider.selectedCategory?.name ??
//                               'Select category',
//                           items: context.dataProvider.categories,
//                           displayItem: (Category? category) =>
//                               category?.name ?? '',
//                           onChanged: (newValue) {
//                             if (newValue != null) {
//                               couponProvider.selectedSubCategory = null;
//                               couponProvider.selectedProduct = null;
//                               couponProvider.selectedCategory = newValue;
//                               couponProvider.updateUi();
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Consumer<CouponCodeProvider>(
//                       builder: (context, couponProvider, child) {
//                         return CustomDropdown(
//                           initialValue: couponProvider.selectedSubCategory,
//                           hintText: couponProvider.selectedSubCategory?.name ??
//                               'Select sub category',
//                           items: context.dataProvider.subCategories,
//                           displayItem: (SubCategory? subCategory) =>
//                               subCategory?.name ?? '',
//                           onChanged: (newValue) {
//                             if (newValue != null) {
//                               couponProvider.selectedCategory = null;
//                               couponProvider.selectedProduct = null;
//                               couponProvider.selectedSubCategory = newValue;
//                               couponProvider.updateUi();
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Consumer<CouponCodeProvider>(
//                       builder: (context, couponProvider, child) {
//                         return CustomDropdown(
//                           initialValue: couponProvider.selectedProduct,
//                           hintText: couponProvider.selectedProduct?.name ??
//                               'Select product',
//                           items: context.dataProvider.products,
//                           displayItem: (Product? product) =>
//                               product?.name ?? '',
//                           onChanged: (newValue) {
//                             if (newValue != null) {
//                               couponProvider.selectedCategory = null;
//                               couponProvider.selectedSubCategory = null;
//                               couponProvider.selectedProduct = newValue;
//                               couponProvider.updateUi();
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Gap(defaultPadding),
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
//                           .couponCodeProvider.addCouponFormKey.currentState!
//                           .validate()) {
//                         context
//                             .couponCodeProvider.addCouponFormKey.currentState!
//                             .save();
//                         context.couponCodeProvider.submitCoupon();
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

// // How to show the popup
// void showAddCouponForm(BuildContext context, Coupon? coupon) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         title: Center(
//             child: Text('Add Coupon'.toUpperCase(),
//                 style: TextStyle(color: primaryColor))),
//         content: CouponSubmitForm(coupon: coupon),
//       );
//     },
//   );
// }

import '../../../models/product.dart';
import '../../../models/sub_category.dart';
import '../provider/coupon_code_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../models/category.dart';
import '../../../models/coupon.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';

class CouponSubmitForm extends StatelessWidget {
  final Coupon? coupon;
  const CouponSubmitForm({Key? key, this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final padding = AppSpacing.cardPadding(context);
    final gap = AppSpacing.sectionGap(context);
    final smallGap = AppSpacing.itemGap(context);

    context.couponCodeProvider.setDataForUpdateCoupon(coupon);

    return SingleChildScrollView(
      child: Form(
        key: context.couponCodeProvider.addCouponFormKey,
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

              // ── Row 1: Coupon Code + Discount Type ────────────────────
              isMobile
                  ? Column(children: [
                      _couponCodeField(context),
                      Gap(smallGap),
                      _discountTypeDropdown(context),
                    ])
                  : Row(children: [
                      Expanded(child: _couponCodeField(context)),
                      SizedBox(width: smallGap),
                      Expanded(child: _discountTypeDropdown(context)),
                    ]),

              Gap(gap),

              // ── Row 2: Discount Amount + Min Purchase ─────────────────
              isMobile
                  ? Column(children: [
                      _discountAmountField(context),
                      Gap(smallGap),
                      _minPurchaseField(context),
                    ])
                  : Row(children: [
                      Expanded(child: _discountAmountField(context)),
                      SizedBox(width: smallGap),
                      Expanded(child: _minPurchaseField(context)),
                    ]),

              Gap(gap),

              // ── Row 3: End Date + Status ──────────────────────────────
              isMobile
                  ? Column(children: [
                      _endDatePicker(context),
                      Gap(smallGap),
                      _statusDropdown(context),
                    ])
                  : Row(children: [
                      Expanded(child: _endDatePicker(context)),
                      SizedBox(width: smallGap),
                      Expanded(child: _statusDropdown(context)),
                    ]),

              Gap(gap),

              // ── Optional scope note ───────────────────────────────────
              Text(
                "Apply Coupon On any of the following (optional)",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: AppFontSize.sm(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: smallGap / 2),
              Text(
                "Note: Selecting a category applies to all products in it. "
                "Selecting a sub-category applies to all products in it. "
                "Selecting a product applies only to that product. "
                "Selecting none applies to the entire store.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: AppFontSize.xs(context),
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),

              Gap(gap),

              // ── Row 4: Category + Sub Category + Product ─────────────
              // Mobile: stacked; Tablet+: 3-column row
              isMobile
                  ? Column(children: [
                      _categoryDropdown(context),
                      Gap(smallGap),
                      _subCategoryDropdown(context),
                      Gap(smallGap),
                      _productDropdown(context),
                    ])
                  : Row(children: [
                      Expanded(child: _categoryDropdown(context)),
                      SizedBox(width: smallGap),
                      Expanded(child: _subCategoryDropdown(context)),
                      SizedBox(width: smallGap),
                      Expanded(child: _productDropdown(context)),
                    ]),

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
                          .couponCodeProvider.addCouponFormKey.currentState!
                          .validate()) {
                        context
                            .couponCodeProvider.addCouponFormKey.currentState!
                            .save();
                        context.couponCodeProvider.submitCoupon();
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

  Widget _couponCodeField(BuildContext context) => CustomTextField(
        controller: context.couponCodeProvider.couponCodeCtrl,
        labelText: 'Coupon Code',
        onSave: (val) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter coupon code';
          }
          return null;
        },
      );

  Widget _discountTypeDropdown(BuildContext context) => CustomDropdown(
        key: GlobalKey(),
        hintText: 'Discount Type',
        items: const ['fixed', 'percentage'],
        initialValue: context.couponCodeProvider.selectedDiscountType,
        onChanged: (newValue) {
          context.couponCodeProvider.selectedDiscountType = newValue ?? 'fixed';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a discount type';
          }
          return null;
        },
        displayItem: (val) => val,
      );

  Widget _discountAmountField(BuildContext context) {
    return Consumer<CouponCodeProvider>(
      builder: (context, provider, child) {
        final isFixed = provider.selectedDiscountType == 'fixed';
        return CustomTextField(
          controller: provider.discountAmountCtrl,
          labelText: isFixed ? 'Discount Amount' : 'Discount Percentage',
          inputType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return isFixed
                  ? 'Please enter discount amount'
                  : 'Please enter discount percentage';
            }
            if (!isFixed && double.tryParse(value)! > 100) {
              return 'Percentage cannot exceed 100%';
            }
            return null;
          },
          onSave: (String? p1) {},
        );
      },
    );
  }

  Widget _minPurchaseField(BuildContext context) => CustomTextField(
        controller: context.couponCodeProvider.minimumPurchaseAmountCtrl,
        labelText: 'Minimum Purchase Amount',
        inputType: TextInputType.number,
        onSave: (val) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter minimum amount';
          }
          return null;
        },
      );

  Widget _endDatePicker(BuildContext context) => CustomDatePicker(
        labelText: 'Select Coupon End Date',
        controller: context.couponCodeProvider.endDateCtrl,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        onDateSelected: (DateTime date) {},
      );

  Widget _statusDropdown(BuildContext context) => CustomDropdown(
        key: GlobalKey(),
        hintText: 'Status',
        initialValue: context.couponCodeProvider.selectedCouponStatus,
        items: const ['active', 'inactive'],
        displayItem: (val) => val,
        onChanged: (newValue) {
          context.couponCodeProvider.selectedCouponStatus =
              newValue ?? 'active';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select status';
          }
          return null;
        },
      );

  Widget _categoryDropdown(BuildContext context) {
    return Consumer<CouponCodeProvider>(
      builder: (context, couponProvider, child) {
        return CustomDropdown(
          initialValue: couponProvider.selectedCategory,
          hintText: couponProvider.selectedCategory?.name ?? 'Select category',
          items: context.dataProvider.categories,
          displayItem: (Category? category) => category?.name ?? '',
          onChanged: (newValue) {
            if (newValue != null) {
              couponProvider.selectedSubCategory = null;
              couponProvider.selectedProduct = null;
              couponProvider.selectedCategory = newValue;
              couponProvider.updateUi();
            }
          },
        );
      },
    );
  }

  Widget _subCategoryDropdown(BuildContext context) {
    return Consumer<CouponCodeProvider>(
      builder: (context, couponProvider, child) {
        return CustomDropdown(
          initialValue: couponProvider.selectedSubCategory,
          hintText:
              couponProvider.selectedSubCategory?.name ?? 'Select sub category',
          items: context.dataProvider.subCategories,
          displayItem: (SubCategory? s) => s?.name ?? '',
          onChanged: (newValue) {
            if (newValue != null) {
              couponProvider.selectedCategory = null;
              couponProvider.selectedProduct = null;
              couponProvider.selectedSubCategory = newValue;
              couponProvider.updateUi();
            }
          },
        );
      },
    );
  }

  Widget _productDropdown(BuildContext context) {
    return Consumer<CouponCodeProvider>(
      builder: (context, couponProvider, child) {
        return CustomDropdown(
          initialValue: couponProvider.selectedProduct,
          hintText: couponProvider.selectedProduct?.name ?? 'Select product',
          items: context.dataProvider.products,
          displayItem: (Product? product) => product?.name ?? '',
          onChanged: (newValue) {
            if (newValue != null) {
              couponProvider.selectedCategory = null;
              couponProvider.selectedSubCategory = null;
              couponProvider.selectedProduct = newValue;
              couponProvider.updateUi();
            }
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DIALOG LAUNCHER
// ─────────────────────────────────────────────────────────────────────────────
void showAddCouponForm(BuildContext context, Coupon? coupon) {
  final w = MediaQuery.of(context).size.width;

  // Coupon form is wide (was 0.7) — keep it generous
  final double dialogWidth = () {
    if (w < AppBreakpoints.mobileS) return w * 0.95;
    if (w < AppBreakpoints.mobileL) return w * 0.92;
    if (w < AppBreakpoints.tablet) return w * 0.88;
    if (w < AppBreakpoints.webS) return w * 0.72;
    return w * 0.62;
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
            'ADD COUPON',
            style: TextStyle(
              color: primaryColor,
              fontSize: AppFontSize.lg(context),
            ),
          ),
        ),
        content: SizedBox(
          width: dialogWidth,
          child: CouponSubmitForm(coupon: coupon),
        ),
      );
    },
  );
}
