// import '../../../models/order.dart';
// import '../../../utility/constants.dart';
// import '../../../utility/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import '../../../widgets/custom_dropdown.dart';
// import '../../../widgets/custom_text_field.dart';
// import '../provider/order_provider.dart';

// class OrderSubmitForm extends StatelessWidget {
//   final Order? order;

//   const OrderSubmitForm({Key? key, this.order}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     context.orderProvider.trackingUrlCtrl.text = order?.trackingUrl ?? '';
//     context.orderProvider.orderForUpdate = order;
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.all(defaultPadding),
//         width: size.width * 0.5, // Adjust width based on screen size
//         decoration: BoxDecoration(
//           color: bgColor,
//           borderRadius: BorderRadius.circular(12.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Form(
//           key: Provider.of<OrderProvider>(context, listen: false).orderFormKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                       child: formRow(
//                           'Name:',
//                           Text(order?.userID?.name ?? 'N/A',
//                               style: TextStyle(fontSize: 16)))),
//                   Expanded(
//                       child: formRow(
//                           'Order Id:',
//                           Text(order?.sId ?? 'N/A',
//                               style: TextStyle(fontSize: 12)))),
//                 ],
//               ),
//               itemsSection(),
//               addressSection(),
//               Gap(10),
//               paymentDetailsSection(),
//               formRow(
//                 'Order Status:',
//                 Consumer<OrderProvider>(
//                   builder: (context, orderProvider, child) {
//                     return CustomDropdown(
//                       hintText: 'Status',
//                       initialValue: orderProvider.selectedOrderStatus,
//                       items: [
//                         'pending',
//                         'processing',
//                         'shipped',
//                         'delivered',
//                         'cancelled'
//                       ],
//                       displayItem: (val) => val,
//                       onChanged: (newValue) {
//                         orderProvider.selectedOrderStatus =
//                             newValue ?? 'pending';
//                         orderProvider.updateUI();
//                       },
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please select status';
//                         }
//                         return null;
//                       },
//                     );
//                   },
//                 ),
//               ),
//               formRow(
//                   'Tracking URL:',
//                   CustomTextField(
//                     labelText: 'Tracking Url',
//                     onSave: (val) {},
//                     controller: context.orderProvider.trackingUrlCtrl,
//                   )),
//               Gap(defaultPadding * 2),
//               actionButtons(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget formRow(String label, Widget dataWidget) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//               flex: 1,
//               child: Text(label,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
//           Expanded(flex: 2, child: dataWidget),
//         ],
//       ),
//     );
//   }

//   Widget addressSection() {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: secondaryColor, // Light grey background to stand out
//         borderRadius: BorderRadius.circular(8.0),
//         border:
//             Border.all(color: Colors.blueAccent), // Blue border for emphasis
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.0),
//             child: Text(
//               'Shipping Address',
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent),
//             ),
//           ),
//           formRow(
//               'Phone:',
//               Text(order?.shippingAddress?.phone ?? 'N/A',
//                   style: TextStyle(fontSize: 16))),
//           formRow(
//               'Street:',
//               Text(order?.shippingAddress?.street ?? 'N/A',
//                   style: TextStyle(fontSize: 16))),
//           formRow(
//               'City:',
//               Text(order?.shippingAddress?.city ?? 'N/A',
//                   style: TextStyle(fontSize: 16))),
//           formRow(
//               'Postal Code:',
//               Text(order?.shippingAddress?.postalCode ?? 'N/A',
//                   style: TextStyle(fontSize: 16))),
//           formRow(
//               'Country:',
//               Text(order?.shippingAddress?.country ?? 'N/A',
//                   style: TextStyle(fontSize: 16))),
//         ],
//       ),
//     );
//   }

