// import 'package:admin/models/user.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/all_user_provider.dart';
// import 'shared_widgets.dart';

// class DesktopUserTable extends StatelessWidget {
//   const DesktopUserTable({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AllUsersProvider>(
//       builder: (context, prov, _) {
//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Container(
//             constraints: BoxConstraints(
//               minWidth: MediaQuery.of(context).size.width - 80,
//             ),
//             child: Theme(
//               data: Theme.of(context).copyWith(
//                 dataTableTheme: DataTableThemeData(
//                   headingRowColor:
//                       WidgetStateProperty.all(Colors.white.withOpacity(0.05)),
//                   dataRowColor: WidgetStateProperty.resolveWith((states) {
//                     if (states.contains(WidgetState.hovered)) {
//                       return Colors.white.withOpacity(0.04);
//                     }
//                     return Colors.transparent;
//                   }),
//                 ),
//               ),
//               child: DataTable(
//                 horizontalMargin: 16, // Increased margin
//                 columnSpacing: 24, // Added spacing between columns
//                 dataRowMinHeight: 58,
//                 dataRowMaxHeight: 68,
//                 headingRowHeight: 56,
//                 columns: const [
//                   DataColumn(
//                       label: Text('#',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 13))),
//                   DataColumn(
//                       label: Text('Name',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 13))),
//                   DataColumn(
//                       label: Text('Email',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 13))),
//                   DataColumn(
//                       label: Text('Phone',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 13))),
//                   DataColumn(
//                       label: Text('Role',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 13))),
//                   DataColumn(
//                       label: Text('Status',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 13))),
//                   DataColumn(
//                       label: Text('Verified',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 13))),
//                   DataColumn(
//                       label: Text('Joined',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 13))),
//                   DataColumn(
//                       label: Text('Actions',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 13))),
//                 ],
//                 rows: prov.users.asMap().entries.map((e) {
//                   return _buildRow(context, e.key + 1, e.value, prov);
//                 }).toList(),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   DataRow _buildRow(
//       BuildContext context, int idx, User user, AllUsersProvider prov) {
//     return DataRow(
//       cells: [
//         DataCell(Text('$idx',
//             style: const TextStyle(color: Colors.white54, fontSize: 13))),
//         DataCell(NameCell(user: user)),
//         DataCell(Text(user.email ?? '—',
//             style: const TextStyle(fontSize: 13, color: Colors.white70),
//             overflow: TextOverflow.ellipsis)),
//         DataCell(Text(user.phone ?? '—',
//             style: const TextStyle(fontSize: 13, color: Colors.white70))),
//         DataCell(RoleBadge(role: user.role ?? 'user')),
//         DataCell(StatusBadge(isActive: user.isActive ?? true)),
//         DataCell(Icon(
//           (user.isVerified ?? false)
//               ? Icons.verified_rounded
//               : Icons.cancel_rounded,
//           size: 20,
//           color:
//               (user.isVerified ?? false) ? const Color(0xFF4CAF50) : Colors.red,
//         )),
//         DataCell(Text(_formatDate(user.createdAt),
//             style: const TextStyle(fontSize: 13, color: Colors.white54))),
//         DataCell(ActionButtons(user: user, prov: prov)),
//       ],
//     );
//   }
// }

// String _formatDate(String? raw) {
//   if (raw == null) return '—';
//   try {
//     final dt = DateTime.parse(raw);
//     return '${dt.day.toString().padLeft(2, '0')}/'
//         '${dt.month.toString().padLeft(2, '0')}/${dt.year}';
//   } catch (_) {
//     return raw;
//   }
// }

import 'package:admin/models/user.dart';
import 'package:admin/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/all_user_provider.dart';
import 'shared_widgets.dart';

class DesktopUserTable extends StatefulWidget {
  const DesktopUserTable({Key? key}) : super(key: key);

  @override
  State<DesktopUserTable> createState() => _DesktopUserTableState();
}

class _DesktopUserTableState extends State<DesktopUserTable> {
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllUsersProvider>(
      builder: (context, prov, _) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Scrollbar(
              controller: _horizontalController,
              thumbVisibility: true,
              thickness: 8,
              radius: const Radius.circular(8),
              child: Scrollbar(
                controller: _verticalController,
                thumbVisibility: true,
                thickness: 8,
                radius: const Radius.circular(8),
                child: SingleChildScrollView(
                  controller: _horizontalController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: SingleChildScrollView(
                    controller: _verticalController,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        color: secondaryColor,
                        child: DataTable(
                          horizontalMargin: 10,
                          columnSpacing: 8,
                          dataRowMinHeight: 40,
                          dataRowMaxHeight: 45,
                          headingRowHeight: 60,
                          columns: const [
                            DataColumn(label: Text('#')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Email')),
                            // DataColumn(label: Text('Phone')),
                            DataColumn(label: Text('Role')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Verified')),
                            DataColumn(label: Text('Joined')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: prov.users
                              .asMap()
                              .entries
                              .map((e) =>
                                  _buildRow(context, e.key + 1, e.value, prov))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  DataRow _buildRow(
      BuildContext context, int idx, User user, AllUsersProvider prov) {
    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 20,
            child: Text(
              '$idx',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 13,
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 180,
            child: NameCell(user: user),
          ),
        ),
        DataCell(
          onTap: () {
            if (user.email != null) {
              Clipboard.setData(ClipboardData(text: user.email!));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Email copied to clipboard',
                    style: TextStyle(color: Colors.white)),
                backgroundColor: primaryColor,
                duration: Duration(seconds: 2),
              ));
            }
          },
          SizedBox(
            width: 200,
            child: Text(
              user.email ?? '—',
              style: const TextStyle(fontSize: 13, color: Colors.white70),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        // DataCell(
        //   SizedBox(
        //     width: 120,
        //     child: Text(
        //       user.phone ?? '—',
        //       style: const TextStyle(fontSize: 13, color: Colors.white70),
        //       overflow: TextOverflow.ellipsis,
        //     ),
        //   ),
        // ),
        DataCell(
          SizedBox(
            width: 120,
            child: RoleBadge(role: user.role ?? 'user'),
          ),
        ),
        DataCell(
          SizedBox(
            width: 75,
            child: StatusBadge(isActive: user.isActive ?? true),
          ),
        ),
        DataCell(
          SizedBox(
            width: 60,
            child: Icon(
              (user.isVerified ?? false)
                  ? Icons.verified_rounded
                  : Icons.cancel_rounded,
              size: 20,
              color: (user.isVerified ?? false)
                  ? const Color(0xFF4CAF50)
                  : Colors.red,
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 100,
            child: Text(
              _formatDate(user.createdAt),
              style: const TextStyle(fontSize: 13, color: Colors.white54),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 180,
            child: ActionButtons(user: user, prov: prov),
          ),
        ),
      ],
    );
  }
}

String _formatDate(String? raw) {
  if (raw == null) return '—';
  try {
    final dt = DateTime.parse(raw);
    return '${dt.day.toString().padLeft(2, '0')}/'
        '${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  } catch (_) {
    return raw;
  }
}
