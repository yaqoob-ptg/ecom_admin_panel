import 'package:admin/utility/responsive_constants.dart';
import 'package:admin/widgets/profile_card.dart';
import 'provider/main_screen_provider.dart';
import '../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/side_menu.dart';

// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final isMobile = AppBreakpoints.isMobile(context);
//     final isTablet = AppBreakpoints.isTablet(context);
//     context.dataProvider;

//     return Scaffold(
//       drawer: isMobile ? Drawer(child: SideMenu()) : null,
//       appBar: isMobile
//           ? AppBar(
//               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: ProfileCard(),
//                 ),
//               ],
//             ) // shows hamburger automatically
//           : null,
//       body: SafeArea(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (!isMobile)
//               Expanded(
//                 child: SideMenu(),
//               ),
//             Consumer<MainScreenProvider>(
//               builder: (context, provider, child) {
//                 return Expanded(
//                   flex: 5,
//                   child: provider.selectedScreen,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);

    return FutureBuilder(
      future: context.dataProvider.init(), // 🔥 triggers once
      builder: (context, snapshot) {
        // 🔄 Loading state
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   // return const Center(child: CircularProgressIndicator());
        //   return;
        // }

        // // ❌ Error state (optional)
        // if (snapshot.hasError) {
        //   return Center(child: Text("Error loading data"));
        // }

        // ✅ Main UI
        return Scaffold(
          drawer: isMobile ? Drawer(child: SideMenu()) : null,
          appBar: isMobile
              ? AppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  actions: const [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ProfileCard(),
                    ),
                  ],
                )
              : null,
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMobile) Expanded(child: SideMenu()),
                Consumer<MainScreenProvider>(
                  builder: (context, provider, child) {
                    return Expanded(
                      flex: 5,
                      child: provider.selectedScreen,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