//   Widget paymentDetailsSection() {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         border: Border.all(color: Colors.blueAccent),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: Offset(0, 1),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.0),
//             child: Text(
//               'Payment Details',
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: primaryColor),
//             ),
//           ),
//           formRow(
//               'Payment Method:',
//               Text(order?.paymentMethod ?? 'N/A',
//                   style: TextStyle(fontSize: 16))),
//           formRow(
//               'Coupon Code:',
//               Text(order?.couponCode?.couponCode ?? 'N/A',
//                   style: TextStyle(fontSize: 16))),
//           formRow(
//               'Order Sub Total:',
//               Text(
//                   '\$${order?.orderTotal?.subtotal?.toStringAsFixed(2) ?? 'N/A'}',
//                   style: TextStyle(fontSize: 16))),
//           formRow(
//               'Discount:',
//               Text(
//                   '\$${order?.orderTotal?.discount?.toStringAsFixed(2) ?? 'N/A'}',
//                   style: TextStyle(fontSize: 16, color: Colors.red))),
//           formRow(
//               'Grand Total:',
//               Text('\$${order?.orderTotal?.total?.toStringAsFixed(2) ?? 'N/A'}',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
//         ],
//       ),
//     );
//   }

//   Widget itemsSection() {
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         border: Border.all(color: Colors.blueAccent),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: Offset(0, 1),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.0),
//             child: Text(
//               'Items',
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: primaryColor),
//             ),
//           ),
//           _buildItemsList(),
//           SizedBox(height: defaultPadding),
//           // Add some spacing before the total price
//           formRow(
//             'Total Price:',
//             Text('\$${order?.totalPrice?.toStringAsFixed(2) ?? 'N/A'}',
//                 style: TextStyle(fontSize: 16, color: Colors.green)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildItemsList() {
//     if (order?.items == null || order!.items!.isEmpty) {
//       return Text('No items', style: TextStyle(fontSize: 16));
//     }
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       // Disable scrolling within ListView
//       itemCount: order!.items!.length,
//       itemBuilder: (context, index) {
//         final item = order!.items![index];
//         return Padding(
//           padding: EdgeInsets.only(bottom: 4.0), // Add spacing between items
//           child: Text(
//               '${item.productName}: ${item.quantity} x \$${item.price?.toStringAsFixed(2)}',
//               style: TextStyle(fontSize: 16)),
//         );
//       },
//     );
//   }

//   Widget actionButtons(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text('Cancel'),
//         ),
//         Gap(defaultPadding),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
//           onPressed: () {
//             if (Provider.of<OrderProvider>(context, listen: false)
//                 .orderFormKey
//                 .currentState!
//                 .validate()) {
//               Provider.of<OrderProvider>(context, listen: false)
//                   .orderFormKey
//                   .currentState!
//                   .save();
//               // call updateOrder
//               context.orderProvider.updateOrder();
//               Navigator.of(context).pop();
//             }
//           },
//           child: const Text('Submit'),
//         ),
//       ],
//     );
//   }
// }

// // How to show the order popup
// void showOrderForm(BuildContext context, Order? order) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: bgColor,
//         title: Center(
//             child: Text('Order Details'.toUpperCase(),
//                 style: TextStyle(color: primaryColor))),
//         content: OrderSubmitForm(order: order),
//       );
//     },
//   );
// }

import '../../../models/order.dart';
import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../utility/responsive_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../provider/order_provider.dart';

