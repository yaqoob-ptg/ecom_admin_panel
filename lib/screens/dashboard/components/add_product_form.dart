// import '../../../models/brand.dart';
// import '../../../models/category.dart';
// import '../../../models/product.dart';
// import '../../../models/sub_category.dart';
// import '../../../models/variant_type.dart';
// import '../provider/dash_board_provider.dart';
// import '../../../utility/extensions.dart';
// import '../../../widgets/multi_select_drop_down.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utility/constants.dart';
// import '../../../widgets/custom_dropdown.dart';
// import '../../../widgets/custom_text_field.dart';
// import '../../../widgets/product_image_card.dart';

// class ProductSubmitForm extends StatelessWidget {
//   final Product? product;

//   const ProductSubmitForm({super.key, this.product});

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     context.dashBoardProvider.setDataForUpdateProduct(product);
//     return SingleChildScrollView(
//       child: Form(
//         key: context.dashBoardProvider.addProductFormKey,
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
//               SizedBox(height: defaultPadding),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return ProductImageCard(
//                         labelText: 'Main Image',
//                         imageFile: dashProvider.selectedMainImage,
//                         imageUrlForUpdateImage:
//                             product?.images.safeElementAt(0)?.fullUrl,
//                         onTap: () {
//                           dashProvider.pickImage(imageCardNumber: 1);
//                         },
//                         onRemoveImage: () {
//                           dashProvider.selectedMainImage = null;
//                           dashProvider.updateUI();
//                         },
//                       );
//                     },
//                   ),
//                   Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return ProductImageCard(
//                         labelText: 'Second image',
//                         imageFile: dashProvider.selectedSecondImage,
//                         imageUrlForUpdateImage:
//                             product?.images.safeElementAt(1)?.fullUrl,
//                         onTap: () {
//                           dashProvider.pickImage(imageCardNumber: 2);
//                         },
//                         onRemoveImage: () {
//                           dashProvider.selectedSecondImage = null;
//                           dashProvider.updateUI();
//                         },
//                       );
//                     },
//                   ),
//                   Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return ProductImageCard(
//                         labelText: 'Third image',
//                         imageFile: dashProvider.selectedThirdImage,
//                         imageUrlForUpdateImage:
//                             product?.images.safeElementAt(2)?.fullUrl,
//                         onTap: () {
//                           dashProvider.pickImage(imageCardNumber: 3);
//                         },
//                         onRemoveImage: () {
//                           dashProvider.selectedThirdImage = null;
//                           dashProvider.updateUI();
//                         },
//                       );
//                     },
//                   ),
//                   Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return ProductImageCard(
//                         labelText: 'Fourth image',
//                         imageFile: dashProvider.selectedFourthImage,
//                         imageUrlForUpdateImage:
//                             product?.images.safeElementAt(3)?.fullUrl,
//                         onTap: () {
//                           dashProvider.pickImage(imageCardNumber: 4);
//                         },
//                         onRemoveImage: () {
//                           dashProvider.selectedFourthImage = null;
//                           dashProvider.updateUI();
//                         },
//                       );
//                     },
//                   ),
//                   Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return ProductImageCard(
//                         labelText: 'Fifth image',
//                         imageFile: dashProvider.selectedFifthImage,
//                         imageUrlForUpdateImage:
//                             product?.images.safeElementAt(4)?.fullUrl,
//                         onTap: () {
//                           dashProvider.pickImage(imageCardNumber: 5);
//                         },
//                         onRemoveImage: () {
//                           dashProvider.selectedFifthImage = null;
//                           dashProvider.updateUI();
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: defaultPadding),
//               CustomTextField(
//                 controller: context.dashBoardProvider.productNameCtrl,
//                 labelText: 'Product Name',
//                 onSave: (val) {},
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter name';
//                   }
//                 },
//               ),
//               SizedBox(height: defaultPadding),
//               CustomTextField(
//                 controller: context.dashBoardProvider.productDescCtrl,
//                 labelText: 'Product Description',
//                 lineNumber: 3,
//                 onSave: (val) {},
//               ),
//               SizedBox(height: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(child: Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return CustomDropdown(
//                         key: ValueKey(dashProvider.selectedCategory?.sId),
//                         initialValue: dashProvider.selectedCategory,
//                         hintText: dashProvider.selectedCategory?.name ??
//                             'Select category',
//                         items: context.dataProvider.categories,
//                         displayItem: (Category? category) =>
//                             category?.name ?? '',
//                         onChanged: (newValue) {
//                           if (newValue != null) {
//                             context.dashBoardProvider
//                                 .filterSubcategory(newValue);
//                           }
//                         },
//                         validator: (value) {
//                           if (value == null) {
//                             return 'Please select a category';
//                           }
//                           return null;
//                         },
//                       );
//                     },
//                   )),
//                   Expanded(child: Consumer<DashBoardProvider>(
//                     builder: (context, dashProvider, child) {
//                       return CustomDropdown(
//                         key: ValueKey(dashProvider.selectedSubCategory?.sId),
//                         hintText: dashProvider.selectedSubCategory?.name ??
//                             'Sub category',
//                         items: dashProvider.subCategoriesByCategory,
//                         initialValue: dashProvider.selectedSubCategory,
//                         displayItem: (SubCategory? subCategory) =>
//                             subCategory?.name ?? '',
//                         onChanged: (newValue) {
//                           if (newValue != null) {
//                             context.dashBoardProvider.filterBrand(newValue);
//                           }
//                         },
//                         validator: (value) {
//                           if (value == null) {
//                             return 'Please select sub category';
//                           }
//                           return null;
//                         },
//                       );
//                     },
//                   )),
//                   Expanded(
//                     child: Consumer<DashBoardProvider>(
//                       builder: (context, dashProvider, child) {
//                         return CustomDropdown(
//                             key: ValueKey(dashProvider.selectedBrand?.sId),
//                             initialValue: dashProvider.selectedBrand,
//                             items: dashProvider.brandsBySubCategory,
//                             hintText: dashProvider.selectedBrand?.name ??
//                                 'Select Brand',
//                             displayItem: (Brand? brand) => brand?.name ?? '',
//                             onChanged: (newValue) {
//                               if (newValue != null) {
//                                 dashProvider.selectedBrand = newValue;
//                                 dashProvider.updateUI();
//                               }
//                             },
//                             validator: (value) {
//                               if (value == null) {
//                                 return 'Please brand';
//                               }
//                               return null;
//                             });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.dashBoardProvider.productPriceCtrl,
//                       labelText: 'Price',
//                       inputType: TextInputType.number,
//                       onSave: (val) {},
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please enter price';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.dashBoardProvider.productOffPriceCtrl,
//                       labelText: 'Offer price',
//                       inputType: TextInputType.number,
//                       onSave: (val) {},
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomTextField(
//                       controller: context.dashBoardProvider.productQntCtrl,
//                       labelText: 'Quantity',
//                       inputType: TextInputType.number,
//                       onSave: (val) {},
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please enter quantity';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(width: defaultPadding),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Consumer<DashBoardProvider>(
//                       builder: (context, dashProvider, child) {
//                         return CustomDropdown(
//                           key: ValueKey(dashProvider.selectedVariantType?.sId),
//                           initialValue: dashProvider.selectedVariantType,
//                           items: context.dataProvider.variantTypes,
//                           displayItem: (VariantType? variantType) =>
//                               variantType?.name ?? '',
//                           onChanged: (newValue) {
//                             if (newValue != null) {
//                               context.dashBoardProvider.filterVariant(newValue);
//                             }
//                           },
//                           hintText: 'Select Variant type',
//                         );
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Consumer<DashBoardProvider>(
//                       builder: (context, dashProvider, child) {
//                         final filteredSelectedItems = dashProvider
//                             .selectedVariants
//                             .where((item) => dashProvider.variantsByVariantType
//                                 .contains(item))
//                             .toList();
//                         return MultiSelectDropDown(
//                           items: dashProvider.variantsByVariantType,
//                           onSelectionChanged: (newValue) {
//                             dashProvider.selectedVariants = newValue;
//                             dashProvider.updateUI();
//                           },
//                           displayItem: (String item) => item,
//                           selectedItems: filteredSelectedItems,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: defaultPadding),
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
//                           .dashBoardProvider.addProductFormKey.currentState!
//                           .validate()) {
//                         context
//                             .dashBoardProvider.addProductFormKey.currentState!
//                             .save();
//                         context.dashBoardProvider.submitProduct();

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
// void showAddProductForm(BuildContext context, Product? product) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         title: Center(
//             child: Text('Add Product'.toUpperCase(),
//                 style: TextStyle(color: primaryColor))),
//         content: ProductSubmitForm(product: product),
//       );
//     },
//   );
// }

// extension SafeList<T> on List<T>? {
//   T? safeElementAt(int index) {
//     // Check if the list is null or if the index is out of range
//     if (this == null || index < 0 || index >= this!.length) {
//       return null;
//     }
//     return this![index];
//   }
// }

//responsive
import '../../../models/brand.dart';
import '../../../models/category.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';
import '../../../models/variant_type.dart';
import '../provider/dash_board_provider.dart';
import '../../../utility/extensions.dart';
import '../../../widgets/multi_select_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/product_image_card.dart';

class ProductSubmitForm extends StatelessWidget {
  final Product? product;
  const ProductSubmitForm({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = AppBreakpoints.isMobile(context);
    final isTablet = AppBreakpoints.isTablet(context);
    final padding = AppSpacing.cardPadding(context);
    final gap = AppSpacing.sectionGap(context);
    final smallGap = AppSpacing.itemGap(context);

    context.dashBoardProvider.setDataForUpdateProduct(product);

    // Image cards: wrap on mobile (2 per row), row on tablet+
    final int imgCrossAxisCount = isMobile ? 3 : 5;
    final double imgCardSize = isMobile
        ? (w * 0.55) / 3 // 3 per row on mobile, fits dialog width
        : isTablet
            ? 90.0
            : 110.0;

    return SingleChildScrollView(
      child: Form(
        key: context.dashBoardProvider.addProductFormKey,
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
              SizedBox(height: smallGap),

              // ── Image cards ───────────────────────────────────────────
              _buildImageCards(
                  context, imgCrossAxisCount, imgCardSize, smallGap),

              SizedBox(height: gap),

              // ── Product name ──────────────────────────────────────────
              CustomTextField(
                controller: context.dashBoardProvider.productNameCtrl,
                labelText: 'Product Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter name';
                  return null;
                },
              ),
              SizedBox(height: gap),

              // ── Description ───────────────────────────────────────────
              CustomTextField(
                controller: context.dashBoardProvider.productDescCtrl,
                labelText: 'Product Description',
                lineNumber: 3,
                onSave: (val) {},
              ),
              SizedBox(height: gap),

              // ── Category / Sub-category / Brand ───────────────────────
              // Mobile: stacked; Tablet+: row
              isMobile
                  ? _buildCategoryFieldsColumn(context, gap)
                  : _buildCategoryFieldsRow(context),

              SizedBox(height: gap),

              // ── Price / Offer price / Quantity ────────────────────────
              isMobile
                  ? _buildPriceFieldsColumn(context, gap)
                  : _buildPriceFieldsRow(context),

              SizedBox(height: gap),

              // ── Variant type / Variants ───────────────────────────────
              isMobile
                  ? _buildVariantFieldsColumn(context, gap)
                  : _buildVariantFieldsRow(context),

              SizedBox(height: gap),

              // ── Action buttons ────────────────────────────────────────
              _buildActionButtons(context, gap),
            ],
          ),
        ),
      ),
    );
  }

  // ── Image cards ───────────────────────────────────────────────────────────
  Widget _buildImageCards(
      BuildContext context, int count, double size, double gap) {
    final List<
        ({
          String label,
          int cardNum,
          dynamic Function(DashBoardProvider) getImage,
          String? Function(Product?) getUrl,
          void Function(DashBoardProvider) onRemove
        })> cards = [
      (
        label: 'Main Image',
        cardNum: 1,
        getImage: (p) => p.selectedMainImage,
        getUrl: (pr) => pr?.images.safeElementAt(0)?.fullUrl,
        onRemove: (p) {
          p.selectedMainImage = null;
          p.updateUI();
        }
      ),
      (
        label: 'Second image',
        cardNum: 2,
        getImage: (p) => p.selectedSecondImage,
        getUrl: (pr) => pr?.images.safeElementAt(1)?.fullUrl,
        onRemove: (p) {
          p.selectedSecondImage = null;
          p.updateUI();
        }
      ),
      (
        label: 'Third image',
        cardNum: 3,
        getImage: (p) => p.selectedThirdImage,
        getUrl: (pr) => pr?.images.safeElementAt(2)?.fullUrl,
        onRemove: (p) {
          p.selectedThirdImage = null;
          p.updateUI();
        }
      ),
      (
        label: 'Fourth image',
        cardNum: 4,
        getImage: (p) => p.selectedFourthImage,
        getUrl: (pr) => pr?.images.safeElementAt(3)?.fullUrl,
        onRemove: (p) {
          p.selectedFourthImage = null;
          p.updateUI();
        }
      ),
      (
        label: 'Fifth image',
        cardNum: 5,
        getImage: (p) => p.selectedFifthImage,
        getUrl: (pr) => pr?.images.safeElementAt(4)?.fullUrl,
        onRemove: (p) {
          p.selectedFifthImage = null;
          p.updateUI();
        }
      ),
    ];

    return Wrap(
      spacing: gap,
      runSpacing: gap,
      alignment: WrapAlignment.center,
      children: cards.map((c) {
        return Consumer<DashBoardProvider>(
          builder: (context, dashProvider, _) => SizedBox(
            width: size,
            height: size,
            child: ProductImageCard(
              labelText: c.label,
              imageFile: c.getImage(dashProvider),
              imageUrlForUpdateImage: c.getUrl(product),
              onTap: () => dashProvider.pickImage(imageCardNumber: c.cardNum),
              onRemoveImage: () => c.onRemove(dashProvider),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Category fields — column layout (mobile) ──────────────────────────────
  Widget _buildCategoryFieldsColumn(BuildContext context, double gap) {
    return Column(
      children: [
        _categoryDropdown(context),
        SizedBox(height: gap),
        _subCategoryDropdown(context),
        SizedBox(height: gap),
        _brandDropdown(context),
      ],
    );
  }

  // ── Category fields — row layout (tablet+) ────────────────────────────────
  Widget _buildCategoryFieldsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _categoryDropdown(context)),
        Expanded(child: _subCategoryDropdown(context)),
        Expanded(child: _brandDropdown(context)),
      ],
    );
  }

  Widget _categoryDropdown(BuildContext context) {
    return Consumer<DashBoardProvider>(
      builder: (context, dashProvider, _) => CustomDropdown(
        key: ValueKey(dashProvider.selectedCategory?.sId),
        initialValue: dashProvider.selectedCategory,
        hintText: dashProvider.selectedCategory?.name ?? 'Select category',
        items: context.dataProvider.categories,
        displayItem: (Category? c) => c?.name ?? '',
        onChanged: (newValue) {
          if (newValue != null)
            context.dashBoardProvider.filterSubcategory(newValue);
        },
        validator: (value) => value == null ? 'Please select a category' : null,
      ),
    );
  }

  Widget _subCategoryDropdown(BuildContext context) {
    return Consumer<DashBoardProvider>(
      builder: (context, dashProvider, _) => CustomDropdown(
        key: ValueKey(dashProvider.selectedSubCategory?.sId),
        hintText: dashProvider.selectedSubCategory?.name ?? 'Sub category',
        items: dashProvider.subCategoriesByCategory,
        initialValue: dashProvider.selectedSubCategory,
        displayItem: (SubCategory? s) => s?.name ?? '',
        onChanged: (newValue) {
          if (newValue != null) context.dashBoardProvider.filterBrand(newValue);
        },
        validator: (value) =>
            value == null ? 'Please select sub category' : null,
      ),
    );
  }

  Widget _brandDropdown(BuildContext context) {
    return Consumer<DashBoardProvider>(
      builder: (context, dashProvider, _) => CustomDropdown(
        key: ValueKey(dashProvider.selectedBrand?.sId),
        initialValue: dashProvider.selectedBrand,
        items: dashProvider.brandsBySubCategory,
        hintText: dashProvider.selectedBrand?.name ?? 'Select Brand',
        displayItem: (Brand? b) => b?.name ?? '',
        onChanged: (newValue) {
          if (newValue != null) {
            dashProvider.selectedBrand = newValue;
            dashProvider.updateUI();
          }
        },
        validator: (value) => value == null ? 'Please select brand' : null,
      ),
    );
  }

  // ── Price fields — column layout (mobile) ─────────────────────────────────
  Widget _buildPriceFieldsColumn(BuildContext context, double gap) {
    return Column(
      children: [
        _priceField(context),
        SizedBox(height: gap),
        _offerPriceField(context),
        SizedBox(height: gap),
        _quantityField(context),
      ],
    );
  }

  // ── Price fields — row layout (tablet+) ───────────────────────────────────
  Widget _buildPriceFieldsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _priceField(context)),
        Expanded(child: _offerPriceField(context)),
        Expanded(child: _quantityField(context)),
      ],
    );
  }

  Widget _priceField(BuildContext context) => CustomTextField(
        controller: context.dashBoardProvider.productPriceCtrl,
        labelText: 'Price',
        inputType: TextInputType.number,
        onSave: (val) {},
        validator: (value) => value == null ? 'Please enter price' : null,
      );

  Widget _offerPriceField(BuildContext context) => CustomTextField(
        controller: context.dashBoardProvider.productOffPriceCtrl,
        labelText: 'Offer price',
        inputType: TextInputType.number,
        onSave: (val) {},
      );

  Widget _quantityField(BuildContext context) => CustomTextField(
        controller: context.dashBoardProvider.productQntCtrl,
        labelText: 'Quantity',
        inputType: TextInputType.number,
        onSave: (val) {},
        validator: (value) => value == null ? 'Please enter quantity' : null,
      );

  // ── Variant fields — column layout (mobile) ───────────────────────────────
  Widget _buildVariantFieldsColumn(BuildContext context, double gap) {
    return Column(
      children: [
        _variantTypeDropdown(context),
        SizedBox(height: gap),
        _variantMultiSelect(context),
      ],
    );
  }

  // ── Variant fields — row layout (tablet+) ────────────────────────────────
  Widget _buildVariantFieldsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _variantTypeDropdown(context)),
        Expanded(child: _variantMultiSelect(context)),
      ],
    );
  }

  Widget _variantTypeDropdown(BuildContext context) {
    return Consumer<DashBoardProvider>(
      builder: (context, dashProvider, _) => CustomDropdown(
        key: ValueKey(dashProvider.selectedVariantType?.sId),
        initialValue: dashProvider.selectedVariantType,
        items: context.dataProvider.variantTypes,
        displayItem: (VariantType? v) => v?.name ?? '',
        onChanged: (newValue) {
          if (newValue != null)
            context.dashBoardProvider.filterVariant(newValue);
        },
        hintText: 'Select Variant type',
      ),
    );
  }

  Widget _variantMultiSelect(BuildContext context) {
    return Consumer<DashBoardProvider>(
      builder: (context, dashProvider, _) {
        final filteredSelectedItems = dashProvider.selectedVariants
            .where((item) => dashProvider.variantsByVariantType.contains(item))
            .toList();
        return MultiSelectDropDown(
          items: dashProvider.variantsByVariantType,
          onSelectionChanged: (newValue) {
            dashProvider.selectedVariants = newValue;
            dashProvider.updateUI();
          },
          displayItem: (String item) => item,
          selectedItems: filteredSelectedItems,
        );
      },
    );
  }

  // ── Action buttons ────────────────────────────────────────────────────────
  Widget _buildActionButtons(BuildContext context, double gap) {
    final isMobile = AppBreakpoints.isMobile(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isMobile) const Spacer(),
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
        SizedBox(width: gap),
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
            if (context.dashBoardProvider.addProductFormKey.currentState!
                .validate()) {
              context.dashBoardProvider.addProductFormKey.currentState!.save();
              context.dashBoardProvider.submitProduct();
              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Submit',
            style: TextStyle(fontSize: AppFontSize.body(context)),
          ),
        ),
        if (isMobile) const Spacer(),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DIALOG LAUNCHER  — responsive dialog width
