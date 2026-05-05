import 'package:admin/widgets/profile_card.dart';
import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utility/constants.dart';
import '../../../utility/responsive_constants.dart';

class CouponCodeHeader extends StatelessWidget {
  const CouponCodeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);
    final isMobileS = AppBreakpoints.isMobileS(context);

    if (isMobileS) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Coupon Codes",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: AppFontSize.lg(context),
                    ),
              ),
              if (!isMobile) const ProfileCard(),
            ],
          ),
          SizedBox(height: AppSpacing.itemGap(context)),
          _CouponSearchField(
            onChange: (val) => context.dataProvider.filterCoupons(val),
          ),
        ],
      );
    }

    return Row(
      children: [
        Text(
          "Coupon Codes",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: AppFontSize.xl(context),
              ),
        ),
        if (!isMobile) const Spacer(flex: 1),
        SizedBox(width: AppSpacing.itemGap(context)),
        Expanded(
          child: _CouponSearchField(
            onChange: (val) => context.dataProvider.filterCoupons(val),
          ),
        ),
        SizedBox(width: AppSpacing.itemGap(context)),
        if (!isMobile) const ProfileCard(),
      ],
    );
  }
}

class _CouponSearchField extends StatelessWidget {
  final Function(String) onChange;
  const _CouponSearchField({required this.onChange});

  @override
  Widget build(BuildContext context) {
    final double iconContainerSize =
        AppResponsive.value(context, mobile: 30.0, tablet: 32.0, web: 36.0);
    final double iconPad = AppResponsive.value(context,
        mobile: 6.0, tablet: 7.0, web: defaultPadding * 0.75);
    final double iconMarginH = AppResponsive.value(context,
        mobile: 4.0, tablet: 6.0, web: defaultPadding / 2);

    return TextField(
      style: TextStyle(fontSize: AppFontSize.body(context)),
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(
            fontSize: AppFontSize.body(context), color: Colors.white38),
        fillColor: secondaryColor,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm(context) + 4,
          vertical: AppSpacing.sm(context),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              BorderRadius.all(Radius.circular(AppRadius.md(context))),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(iconPad),
            margin: EdgeInsets.symmetric(horizontal: iconMarginH, vertical: 6),
            height: iconContainerSize,
            width: iconContainerSize,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(AppRadius.sm(context))),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg",
                fit: BoxFit.contain),
          ),
        ),
      ),
      onChanged: onChange,
    );
  }
}