class OrderSubmitForm extends StatelessWidget {
  final Order? order;
  const OrderSubmitForm({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final padding = AppSpacing.cardPadding(context);
    final gap = AppSpacing.sectionGap(context);

    context.orderProvider.trackingUrlCtrl.text = order?.trackingUrl ?? '';
    context.orderProvider.orderForUpdate = order;

    return SingleChildScrollView(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Form(
          key: Provider.of<OrderProvider>(context, listen: false).orderFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(gap),

              // Name + Order ID — stack on mobile, row on tablet+
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _formRow(
                            context,
                            'Name:',
                            Text(order?.userID?.name ?? 'N/A',
                                style: TextStyle(
                                    fontSize: AppFontSize.body(context)))),
                        _formRow(
                            context,
                            'Order Id:',
                            Text(order?.sId ?? 'N/A',
                                style: TextStyle(
                                    fontSize: AppFontSize.sm(context)))),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                            child: _formRow(
                                context,
                                'Name:',
                                Text(order?.userID?.name ?? 'N/A',
                                    style: TextStyle(
                                        fontSize: AppFontSize.body(context))))),
                        Expanded(
                            child: _formRow(
                                context,
                                'Order Id:',
                                Text(order?.sId ?? 'N/A',
                                    style: TextStyle(
                                        fontSize: AppFontSize.sm(context))))),
                      ],
                    ),

              Gap(gap),
              _itemsSection(context),
              Gap(gap),
              _addressSection(context),
              Gap(gap),
              _paymentDetailsSection(context),
              Gap(gap),

              // Order status dropdown
              _formRow(
                context,
                'Order Status:',
                Consumer<OrderProvider>(
                  builder: (context, orderProvider, child) {
                    return CustomDropdown(
                      hintText: 'Status',
                      initialValue: orderProvider.selectedOrderStatus,
                      items: [
                        'pending',
                        'processing',
                        'shipped',
                        'delivered',
                        'cancelled'
                      ],
                      displayItem: (val) => val,
                      onChanged: (newValue) {
                        orderProvider.selectedOrderStatus =
                            newValue ?? 'pending';
                        orderProvider.updateUI();
                      },
                      validator: (value) {
                        if (value == null) return 'Please select status';
                        return null;
                      },
                    );
                  },
                ),
              ),

              // Tracking URL
              _formRow(
                context,
                'Tracking URL:',
                CustomTextField(
                  labelText: 'Tracking Url',
                  onSave: (val) {},
                  controller: context.orderProvider.trackingUrlCtrl,
                ),
              ),

              Gap(gap * 1.5),
              _actionButtons(context),
              Gap(gap * 0.5),
            ],
          ),
        ),
      ),
    );
  }

  // ── Form row — label left, content right ─────────────────────────────────
  Widget _formRow(BuildContext context, String label, Widget dataWidget) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.body(context),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm(context)),
          Expanded(child: dataWidget),
        ],
      ),
    );
  }

  // ── Items section ─────────────────────────────────────────────────────────
  Widget _itemsSection(BuildContext context) {
    return _InfoCard(
      title: 'Items',
      titleColor: primaryColor,
      children: [
        if (order?.items == null || order!.items!.isEmpty)
          Text('No items',
              style: TextStyle(fontSize: AppFontSize.body(context)))
        else
          ...order!.items!.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '${item.productName}: ${item.quantity} x \$${item.price?.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: AppFontSize.body(context)),
                ),
              )),
        SizedBox(height: AppSpacing.sm(context)),
        _formRow(
          context,
          'Total Price:',
          Text(
            '\$${order?.totalPrice?.toStringAsFixed(2) ?? 'N/A'}',
            style: TextStyle(
                fontSize: AppFontSize.body(context), color: Colors.green),
          ),
        ),
      ],
    );
  }

  // ── Address section ───────────────────────────────────────────────────────
  Widget _addressSection(BuildContext context) {
    return _InfoCard(
      title: 'Shipping Address',
      titleColor: Colors.blueAccent,
      children: [
        _formRow(
            context,
            'Phone:',
            Text(order?.shippingAddress?.phone ?? 'N/A',
                style: TextStyle(fontSize: AppFontSize.body(context)))),
        _formRow(
            context,
            'Street:',
            Text(order?.shippingAddress?.street ?? 'N/A',
                style: TextStyle(fontSize: AppFontSize.body(context)))),
        _formRow(
            context,
            'City:',
            Text(order?.shippingAddress?.city ?? 'N/A',
                style: TextStyle(fontSize: AppFontSize.body(context)))),
        _formRow(
            context,
            'Postal Code:',
            Text(order?.shippingAddress?.postalCode ?? 'N/A',
                style: TextStyle(fontSize: AppFontSize.body(context)))),
        _formRow(
            context,
            'Country:',
            Text(order?.shippingAddress?.country ?? 'N/A',
                style: TextStyle(fontSize: AppFontSize.body(context)))),
      ],
    );
  }

  // ── Payment details section ───────────────────────────────────────────────
  Widget _paymentDetailsSection(BuildContext context) {
    return _InfoCard(
      title: 'Payment Details',
      titleColor: primaryColor,
      children: [
        _formRow(
            context,
            'Payment Method:',
            Text(order?.paymentMethod ?? 'N/A',
                style: TextStyle(fontSize: AppFontSize.body(context)))),
        _formRow(
            context,
            'Coupon Code:',
            Text(order?.couponCode?.couponCode ?? 'N/A',
                style: TextStyle(fontSize: AppFontSize.body(context)))),
        _formRow(
          context,
          'Sub Total:',
          Text(
            '\$${order?.orderTotal?.subtotal?.toStringAsFixed(2) ?? 'N/A'}',
            style: TextStyle(fontSize: AppFontSize.body(context)),
          ),
        ),
        _formRow(
          context,
          'Discount:',
          Text(
            '\$${order?.orderTotal?.discount?.toStringAsFixed(2) ?? 'N/A'}',
            style: TextStyle(
                fontSize: AppFontSize.body(context), color: Colors.red),
          ),
        ),
        _formRow(
          context,
          'Grand Total:',
          Text(
            '\$${order?.orderTotal?.total?.toStringAsFixed(2) ?? 'N/A'}',
            style: TextStyle(
                fontSize: AppFontSize.body(context),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // ── Action buttons ────────────────────────────────────────────────────────
  Widget _actionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md(context),
              vertical: AppSpacing.sm(context),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel',
              style: TextStyle(fontSize: AppFontSize.body(context))),
        ),
        Gap(AppSpacing.sectionGap(context)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md(context),
              vertical: AppSpacing.sm(context),
            ),
          ),
          onPressed: () {
            final provider = Provider.of<OrderProvider>(context, listen: false);
            if (provider.orderFormKey.currentState!.validate()) {
              provider.orderFormKey.currentState!.save();
              context.orderProvider.updateOrder();
              Navigator.of(context).pop();
            }
          },
          child: Text('Submit',
              style: TextStyle(fontSize: AppFontSize.body(context))),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  REUSABLE INFO CARD  (items / address / payment sections)
// ─────────────────────────────────────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final String title;
  final Color titleColor;
  final List<Widget> children;

  const _InfoCard({
    required this.title,
    required this.titleColor,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding(context),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(AppRadius.sm(context)),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppFontSize.lg(context),
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          SizedBox(height: AppSpacing.sm(context)),
          ...children,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DIALOG LAUNCHER
// ─────────────────────────────────────────────────────────────────────────────
void showOrderForm(BuildContext context, Order? order) {
  final w = MediaQuery.of(context).size.width;

  // Order form is content-heavy — give it more width than simpler forms
  final double dialogWidth = () {
    if (w < AppBreakpoints.mobileS) return w * 0.95;
    if (w < AppBreakpoints.mobileL) return w * 0.92;
    if (w < AppBreakpoints.tablet) return w * 0.85;
    if (w < AppBreakpoints.webS) return w * 0.65;
    return w * 0.55;
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
            'ORDER DETAILS',
            style: TextStyle(
              color: primaryColor,
              fontSize: AppFontSize.lg(context),
            ),
          ),
        ),
        content: SizedBox(
          width: dialogWidth,
          child: OrderSubmitForm(order: order),
        ),
      );
    },
  );
}
