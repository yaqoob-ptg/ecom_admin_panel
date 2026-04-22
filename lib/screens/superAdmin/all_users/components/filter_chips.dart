// // import 'package:admin/utility/constants.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../provider/all_user_provider.dart';

// // class FilterChips extends StatelessWidget {
// //   const FilterChips({Key? key}) : super(key: key);

// //   static const _filters = ['All', 'admin', 'user', 'guest', 'pending'];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<AllUsersProvider>(
// //       builder: (context, prov, _) {
// //         return SingleChildScrollView(
// //           scrollDirection: Axis.horizontal,
// //           child: Row(
// //             children: _filters.map((f) {
// //               final isSelected = prov.selectedFilter == f;
// //               final color = _chipColor(f);
// //               return Padding(
// //                 padding: const EdgeInsets.only(right: 8),
// //                 child: FilterChip(
// //                   label: Text(
// //                     _chipLabel(f),
// //                     style: TextStyle(
// //                       fontSize: 12,
// //                       fontWeight:
// //                           isSelected ? FontWeight.bold : FontWeight.normal,
// //                       color: isSelected ? Colors.white : Colors.white70,
// //                     ),
// //                   ),
// //                   selected: isSelected,
// //                   onSelected: (_) => prov.setFilter(f),
// //                   selectedColor: color,
// //                   backgroundColor: secondaryColor,
// //                   checkmarkColor: Colors.white,
// //                   side: BorderSide(color: isSelected ? color : Colors.white24),
// //                   padding:
// //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //                   shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(20)),
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   String _chipLabel(String f) {
// //     switch (f) {
// //       case 'All':
// //         return '🌐  All';
// //       case 'admin':
// //         return '🛡️  Admin';
// //       case 'user':
// //         return '👤  User';
// //       case 'guest':
// //         return '👻  Guest';
// //       case 'pending':
// //         return '⏳  Pending Approval';
// //       default:
// //         return f;
// //     }
// //   }

// //   Color _chipColor(String f) {
// //     switch (f) {
// //       case 'pending':
// //         return const Color(0xFFFFC107);
// //       case 'admin':
// //         return const Color(0xFF667EEA);
// //       case 'user':
// //         return const Color(0xFF4CAF50);
// //       case 'guest':
// //         return Colors.orange;
// //       default:
// //         return primaryColor;
// //     }
// //   }
// // }

import 'package:admin/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/all_user_provider.dart';

class FilterChips extends StatelessWidget {
  const FilterChips({Key? key}) : super(key: key);

  static const _filters = ['All', 'admin', 'user', 'guest', 'pending'];

  @override
  Widget build(BuildContext context) {
    return Consumer<AllUsersProvider>(
      builder: (context, prov, _) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "Users",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const SizedBox(width: 20),

            // SAME STYLE AS YOUR ORDER SCREEN
            SizedBox(
              width: 280,
              child: CustomDropdown(
                hintText: 'Filter Users By Role',
                initialValue: prov.selectedFilter,
                items: _filters,
                displayItem: (val) => _chipLabel(val),
                onChanged: (newValue) {
                  if (newValue != null) {
                    prov.setFilter(newValue);
                  }
                },
                validator: (value) => null,
              ),
            ),

            const SizedBox(width: 20),

            IconButton(
              tooltip: 'Refresh',
              onPressed: () =>
                  context.read<AllUsersProvider>().getAllUsers(showSnack: true),
              icon: const Icon(Icons.refresh),
            ),
          ],
        );
      },
    );
  }

  String _chipLabel(String f) {
    switch (f) {
      case 'All':
        return '🌐 All';
      case 'admin':
        return '🛡️ Admin';
      case 'user':
        return '👤 User';
      case 'guest':
        return '👻 Guest';
      case 'pending':
        return '⏳ Pending Approval';
      default:
        return f;
    }
  }
}
