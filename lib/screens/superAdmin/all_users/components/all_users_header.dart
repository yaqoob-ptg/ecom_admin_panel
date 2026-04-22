// import 'package:admin/utility/constants.dart';
// import 'package:admin/utility/responsive.dart';
// import 'package:admin/widgets/profile_card.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
// import '../provider/all_user_provider.dart';

// class Header extends StatelessWidget {
//   const Header({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = Responsive.isMobile(context);
//     return isMobile ? const _MobileHeader() : const _DesktopHeader();
//   }
// }

// class _DesktopHeader extends StatelessWidget {
//   const _DesktopHeader();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text('All Users', style: Theme.of(context).textTheme.titleLarge),
//         const Spacer(),
//         const SizedBox(width: 280, child: _SearchBar()),
//         const Gap(12),
//         const _RefreshButton(),
//         const Gap(12),
//         const ProfileCard(),
//       ],
//     );
//   }
// }

// class _MobileHeader extends StatelessWidget {
//   const _MobileHeader();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('All Users', style: Theme.of(context).textTheme.titleLarge),
//             Row(children: const [_RefreshButton(), Gap(8), ProfileCard()]),
//           ],
//         ),
//         const Gap(12),
//         const _SearchBar(),
//       ],
//     );
//   }
// }

// class _RefreshButton extends StatelessWidget {
//   const _RefreshButton();

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       tooltip: 'Refresh',
//       onPressed: () =>
//           context.read<AllUsersProvider>().getAllUsers(showSnack: true),
//       icon: const Icon(Icons.refresh_rounded),
//     );
//   }
// }

// class _SearchBar extends StatelessWidget {
//   const _SearchBar();

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       onChanged: context.read<AllUsersProvider>().filterByKeyword,
//       decoration: InputDecoration(
//         hintText: 'Search by name or email…',
//         fillColor: secondaryColor,
//         filled: true,
//         prefixIcon: const Icon(Icons.search_rounded, size: 20),
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//       ),
//     );
//   }
// }

import 'package:admin/utility/constants.dart';
import 'package:admin/widgets/profile_card.dart';
import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllUserHeader extends StatelessWidget {
  const AllUserHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "All Users",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Spacer(flex: 2),
        Expanded(child: SearchField(
          onChange: (val) {
            context.allUsersProvider.filterByKeyword(val);
          },
        )),
        ProfileCard()
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  final Function(String) onChange;

  const SearchField({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
      onChanged: (value) {
        onChange(value);
      },
    );
  }
}