// ─────────────────────────────────────────────────────────────────────────────
void showAddProductForm(BuildContext context, Product? product) {
  final w = MediaQuery.of(context).size.width;

  // Dialog takes most of the screen on mobile, capped on desktop
  final double dialogWidth = () {
    if (w < AppBreakpoints.mobileS) return w * 0.95;
    if (w < AppBreakpoints.mobileL) return w * 0.92;
    if (w < AppBreakpoints.tablet) return w * 0.85;
    if (w < AppBreakpoints.webS) return w * 0.75;
    return w * 0.65; // web: original ~0.7 feel
  }();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        // Remove default insets so we control the width ourselves
        insetPadding: EdgeInsets.symmetric(
          horizontal: (w - dialogWidth) / 2,
          vertical: 24,
        ),
        title: Center(
          child: Text(
            'ADD PRODUCT',
            style: TextStyle(
              color: primaryColor,
              fontSize: AppFontSize.lg(context),
            ),
          ),
        ),
        content: SizedBox(
          width: dialogWidth,
          child: ProductSubmitForm(product: product),
        ),
      );
    },
  );
}

// ─────────────────────────────────────────────────────────────────────────────
//  EXTENSION
// ─────────────────────────────────────────────────────────────────────────────
extension SafeList<T> on List<T>? {
  T? safeElementAt(int index) {
    if (this == null || index < 0 || index >= this!.length) return null;
    return this![index];
  }
}
