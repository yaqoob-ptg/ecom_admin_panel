// // import 'package:admin/screens/superAdmin/all_users/provider/all_user_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:gap/gap.dart';
// // import 'package:provider/provider.dart';

// // import '../../../models/user.dart';
// // import '../../../utility/constants.dart';
// // import '../../../utility/responsive.dart';
// // import '../../../widgets/profile_card.dart';

// // // ─── Responsive token helpers (matches your AppBreakpoints / AppFontSize etc.)
// // // ─────────────────────────────────────────────────────────────────────────────

// // class AllUsersScreen extends StatefulWidget {
// //   const AllUsersScreen({Key? key}) : super(key: key);

// //   @override
// //   State<AllUsersScreen> createState() => _AllUsersScreenState();
// // }

// // class _AllUsersScreenState extends State<AllUsersScreen> {
// //   final TextEditingController _searchCtrl = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       context.read<AllUsersProvider>().getAllUsers();
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     _searchCtrl.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: SingleChildScrollView(
// //         padding: EdgeInsets.all(defaultPadding),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             _Header(searchCtrl: _searchCtrl),
// //             Gap(defaultPadding),
// //             _StatsRow(),
// //             Gap(defaultPadding),
// //             _FilterChips(),
// //             Gap(defaultPadding),
// //             _UserTable(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // ─── Header ──────────────────────────────────────────────────────────────────

// // class _Header extends StatelessWidget {
// //   final TextEditingController searchCtrl;
// //   const _Header({required this.searchCtrl});

// //   @override
// //   Widget build(BuildContext context) {
// //     final isMobile = Responsive.isMobile(context);
// //     return isMobile
// //         ? Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text('All Users',
// //                       style: Theme.of(context).textTheme.titleLarge),
// //                   Row(children: [
// //                     _RefreshButton(),
// //                     Gap(8),
// //                     ProfileCard(),
// //                   ]),
// //                 ],
// //               ),
// //               Gap(12),
// //               _SearchBar(ctrl: searchCtrl),
// //             ],
// //           )
// //         : Row(
// //             children: [
// //               Text('All Users', style: Theme.of(context).textTheme.titleLarge),
// //               const Spacer(),
// //               SizedBox(width: 260, child: _SearchBar(ctrl: searchCtrl)),
// //               Gap(12),
// //               _RefreshButton(),
// //               Gap(12),
// //               ProfileCard(),
// //             ],
// //           );
// //   }
// // }

// // class _RefreshButton extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return IconButton(
// //       tooltip: 'Refresh',
// //       onPressed: () =>
// //           context.read<AllUsersProvider>().getAllUsers(showSnack: true),
// //       icon: const Icon(Icons.refresh_rounded),
// //     );
// //   }
// // }

// // class _SearchBar extends StatelessWidget {
// //   final TextEditingController ctrl;
// //   const _SearchBar({required this.ctrl});

// //   @override
// //   Widget build(BuildContext context) {
// //     return TextField(
// //       controller: ctrl,
// //       onChanged: context.read<AllUsersProvider>().filterByKeyword,
// //       decoration: InputDecoration(
// //         hintText: 'Search by name or email…',
// //         fillColor: secondaryColor,
// //         filled: true,
// //         prefixIcon: const Icon(Icons.search_rounded, size: 20),
// //         border: OutlineInputBorder(
// //           borderSide: BorderSide.none,
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //         contentPadding:
// //             const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// //       ),
// //     );
// //   }
// // }

// // // ─── Stats Row ───────────────────────────────────────────────────────────────

// // class _StatsRow extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<AllUsersProvider>(
// //       builder: (context, prov, _) {
// //         final isMobile = Responsive.isMobile(context);
// //         final cards = [
// //           _StatCard(
// //             label: 'Total Users',
// //             value: prov.totalUsers,
// //             icon: Icons.people_alt_rounded,
// //             color: const Color(0xFF667EEA),
// //           ),
// //           _StatCard(
// //             label: 'Admins',
// //             value: prov.totalAdmins,
// //             icon: Icons.admin_panel_settings_rounded,
// //             color: const Color(0xFF4CAF50),
// //           ),
// //           _StatCard(
// //             label: 'Pending Approval',
// //             value: prov.pendingAdmins,
// //             icon: Icons.hourglass_top_rounded,
// //             color: const Color(0xFFFFC107),
// //           ),
// //           _StatCard(
// //             label: 'Blocked',
// //             value: prov.blockedUsers,
// //             icon: Icons.block_rounded,
// //             color: const Color(0xFFFF6B6B),
// //           ),
// //         ];

// //         if (isMobile) {
// //           return GridView.count(
// //             crossAxisCount: 2,
// //             shrinkWrap: true,
// //             physics: const NeverScrollableScrollPhysics(),
// //             crossAxisSpacing: 12,
// //             mainAxisSpacing: 12,
// //             childAspectRatio: 1.7,
// //             children: cards,
// //           );
// //         }
// //         return Row(
// //           children: cards
// //               .map((c) => Expanded(
// //                       child: Padding(
// //                     padding: EdgeInsets.only(right: c == cards.last ? 0 : 12),
// //                     child: c,
// //                   )))
// //               .toList(),
// //         );
// //       },
// //     );
// //   }
// // }

// // class _StatCard extends StatelessWidget {
// //   final String label;
// //   final int value;
// //   final IconData icon;
// //   final Color color;

// //   const _StatCard({
// //     required this.label,
// //     required this.value,
// //     required this.icon,
// //     required this.color,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: secondaryColor,
// //         borderRadius: BorderRadius.circular(10),
// //         border: Border.all(color: color.withOpacity(0.25)),
// //       ),
// //       child: Row(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(10),
// //             decoration: BoxDecoration(
// //               color: color.withOpacity(0.15),
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //             child: Icon(icon, color: color, size: 22),
// //           ),
// //           const Gap(12),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Text(
// //                   value.toString(),
// //                   style: TextStyle(
// //                     fontSize: 22,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //                 Text(
// //                   label,
// //                   style: TextStyle(
// //                     fontSize: 11,
// //                     color: Colors.white54,
// //                   ),
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // ─── Filter Chips ────────────────────────────────────────────────────────────

// // class _FilterChips extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<AllUsersProvider>(
// //       builder: (context, prov, _) {
// //         return SingleChildScrollView(
// //           scrollDirection: Axis.horizontal,
// //           child: Row(
// //             children: prov.roleFilters.map((role) {
// //               final isSelected = prov.selectedRole == role;
// //               return Padding(
// //                 padding: const EdgeInsets.only(right: 8),
// //                 child: FilterChip(
// //                   label: Text(
// //                     role == 'All' ? '🌐  All' : _roleLabel(role),
// //                     style: TextStyle(
// //                       fontSize: 12,
// //                       fontWeight:
// //                           isSelected ? FontWeight.bold : FontWeight.normal,
// //                       color: isSelected ? Colors.white : Colors.white70,
// //                     ),
// //                   ),
// //                   selected: isSelected,
// //                   onSelected: (_) => prov.filterByRole(role),
// //                   selectedColor: primaryColor,
// //                   backgroundColor: secondaryColor,
// //                   checkmarkColor: Colors.white,
// //                   side: BorderSide(
// //                     color: isSelected ? primaryColor : Colors.white24,
// //                   ),
// //                   padding:
// //                       const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                 ),
// //               );
// //             }).toList(),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   String _roleLabel(String role) {
// //     switch (role) {
// //       case 'admin':
// //         return '🛡️  Admin';
// //       case 'user':
// //         return '👤  User';
// //       case 'guest':
// //         return '👻  Guest';
// //       default:
// //         return role;
// //     }
// //   }
// // }

// // // ─── User Table ──────────────────────────────────────────────────────────────

// // class _UserTable extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<AllUsersProvider>(
// //       builder: (context, prov, _) {
// //         if (prov.isLoading) {
// //           return const Center(
// //             child: Padding(
// //               padding: EdgeInsets.all(60),
// //               child: CircularProgressIndicator(),
// //             ),
// //           );
// //         }

// //         if (prov.users.isEmpty) {
// //           return Container(
// //             padding: const EdgeInsets.all(40),
// //             decoration: BoxDecoration(
// //               color: secondaryColor,
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //             child: Center(
// //               child: Column(
// //                 children: [
// //                   Icon(Icons.people_outline, size: 48, color: Colors.white24),
// //                   const Gap(12),
// //                   Text('No users found',
// //                       style: TextStyle(color: Colors.white38, fontSize: 15)),
// //                 ],
// //               ),
// //             ),
// //           );
// //         }

// //         final isMobile = Responsive.isMobile(context);

// //         return Container(
// //           padding: EdgeInsets.all(defaultPadding),
// //           decoration: BoxDecoration(
// //             color: secondaryColor,
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(
// //                     'Users (${prov.users.length})',
// //                     style: Theme.of(context).textTheme.titleMedium,
// //                   ),
// //                 ],
// //               ),
// //               Gap(defaultPadding),
// //               isMobile
// //                   ? _MobileUserList(users: prov.users, prov: prov)
// //                   : _DesktopUserTable(users: prov.users, prov: prov),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // // ─── Desktop Table ───────────────────────────────────────────────────────────

// // class _DesktopUserTable extends StatelessWidget {
// //   final List<User> users;
// //   final AllUsersProvider prov;
// //   const _DesktopUserTable({required this.users, required this.prov});

// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       scrollDirection: Axis.horizontal,
// //       child: DataTable(
// //         columnSpacing: defaultPadding,
// //         headingRowColor: WidgetStateProperty.all(
// //           Colors.white.withOpacity(0.05),
// //         ),
// //         columns: const [
// //           DataColumn(label: Text('#')),
// //           DataColumn(label: Text('Name')),
// //           DataColumn(label: Text('Email')),
// //           DataColumn(label: Text('Role')),
// //           DataColumn(label: Text('Status')),
// //           DataColumn(label: Text('Verified')),
// //           DataColumn(label: Text('Joined')),
// //           DataColumn(label: Text('Actions')),
// //         ],
// //         rows: users.asMap().entries.map((e) {
// //           return _buildRow(context, e.key + 1, e.value, prov);
// //         }).toList(),
// //       ),
// //     );
// //   }

// //   DataRow _buildRow(
// //       BuildContext context, int idx, User user, AllUsersProvider prov) {
// //     return DataRow(
// //       cells: [
// //         DataCell(Text('$idx',
// //             style: TextStyle(color: Colors.white54, fontSize: 12))),
// //         DataCell(_NameCell(user: user)),
// //         DataCell(
// //           Text(user.email ?? '',
// //               style: const TextStyle(fontSize: 12, color: Colors.white70)),
// //         ),
// //         DataCell(_RoleBadge(role: user.role ?? 'user')),
// //         DataCell(_StatusBadge(isActive: user.isActive ?? true)),
// //         DataCell(
// //           Icon(
// //             (user.isVerified ?? false)
// //                 ? Icons.verified_rounded
// //                 : Icons.cancel_rounded,
// //             size: 18,
// //             color: (user.isVerified ?? false)
// //                 ? const Color(0xFF4CAF50)
// //                 : Colors.red,
// //           ),
// //         ),
// //         DataCell(
// //           Text(
// //             _formatDate(user.createdAt),
// //             style: const TextStyle(fontSize: 12, color: Colors.white54),
// //           ),
// //         ),
// //         DataCell(_ActionButtons(user: user, prov: prov)),
// //       ],
// //     );
// //   }
// // }

// // // ─── Mobile Card List ────────────────────────────────────────────────────────

// // class _MobileUserList extends StatelessWidget {
// //   final List<User> users;
// //   final AllUsersProvider prov;
// //   const _MobileUserList({required this.users, required this.prov});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ListView.separated(
// //       shrinkWrap: true,
// //       physics: const NeverScrollableScrollPhysics(),
// //       itemCount: users.length,
// //       separatorBuilder: (_, __) => const Divider(color: Colors.white12),
// //       itemBuilder: (context, i) {
// //         final user = users[i];
// //         return Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 8),
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               _AvatarWidget(name: user.name ?? '?', size: 40),
// //               const Gap(12),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(user.name ?? 'Unknown',
// //                         style: const TextStyle(
// //                             fontWeight: FontWeight.bold, fontSize: 14)),
// //                     const Gap(2),
// //                     Text(user.email ?? '',
// //                         style: const TextStyle(
// //                             fontSize: 11, color: Colors.white54)),
// //                     const Gap(6),
// //                     Wrap(
// //                       spacing: 6,
// //                       runSpacing: 4,
// //                       children: [
// //                         _RoleBadge(role: user.role ?? 'user'),
// //                         _StatusBadge(isActive: user.isActive ?? true),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               _ActionButtons(user: user, prov: prov, compact: true),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // // ─── Sub-widgets ─────────────────────────────────────────────────────────────

// // class _NameCell extends StatelessWidget {
// //   final User user;
// //   const _NameCell({required this.user});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         _AvatarWidget(name: user.name ?? '?', size: 30),
// //         const Gap(10),
// //         Text(user.name ?? 'Unknown',
// //             style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
// //       ],
// //     );
// //   }
// // }

// // class _AvatarWidget extends StatelessWidget {
// //   final String name;
// //   final double size;
// //   const _AvatarWidget({required this.name, required this.size});

// //   Color _colorFromName(String name) {
// //     final colors = [
// //       const Color(0xFF667EEA),
// //       const Color(0xFF4CAF50),
// //       const Color(0xFFFF9800),
// //       const Color(0xFFE91E63),
// //       const Color(0xFF00BCD4),
// //       const Color(0xFF9C27B0),
// //     ];
// //     return colors[name.codeUnitAt(0) % colors.length];
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final color = _colorFromName(name);
// //     return Container(
// //       width: size,
// //       height: size,
// //       decoration: BoxDecoration(
// //         color: color.withOpacity(0.2),
// //         borderRadius: BorderRadius.circular(8),
// //         border: Border.all(color: color.withOpacity(0.5)),
// //       ),
// //       child: Center(
// //         child: Text(
// //           name.isNotEmpty ? name[0].toUpperCase() : '?',
// //           style: TextStyle(
// //             color: color,
// //             fontWeight: FontWeight.bold,
// //             fontSize: size * 0.45,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class _RoleBadge extends StatelessWidget {
// //   final String role;
// //   const _RoleBadge({required this.role});

// //   @override
// //   Widget build(BuildContext context) {
// //     final cfg = _config(role);
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
// //       decoration: BoxDecoration(
// //         color: cfg.$1.withOpacity(0.15),
// //         borderRadius: BorderRadius.circular(20),
// //         border: Border.all(color: cfg.$1.withOpacity(0.4)),
// //       ),
// //       child: Text(
// //         '${cfg.$2}  $role',
// //         style:
// //             TextStyle(fontSize: 11, color: cfg.$1, fontWeight: FontWeight.w600),
// //       ),
// //     );
// //   }

// //   (Color, String) _config(String role) {
// //     switch (role) {
// //       case 'superAdmin':
// //         return (const Color(0xFFFF6B6B), '👑');
// //       case 'admin':
// //         return (const Color(0xFF667EEA), '🛡️');
// //       case 'user':
// //         return (const Color(0xFF4CAF50), '👤');
// //       case 'guest':
// //         return (Colors.orange, '👻');
// //       default:
// //         return (Colors.grey, '•');
// //     }
// //   }
// // }

// // class _StatusBadge extends StatelessWidget {
// //   final bool isActive;
// //   const _StatusBadge({required this.isActive});

// //   @override
// //   Widget build(BuildContext context) {
// //     final color = isActive ? const Color(0xFF4CAF50) : const Color(0xFFFF6B6B);
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
// //       decoration: BoxDecoration(
// //         color: color.withOpacity(0.12),
// //         borderRadius: BorderRadius.circular(20),
// //         border: Border.all(color: color.withOpacity(0.4)),
// //       ),
// //       child: Row(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Container(
// //             width: 6,
// //             height: 6,
// //             decoration: BoxDecoration(color: color, shape: BoxShape.circle),
// //           ),
// //           const Gap(5),
// //           Text(
// //             isActive ? 'Active' : 'Blocked',
// //             style: TextStyle(
// //                 fontSize: 11, color: color, fontWeight: FontWeight.w600),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _ActionButtons extends StatelessWidget {
// //   final User user;
// //   final AllUsersProvider prov;
// //   final bool compact;

// //   const _ActionButtons({
// //     required this.user,
// //     required this.prov,
// //     this.compact = false,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     final isActive = user.isActive ?? true;
// //     final isAdmin = user.role == 'admin';
// //     final isApproved = user.isApproved ?? false;

// //     if (compact) {
// //       return PopupMenuButton<String>(
// //         icon: const Icon(Icons.more_vert_rounded, size: 20),
// //         color: bgColor,
// //         itemBuilder: (_) => [
// //           if (isAdmin)
// //             PopupMenuItem(
// //               value: 'approve',
// //               child: Row(children: [
// //                 Icon(
// //                   isApproved
// //                       ? Icons.remove_circle_outline
// //                       : Icons.check_circle_outline,
// //                   size: 18,
// //                   color: isApproved ? Colors.orange : const Color(0xFF4CAF50),
// //                 ),
// //                 const Gap(8),
// //                 Text(isApproved ? 'Revoke Approval' : 'Approve Admin'),
// //               ]),
// //             ),
// //           PopupMenuItem(
// //             value: 'block',
// //             child: Row(children: [
// //               Icon(
// //                 isActive ? Icons.block_rounded : Icons.lock_open_rounded,
// //                 size: 18,
// //                 color: isActive
// //                     ? const Color(0xFFFF6B6B)
// //                     : const Color(0xFF4CAF50),
// //               ),
// //               const Gap(8),
// //               Text(isActive ? 'Block User' : 'Unblock User'),
// //             ]),
// //           ),
// //           const PopupMenuItem(
// //             value: 'delete',
// //             child: Row(children: [
// //               Icon(Icons.delete_outline_rounded,
// //                   size: 18, color: Colors.redAccent),
// //               Gap(8),
// //               Text('Delete', style: TextStyle(color: Colors.redAccent)),
// //             ]),
// //           ),
// //         ],
// //         onSelected: (val) => _handleAction(context, val),
// //       );
// //     }

// //     return Row(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         // Approve toggle — admins only
// //         if (isAdmin)
// //           _ActionIconBtn(
// //             tooltip: isApproved ? 'Revoke Approval' : 'Approve Admin',
// //             icon: isApproved
// //                 ? Icons.remove_circle_outline
// //                 : Icons.check_circle_outline_rounded,
// //             color: isApproved ? Colors.orange : const Color(0xFF4CAF50),
// //             onTap: () => _confirmAction(
// //               context,
// //               title: isApproved ? 'Revoke Admin Approval?' : 'Approve Admin?',
// //               subtitle: isApproved
// //                   ? '${user.name} will no longer be able to log in as admin.'
// //                   : '${user.name} will be able to log in as admin.',
// //               confirmLabel: isApproved ? 'Revoke' : 'Approve',
// //               confirmColor:
// //                   isApproved ? Colors.orange : const Color(0xFF4CAF50),
// //               onConfirm: () => prov.toggleAdminApproval(user),
// //             ),
// //           ),
// //         const Gap(4),
// //         // Block/Unblock
// //         _ActionIconBtn(
// //           tooltip: isActive ? 'Block User' : 'Unblock User',
// //           icon: isActive ? Icons.block_rounded : Icons.lock_open_rounded,
// //           color: isActive ? const Color(0xFFFF6B6B) : const Color(0xFF4CAF50),
// //           onTap: () => _confirmAction(
// //             context,
// //             title: isActive ? 'Block ${user.name}?' : 'Unblock ${user.name}?',
// //             subtitle: isActive
// //                 ? 'This user will be immediately logged out and cannot log in again.'
// //                 : 'This user will regain access to their account.',
// //             confirmLabel: isActive ? 'Block' : 'Unblock',
// //             confirmColor:
// //                 isActive ? const Color(0xFFFF6B6B) : const Color(0xFF4CAF50),
// //             onConfirm: () => prov.toggleUserActive(user),
// //           ),
// //         ),
// //         const Gap(4),
// //         // Delete
// //         _ActionIconBtn(
// //           tooltip: 'Delete User',
// //           icon: Icons.delete_outline_rounded,
// //           color: Colors.red,
// //           onTap: () => _confirmAction(
// //             context,
// //             title: 'Delete ${user.name}?',
// //             subtitle: 'This action cannot be undone.',
// //             confirmLabel: 'Delete',
// //             confirmColor: Colors.red,
// //             onConfirm: () => prov.deleteUser(user),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   void _handleAction(BuildContext context, String val) {
// //     switch (val) {
// //       case 'approve':
// //         prov.toggleAdminApproval(user);
// //         break;
// //       case 'block':
// //         prov.toggleUserActive(user);
// //         break;
// //       case 'delete':
// //         _confirmAction(
// //           context,
// //           title: 'Delete ${user.name}?',
// //           subtitle: 'This action cannot be undone.',
// //           confirmLabel: 'Delete',
// //           confirmColor: Colors.red,
// //           onConfirm: () => prov.deleteUser(user),
// //         );
// //         break;
// //     }
// //   }

// //   void _confirmAction(
// //     BuildContext context, {
// //     required String title,
// //     required String subtitle,
// //     required String confirmLabel,
// //     required Color confirmColor,
// //     required VoidCallback onConfirm,
// //   }) {
// //     showDialog(
// //       context: context,
// //       builder: (_) => AlertDialog(
// //         backgroundColor: bgColor,
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
// //         title: Text(title,
// //             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
// //         content: Text(subtitle,
// //             style: const TextStyle(color: Colors.white60, fontSize: 13)),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child:
// //                 const Text('Cancel', style: TextStyle(color: Colors.white54)),
// //           ),
// //           ElevatedButton(
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: confirmColor,
// //               shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(8)),
// //             ),
// //             onPressed: () {
// //               Navigator.pop(context);
// //               onConfirm();
// //             },
// //             child:
// //                 Text(confirmLabel, style: const TextStyle(color: Colors.white)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _ActionIconBtn extends StatelessWidget {
// //   final String tooltip;
// //   final IconData icon;
// //   final Color color;
// //   final VoidCallback onTap;

// //   const _ActionIconBtn({
// //     required this.tooltip,
// //     required this.icon,
// //     required this.color,
// //     required this.onTap,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Tooltip(
// //       message: tooltip,
// //       child: InkWell(
// //         borderRadius: BorderRadius.circular(6),
// //         onTap: onTap,
// //         child: Container(
// //           padding: const EdgeInsets.all(6),
// //           decoration: BoxDecoration(
// //             color: color.withOpacity(0.1),
// //             borderRadius: BorderRadius.circular(6),
// //           ),
// //           child: Icon(icon, size: 18, color: color),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // ─── Helpers ─────────────────────────────────────────────────────────────────

// // String _formatDate(String? raw) {
// //   if (raw == null) return '—';
// //   try {
// //     final dt = DateTime.parse(raw);
// //     return '${dt.day}/${dt.month}/${dt.year}';
// //   } catch (_) {
// //     return raw;
// //   }
// // }
// import 'package:admin/screens/superAdmin/all_users/provider/all_user_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';

// import '../../../models/user.dart';
// import '../../../utility/constants.dart';
// import '../../../utility/responsive.dart';
// import '../../../widgets/profile_card.dart';

// // ─────────────────────────────────────────────────────────────────────────────
// //  SCREEN
// // ─────────────────────────────────────────────────────────────────────────────

// class AllUsersScreen extends StatefulWidget {
//   const AllUsersScreen({Key? key}) : super(key: key);

//   @override
//   State<AllUsersScreen> createState() => _AllUsersScreenState();
// }

// class _AllUsersScreenState extends State<AllUsersScreen> {
//   final TextEditingController _searchCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<AllUsersProvider>().getAllUsers();
//     });
//   }

//   @override
//   void dispose() {
//     _searchCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: EdgeInsets.all(defaultPadding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _Header(searchCtrl: _searchCtrl),
//             Gap(defaultPadding),
//             _StatsRow(),
//             Gap(defaultPadding),
//             _FilterChips(),
//             Gap(defaultPadding),
//             _UserTable(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  HEADER
// // ─────────────────────────────────────────────────────────────────────────────

// class _Header extends StatelessWidget {
//   final TextEditingController searchCtrl;
//   const _Header({required this.searchCtrl});

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = Responsive.isMobile(context);
//     return isMobile
//         ? Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('All Users',
//                       style: Theme.of(context).textTheme.titleLarge),
//                   Row(children: [_RefreshButton(), Gap(8), ProfileCard()]),
//                 ],
//               ),
//               Gap(12),
//               _SearchBar(ctrl: searchCtrl),
//             ],
//           )
//         : Row(
//             children: [
//               Text('All Users', style: Theme.of(context).textTheme.titleLarge),
//               const Spacer(),
//               SizedBox(width: 280, child: _SearchBar(ctrl: searchCtrl)),
//               Gap(12),
//               _RefreshButton(),
//               Gap(12),
//               ProfileCard(),
//             ],
//           );
//   }
// }

// class _RefreshButton extends StatelessWidget {
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
//   final TextEditingController ctrl;
//   const _SearchBar({required this.ctrl});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: ctrl,
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

// // ─────────────────────────────────────────────────────────────────────────────
// //  STATS ROW
// // ─────────────────────────────────────────────────────────────────────────────

// class _StatsRow extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AllUsersProvider>(
//       builder: (context, prov, _) {
//         final isMobile = Responsive.isMobile(context);
//         final cards = [
//           _StatCard(
//               label: 'Total Users',
//               value: prov.totalUsers,
//               icon: Icons.people_alt_rounded,
//               color: const Color(0xFF667EEA)),
//           _StatCard(
//               label: 'Admins',
//               value: prov.totalAdmins,
//               icon: Icons.admin_panel_settings_rounded,
//               color: const Color(0xFF4CAF50)),
//           _StatCard(
//               label: 'Pending Approval',
//               value: prov.pendingAdmins,
//               icon: Icons.hourglass_top_rounded,
//               color: const Color(0xFFFFC107)),
//           _StatCard(
//               label: 'Blocked',
//               value: prov.blockedUsers,
//               icon: Icons.block_rounded,
//               color: const Color(0xFFFF6B6B)),
//         ];

//         if (isMobile) {
//           return GridView.count(
//             crossAxisCount: 2,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 1.7,
//             children: cards,
//           );
//         }
//         return Row(
//           children: cards.asMap().entries.map((e) {
//             return Expanded(
//               child: Padding(
//                 padding:
//                     EdgeInsets.only(right: e.key < cards.length - 1 ? 12 : 0),
//                 child: e.value,
//               ),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// class _StatCard extends StatelessWidget {
//   final String label;
//   final int value;
//   final IconData icon;
//   final Color color;

//   const _StatCard({
//     required this.label,
//     required this.value,
//     required this.icon,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: color.withOpacity(0.25)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.15),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon, color: color, size: 22),
//           ),
//           const Gap(12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(value.toString(),
//                     style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white)),
//                 Text(label,
//                     style: const TextStyle(fontSize: 11, color: Colors.white54),
//                     overflow: TextOverflow.ellipsis),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  FILTER CHIPS  — All | Admin | User | Guest | Pending Approval
// // ─────────────────────────────────────────────────────────────────────────────

// class _FilterChips extends StatelessWidget {
//   static const _filters = ['All', 'admin', 'user', 'guest', 'pending'];

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AllUsersProvider>(
//       builder: (context, prov, _) {
//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: _filters.map((f) {
//               final isSelected = prov.selectedFilter == f;
//               final color = _chipColor(f);
//               return Padding(
//                 padding: const EdgeInsets.only(right: 8),
//                 child: FilterChip(
//                   label: Text(
//                     _chipLabel(f),
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight:
//                           isSelected ? FontWeight.bold : FontWeight.normal,
//                       color: isSelected ? Colors.white : Colors.white70,
//                     ),
//                   ),
//                   selected: isSelected,
//                   onSelected: (_) => prov.setFilter(f),
//                   selectedColor: color,
//                   backgroundColor: secondaryColor,
//                   checkmarkColor: Colors.white,
//                   side: BorderSide(color: isSelected ? color : Colors.white24),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                 ),
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }

//   String _chipLabel(String f) {
//     switch (f) {
//       case 'All':
//         return '🌐  All';
//       case 'admin':
//         return '🛡️  Admin';
//       case 'user':
//         return '👤  User';
//       case 'guest':
//         return '👻  Guest';
//       case 'pending':
//         return '⏳  Pending Approval';
//       default:
//         return f;
//     }
//   }

//   Color _chipColor(String f) {
//     switch (f) {
//       case 'pending':
//         return const Color(0xFFFFC107);
//       case 'admin':
//         return const Color(0xFF667EEA);
//       case 'user':
//         return const Color(0xFF4CAF50);
//       case 'guest':
//         return Colors.orange;
//       default:
//         return primaryColor;
//     }
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  USER TABLE CONTAINER
// // ─────────────────────────────────────────────────────────────────────────────

// class _UserTable extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AllUsersProvider>(
//       builder: (context, prov, _) {
//         // Loading
//         if (prov.isLoading) {
//           return _shell(
//               child: const Center(
//             child: Padding(
//                 padding: EdgeInsets.all(60),
//                 child: CircularProgressIndicator()),
//           ));
//         }

//         // Empty
//         if (prov.users.isEmpty) {
//           return _shell(
//             child: Center(
//               child: Column(children: [
//                 const Icon(Icons.people_outline,
//                     size: 52, color: Colors.white24),
//                 const Gap(12),
//                 Text('No users found',
//                     style: TextStyle(color: Colors.white38, fontSize: 15)),
//               ]),
//             ),
//           );
//         }

//         final isMobile = Responsive.isMobile(context);

//         return _shell(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header row inside card
//               Row(
//                 children: [
//                   Text('Users  (${prov.users.length})',
//                       style: Theme.of(context).textTheme.titleMedium),
//                   if (prov.selectedFilter == 'pending') ...[
//                     const Gap(10),
//                     _mini('⏳ Awaiting Approval', const Color(0xFFFFC107)),
//                   ],
//                 ],
//               ),
//               Gap(defaultPadding),
//               isMobile
//                   ? _MobileUserList(users: prov.users, prov: prov)
//                   : _DesktopUserTable(users: prov.users, prov: prov),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _shell({required Widget child}) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: child,
//     );
//   }

//   Widget _mini(String label, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.4)),
//       ),
//       child: Text(label,
//           style: TextStyle(
//               fontSize: 11, color: color, fontWeight: FontWeight.w600)),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  DESKTOP TABLE — fills full width via LayoutBuilder + dataTableMinWidth trick
// // ─────────────────────────────────────────────────────────────────────────────

// class _DesktopUserTable extends StatelessWidget {
//   final List<User> users;
//   final AllUsersProvider prov;
//   const _DesktopUserTable({required this.users, required this.prov});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       return SizedBox(
//         width: constraints.maxWidth,
//         child: Theme(
//           // Remove default DataTable dividers color override if desired
//           data: Theme.of(context).copyWith(
//             dataTableTheme: DataTableThemeData(
//               headingRowColor:
//                   WidgetStateProperty.all(Colors.white.withOpacity(0.05)),
//               dataRowColor: WidgetStateProperty.resolveWith((states) {
//                 if (states.contains(WidgetState.hovered)) {
//                   return Colors.white.withOpacity(0.04);
//                 }
//                 return Colors.transparent;
//               }),
//             ),
//           ),
//           child: DataTable(
//             horizontalMargin: 12,
//             columnSpacing: 0, // let columns share space evenly
//             dataRowMinHeight: 54,
//             dataRowMaxHeight: 62,
//             columns: [
//               _col('#', flex: 1),
//               _col('Name', flex: 4),
//               _col('Email', flex: 5),
//               _col('Phone', flex: 3),
//               _col('Role', flex: 3),
//               _col('Status', flex: 3),
//               _col('Verified', flex: 2),
//               _col('Joined', flex: 3),
//               _col('Actions', flex: 5),
//             ],
//             rows: users.asMap().entries.map((e) {
//               return _buildRow(context, e.key + 1, e.value);
//             }).toList(),
//           ),
//         ),
//       );
//     });
//   }

//   // Helper: wrap label in Expanded to distribute width proportionally
//   DataColumn _col(String label, {int flex = 1}) {
//     return DataColumn(
//       label: Expanded(
//         flex: flex,
//         child: Text(label,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
//       ),
//     );
//   }

//   DataRow _buildRow(BuildContext context, int idx, User user) {
//     return DataRow(
//       // onSelectChanged: (_) => showUserDetailsDialog(context, user, prov),
//       cells: [
//         DataCell(Expanded(
//             flex: 1,
//             child: Text('$idx',
//                 style: const TextStyle(color: Colors.white54, fontSize: 12)))),
//         DataCell(Expanded(flex: 4, child: _NameCell(user: user))),
//         DataCell(Expanded(
//             flex: 5,
//             child: Text(user.email ?? '—',
//                 style: const TextStyle(fontSize: 12, color: Colors.white70),
//                 overflow: TextOverflow.ellipsis))),
//         DataCell(Expanded(
//             flex: 3,
//             child: Text(user.phone ?? '—',
//                 style: const TextStyle(fontSize: 12, color: Colors.white70)))),
//         DataCell(
//             Expanded(flex: 3, child: _RoleBadge(role: user.role ?? 'user'))),
//         DataCell(Expanded(
//             flex: 3, child: _StatusBadge(isActive: user.isActive ?? true))),
//         DataCell(Expanded(
//             flex: 2,
//             child: Icon(
//               (user.isVerified ?? false)
//                   ? Icons.verified_rounded
//                   : Icons.cancel_rounded,
//               size: 18,
//               color: (user.isVerified ?? false)
//                   ? const Color(0xFF4CAF50)
//                   : Colors.red,
//             ))),
//         DataCell(Expanded(
//             flex: 3,
//             child: Text(_formatDate(user.createdAt),
//                 style: const TextStyle(fontSize: 12, color: Colors.white54)))),
//         DataCell(
//             Expanded(flex: 5, child: _ActionButtons(user: user, prov: prov))),
//       ],
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  MOBILE LIST
// // ─────────────────────────────────────────────────────────────────────────────

// class _MobileUserList extends StatelessWidget {
//   final List<User> users;
//   final AllUsersProvider prov;
//   const _MobileUserList({required this.users, required this.prov});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: users.length,
//       separatorBuilder: (_, __) =>
//           const Divider(color: Colors.white12, height: 1),
//       itemBuilder: (context, i) {
//         final user = users[i];
//         return InkWell(
//           onTap: () => showUserDetailsDialog(context, user, prov),
//           borderRadius: BorderRadius.circular(8),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _AvatarWidget(name: user.name ?? '?', size: 42),
//                 const Gap(12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(user.name ?? 'Unknown',
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 14)),
//                       const Gap(2),
//                       Text(user.email ?? '',
//                           style: const TextStyle(
//                               fontSize: 11, color: Colors.white54)),
//                       const Gap(6),
//                       Wrap(spacing: 6, runSpacing: 4, children: [
//                         _RoleBadge(role: user.role ?? 'user'),
//                         _StatusBadge(isActive: user.isActive ?? true),
//                       ]),
//                     ],
//                   ),
//                 ),
//                 _ActionButtons(user: user, prov: prov, compact: true),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  USER DETAILS DIALOG
// // ─────────────────────────────────────────────────────────────────────────────

// void showUserDetailsDialog(
//     BuildContext context, User user, AllUsersProvider prov) {
//   showDialog(
//     context: context,
//     builder: (_) => _UserDetailsDialog(user: user, prov: prov),
//   );
// }

// class _UserDetailsDialog extends StatelessWidget {
//   final User user;
//   final AllUsersProvider prov;
//   const _UserDetailsDialog({required this.user, required this.prov});

//   @override
//   Widget build(BuildContext context) {
//     final avatarColor = _colorFromName(user.name ?? '?');
//     final isActive = user.isActive ?? true;
//     final isApproved = user.isApproved ?? false;
//     final isAdmin = user.role == 'admin';

//     return Dialog(
//       backgroundColor: bgColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       insetPadding: EdgeInsets.symmetric(
//         horizontal: Responsive.isMobile(context) ? 16 : 60,
//         vertical: 24,
//       ),
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 640),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ── Banner ──────────────────────────────────────────
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: avatarColor.withOpacity(0.1),
//                   borderRadius:
//                       const BorderRadius.vertical(top: Radius.circular(16)),
//                   border: Border(
//                     bottom: BorderSide(color: avatarColor.withOpacity(0.2)),
//                   ),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Avatar
//                     Container(
//                       width: 64,
//                       height: 64,
//                       decoration: BoxDecoration(
//                         color: avatarColor.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(14),
//                         border: Border.all(
//                             color: avatarColor.withOpacity(0.6), width: 2),
//                       ),
//                       child: Center(
//                         child: Text(
//                           (user.name?.isNotEmpty ?? false)
//                               ? user.name![0].toUpperCase()
//                               : '?',
//                           style: TextStyle(
//                               color: avatarColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 28),
//                         ),
//                       ),
//                     ),
//                     const Gap(16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(user.name ?? 'Unknown',
//                               style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white)),
//                           const Gap(4),
//                           Text(user.email ?? '',
//                               style: const TextStyle(
//                                   fontSize: 13, color: Colors.white60)),
//                           const Gap(8),
//                           Wrap(spacing: 6, runSpacing: 6, children: [
//                             _RoleBadge(role: user.role ?? 'user'),
//                             _StatusBadge(isActive: isActive),
//                             if (isAdmin) _ApprovalBadge(isApproved: isApproved),
//                           ]),
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close_rounded,
//                           color: Colors.white54),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ],
//                 ),
//               ),

//               // ── Body ────────────────────────────────────────────
//               Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Personal info
//                     _SectionLabel('Personal Information'),
//                     const Gap(12),
//                     _InfoGrid(children: [
//                       _InfoTile(
//                           icon: Icons.badge_rounded,
//                           label: 'Full Name',
//                           value: user.name ?? '—'),
//                       _InfoTile(
//                           icon: Icons.email_rounded,
//                           label: 'Email',
//                           value: user.email ?? '—',
//                           copyable: true),
//                       _InfoTile(
//                           icon: Icons.phone_rounded,
//                           label: 'Phone',
//                           value: user.phone ?? '—'),
//                       _InfoTile(
//                           icon: Icons.location_on_rounded,
//                           label: 'Location',
//                           value: user.location ?? '—'),
//                     ]),

//                     const Gap(20),
//                     const Divider(color: Colors.white12),
//                     const Gap(16),

//                     // Account details
//                     _SectionLabel('Account Details'),
//                     const Gap(12),
//                     _InfoGrid(children: [
//                       _InfoTile(
//                           icon: Icons.fingerprint_rounded,
//                           label: 'User ID',
//                           value: user.sId ?? '—',
//                           copyable: true,
//                           mono: true),
//                       _InfoTile(
//                           icon: Icons.shield_rounded,
//                           label: 'Role',
//                           value: user.role ?? '—'),
//                       _InfoTile(
//                           icon: Icons.verified_rounded,
//                           label: 'Email Verified',
//                           value: (user.isVerified ?? false) ? 'Yes ✓' : 'No ✗',
//                           valueColor: (user.isVerified ?? false)
//                               ? const Color(0xFF4CAF50)
//                               : const Color(0xFFFF6B6B)),
//                       _InfoTile(
//                           icon: Icons.toggle_on_rounded,
//                           label: 'Account Status',
//                           value: isActive ? 'Active' : 'Blocked',
//                           valueColor: isActive
//                               ? const Color(0xFF4CAF50)
//                               : const Color(0xFFFF6B6B)),
//                       if (isAdmin)
//                         _InfoTile(
//                             icon: Icons.how_to_reg_rounded,
//                             label: 'Admin Approved',
//                             value: isApproved ? 'Yes ✓' : 'Pending ✗',
//                             valueColor: isApproved
//                                 ? const Color(0xFF4CAF50)
//                                 : const Color(0xFFFFC107)),
//                       _InfoTile(
//                           icon: Icons.calendar_today_rounded,
//                           label: 'Joined',
//                           value: _formatDate(user.createdAt)),
//                       _InfoTile(
//                           icon: Icons.update_rounded,
//                           label: 'Last Updated',
//                           value: _formatDate(user.updatedAt)),
//                     ]),

//                     const Gap(20),
//                     const Divider(color: Colors.white12),
//                     const Gap(16),

//                     // Security
//                     _SectionLabel('Security & Activity'),
//                     const Gap(12),
//                     _InfoGrid(children: [
//                       _InfoTile(
//                           icon: Icons.login_rounded,
//                           label: 'Last Login',
//                           value: _formatDateTime(user.lastLoginAt)),
//                       _InfoTile(
//                           icon: Icons.router_rounded,
//                           label: 'Last IP',
//                           value: user.lastLoginIp ?? '—',
//                           mono: true),
//                       _InfoTile(
//                           icon: Icons.warning_amber_rounded,
//                           label: 'Failed Logins',
//                           value: '${user.failedLoginAttempts ?? 0}',
//                           valueColor: (user.failedLoginAttempts ?? 0) > 0
//                               ? const Color(0xFFFF9800)
//                               : null),
//                       _InfoTile(
//                           icon: Icons.lock_clock_rounded,
//                           label: 'Account Locked',
//                           value: user.isAccountLocked
//                               ? 'Yes — ${user.lockUntilRemaining}'
//                               : 'No',
//                           valueColor: user.isAccountLocked
//                               ? const Color(0xFFFF6B6B)
//                               : const Color(0xFF4CAF50)),
//                     ]),

//                     // Login history
//                     if ((user.loginHistory?.isNotEmpty) ?? false) ...[
//                       const Gap(20),
//                       const Divider(color: Colors.white12),
//                       const Gap(16),
//                       _SectionLabel('Recent Login History'),
//                       const Gap(12),
//                       ...(user.loginHistory ?? []).reversed.take(5).map(
//                             (h) => Padding(
//                               padding: const EdgeInsets.only(bottom: 6),
//                               child: _LoginHistoryTile(history: h),
//                             ),
//                           ),
//                     ],

//                     const Gap(24),

//                     // Quick actions
//                     _SectionLabel('Quick Actions'),
//                     const Gap(12),
//                     Wrap(
//                       spacing: 10,
//                       runSpacing: 10,
//                       children: [
//                         if (isAdmin)
//                           _DialogActionBtn(
//                             label: isApproved
//                                 ? 'Revoke Approval'
//                                 : 'Approve Admin',
//                             icon: isApproved
//                                 ? Icons.remove_circle_outline
//                                 : Icons.check_circle_outline_rounded,
//                             color: isApproved
//                                 ? Colors.orange
//                                 : const Color(0xFF4CAF50),
//                             onTap: () {
//                               Navigator.pop(context);
//                               prov.toggleAdminApproval(user);
//                             },
//                           ),
//                         _DialogActionBtn(
//                           label: isActive ? 'Block User' : 'Unblock User',
//                           icon: isActive
//                               ? Icons.block_rounded
//                               : Icons.lock_open_rounded,
//                           color: isActive
//                               ? const Color(0xFFFF6B6B)
//                               : const Color(0xFF4CAF50),
//                           onTap: () {
//                             Navigator.pop(context);
//                             prov.toggleUserActive(user);
//                           },
//                         ),
//                         _DialogActionBtn(
//                           label: 'Force Logout',
//                           icon: Icons.logout_rounded,
//                           color: Colors.orange,
//                           onTap: () {
//                             Navigator.pop(context);
//                             prov.forceLogout(user);
//                           },
//                         ),
//                         _DialogActionBtn(
//                           label: 'Delete User',
//                           icon: Icons.delete_outline_rounded,
//                           color: Colors.red,
//                           onTap: () {
//                             Navigator.pop(context);
//                             prov.deleteUser(user);
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  DIALOG SUB-WIDGETS
// // ─────────────────────────────────────────────────────────────────────────────

// class _SectionLabel extends StatelessWidget {
//   final String label;
//   const _SectionLabel(this.label);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       label.toUpperCase(),
//       style: const TextStyle(
//           fontSize: 10,
//           letterSpacing: 1.4,
//           fontWeight: FontWeight.bold,
//           color: Colors.white38),
//     );
//   }
// }

// class _InfoGrid extends StatelessWidget {
//   final List<Widget> children;
//   const _InfoGrid({required this.children});

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = Responsive.isMobile(context);
//     if (isMobile) {
//       return Column(
//         children: children
//             .map((c) =>
//                 Padding(padding: const EdgeInsets.only(bottom: 8), child: c))
//             .toList(),
//       );
//     }
//     final rows = <Widget>[];
//     for (int i = 0; i < children.length; i += 2) {
//       rows.add(Row(children: [
//         Expanded(child: children[i]),
//         const Gap(10),
//         Expanded(
//             child: i + 1 < children.length
//                 ? children[i + 1]
//                 : const SizedBox.shrink()),
//       ]));
//       if (i + 2 < children.length) rows.add(const Gap(8));
//     }
//     return Column(children: rows);
//   }
// }

// class _InfoTile extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//   final Color? valueColor;
//   final bool copyable;
//   final bool mono;

//   const _InfoTile({
//     required this.icon,
//     required this.label,
//     required this.value,
//     this.valueColor,
//     this.copyable = false,
//     this.mono = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.04),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.white.withOpacity(0.07)),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 16, color: Colors.white30),
//           const Gap(10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(label,
//                     style:
//                         const TextStyle(fontSize: 10, color: Colors.white38)),
//                 const Gap(2),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: mono ? 11 : 13,
//                     color: valueColor ?? Colors.white70,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: mono ? 'monospace' : null,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                 ),
//               ],
//             ),
//           ),
//           if (copyable)
//             GestureDetector(
//               onTap: () {
//                 Clipboard.setData(ClipboardData(text: value));
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   content: Text('$label copied!'),
//                   duration: const Duration(seconds: 1),
//                   behavior: SnackBarBehavior.floating,
//                 ));
//               },
//               child: const Padding(
//                 padding: EdgeInsets.only(left: 6),
//                 child:
//                     Icon(Icons.copy_rounded, size: 14, color: Colors.white30),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _LoginHistoryTile extends StatelessWidget {
//   final LoginHistory history;
//   const _LoginHistoryTile({required this.history});

//   @override
//   Widget build(BuildContext context) {
//     final ok = history.success ?? false;
//     final color = ok ? const Color(0xFF4CAF50) : const Color(0xFFFF6B6B);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.06),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Row(
//         children: [
//           Icon(ok ? Icons.check_circle_rounded : Icons.cancel_rounded,
//               size: 16, color: color),
//           const Gap(10),
//           Expanded(
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(_formatDateTime(history.timestamp),
//                   style: const TextStyle(fontSize: 12, color: Colors.white70)),
//               if (history.ip != null)
//                 Text('IP: ${history.ip}',
//                     style: const TextStyle(
//                         fontSize: 10,
//                         color: Colors.white38,
//                         fontFamily: 'monospace')),
//             ]),
//           ),
//           Text(ok ? 'Success' : 'Failed',
//               style: TextStyle(
//                   fontSize: 11, fontWeight: FontWeight.bold, color: color)),
//         ],
//       ),
//     );
//   }
// }

// class _DialogActionBtn extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final Color color;
//   final VoidCallback onTap;
//   const _DialogActionBtn({
//     required this.label,
//     required this.icon,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton.icon(
//       onPressed: onTap,
//       icon: Icon(icon, size: 16, color: color),
//       label: Text(label, style: TextStyle(color: color, fontSize: 13)),
//       style: OutlinedButton.styleFrom(
//         side: BorderSide(color: color.withOpacity(0.5)),
//         backgroundColor: color.withOpacity(0.08),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  SHARED BADGE / CELL WIDGETS
// // ─────────────────────────────────────────────────────────────────────────────

// class _NameCell extends StatelessWidget {
//   final User user;
//   const _NameCell({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Row(mainAxisSize: MainAxisSize.min, children: [
//       _AvatarWidget(name: user.name ?? '?', size: 30),
//       const Gap(10),
//       Flexible(
//         child: Text(user.name ?? 'Unknown',
//             style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//             overflow: TextOverflow.ellipsis),
//       ),
//     ]);
//   }
// }

// class _AvatarWidget extends StatelessWidget {
//   final String name;
//   final double size;
//   const _AvatarWidget({required this.name, required this.size});

//   @override
//   Widget build(BuildContext context) {
//     final color = _colorFromName(name);
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: color.withOpacity(0.5)),
//       ),
//       child: Center(
//         child: Text(
//           name.isNotEmpty ? name[0].toUpperCase() : '?',
//           style: TextStyle(
//               color: color, fontWeight: FontWeight.bold, fontSize: size * 0.45),
//         ),
//       ),
//     );
//   }
// }

// class _RoleBadge extends StatelessWidget {
//   final String role;
//   const _RoleBadge({required this.role});

//   @override
//   Widget build(BuildContext context) {
//     final (color, emoji) = _roleConfig(role);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.4)),
//       ),
//       child: Text('$emoji  $role',
//           style: TextStyle(
//               fontSize: 11, color: color, fontWeight: FontWeight.w600)),
//     );
//   }
// }

// class _StatusBadge extends StatelessWidget {
//   final bool isActive;
//   const _StatusBadge({required this.isActive});

//   @override
//   Widget build(BuildContext context) {
//     final color = isActive ? const Color(0xFF4CAF50) : const Color(0xFFFF6B6B);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.4)),
//       ),
//       child: Row(mainAxisSize: MainAxisSize.min, children: [
//         Container(
//             width: 6,
//             height: 6,
//             decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
//         const Gap(5),
//         Text(isActive ? 'Active' : 'Blocked',
//             style: TextStyle(
//                 fontSize: 11, color: color, fontWeight: FontWeight.w600)),
//       ]),
//     );
//   }
// }

// class _ApprovalBadge extends StatelessWidget {
//   final bool isApproved;
//   const _ApprovalBadge({required this.isApproved});

//   @override
//   Widget build(BuildContext context) {
//     final color =
//         isApproved ? const Color(0xFF4CAF50) : const Color(0xFFFFC107);
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.4)),
//       ),
//       child: Text(isApproved ? '✓ Approved' : '⏳ Pending',
//           style: TextStyle(
//               fontSize: 11, color: color, fontWeight: FontWeight.w600)),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  ACTION BUTTONS (table row)
// // ─────────────────────────────────────────────────────────────────────────────

// class _ActionButtons extends StatelessWidget {
//   final User user;
//   final AllUsersProvider prov;
//   final bool compact;

//   const _ActionButtons({
//     required this.user,
//     required this.prov,
//     this.compact = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isActive = user.isActive ?? true;
//     final isApproved = user.isApproved ?? false;
//     final isAdmin = user.role == 'admin';

//     if (compact) {
//       return PopupMenuButton<String>(
//         icon: const Icon(Icons.more_vert_rounded, size: 20),
//         color: bgColor,
//         itemBuilder: (_) => [
//           _pmi('details', Icons.info_outline_rounded, 'View Details',
//               Colors.white70),
//           if (isAdmin)
//             _pmi(
//                 'approve',
//                 isApproved
//                     ? Icons.remove_circle_outline
//                     : Icons.check_circle_outline,
//                 isApproved ? 'Revoke Approval' : 'Approve Admin',
//                 isApproved ? Colors.orange : const Color(0xFF4CAF50)),
//           _pmi(
//               'block',
//               isActive ? Icons.block_rounded : Icons.lock_open_rounded,
//               isActive ? 'Block User' : 'Unblock User',
//               isActive ? const Color(0xFFFF6B6B) : const Color(0xFF4CAF50)),
//           _pmi('delete', Icons.delete_outline_rounded, 'Delete',
//               Colors.redAccent),
//         ],
//         onSelected: (val) {
//           switch (val) {
//             case 'details':
//               showUserDetailsDialog(context, user, prov);
//               break;
//             case 'approve':
//               prov.toggleAdminApproval(user);
//               break;
//             case 'block':
//               prov.toggleUserActive(user);
//               break;
//             case 'delete':
//               _confirmDelete(context);
//               break;
//           }
//         },
//       );
//     }

//     return Row(mainAxisSize: MainAxisSize.min, children: [
//       _ActionIconBtn(
//         tooltip: 'View Details',
//         icon: Icons.info_outline_rounded,
//         color: Colors.white54,
//         onTap: () => showUserDetailsDialog(context, user, prov),
//       ),
//       const Gap(4),
//       if (isAdmin) ...[
//         _ActionIconBtn(
//           tooltip: isApproved ? 'Revoke Approval' : 'Approve Admin',
//           icon: isApproved
//               ? Icons.remove_circle_outline
//               : Icons.check_circle_outline_rounded,
//           color: isApproved ? Colors.orange : const Color(0xFF4CAF50),
//           onTap: () => prov.toggleAdminApproval(user),
//         ),
//         const Gap(4),
//       ],
//       _ActionIconBtn(
//         tooltip: isActive ? 'Block User' : 'Unblock User',
//         icon: isActive ? Icons.block_rounded : Icons.lock_open_rounded,
//         color: isActive ? const Color(0xFFFF6B6B) : const Color(0xFF4CAF50),
//         onTap: () => prov.toggleUserActive(user),
//       ),
//       const Gap(4),
//       _ActionIconBtn(
//         tooltip: 'Delete User',
//         icon: Icons.delete_outline_rounded,
//         color: Colors.red,
//         onTap: () => _confirmDelete(context),
//       ),
//     ]);
//   }

//   PopupMenuItem<String> _pmi(
//       String val, IconData icon, String label, Color color) {
//     return PopupMenuItem(
//       value: val,
//       child: Row(children: [
//         Icon(icon, size: 18, color: color),
//         const Gap(8),
//         Text(label, style: TextStyle(color: color)),
//       ]),
//     );
//   }

//   void _confirmDelete(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         backgroundColor: bgColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         title: Text('Delete ${user.name}?',
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         content: const Text('This action cannot be undone.',
//             style: TextStyle(color: Colors.white60, fontSize: 13)),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child:
//                 const Text('Cancel', style: TextStyle(color: Colors.white54)),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8)),
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//               prov.deleteUser(user);
//             },
//             child: const Text('Delete', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ActionIconBtn extends StatelessWidget {
//   final String tooltip;
//   final IconData icon;
//   final Color color;
//   final VoidCallback onTap;
//   const _ActionIconBtn({
//     required this.tooltip,
//     required this.icon,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Tooltip(
//       message: tooltip,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(6),
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.all(6),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(6),
//           ),
//           child: Icon(icon, size: 17, color: color),
//         ),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// //  HELPERS
// // ─────────────────────────────────────────────────────────────────────────────

// Color _colorFromName(String name) {
//   final palette = [
//     const Color(0xFF667EEA),
//     const Color(0xFF4CAF50),
//     const Color(0xFFFF9800),
//     const Color(0xFFE91E63),
//     const Color(0xFF00BCD4),
//     const Color(0xFF9C27B0),
//   ];
//   if (name.isEmpty) return palette[0];
//   return palette[name.codeUnitAt(0) % palette.length];
// }

// (Color, String) _roleConfig(String role) {
//   switch (role) {
//     case 'superAdmin':
//       return (const Color(0xFFFF6B6B), '👑');
//     case 'admin':
//       return (const Color(0xFF667EEA), '🛡️');
//     case 'user':
//       return (const Color(0xFF4CAF50), '👤');
//     case 'guest':
//       return (Colors.orange, '👻');
//     default:
//       return (Colors.grey, '•');
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

// String _formatDateTime(DateTime? dt) {
//   if (dt == null) return '—';
//   return '${dt.day.toString().padLeft(2, '0')}/'
//       '${dt.month.toString().padLeft(2, '0')}/${dt.year}  '
//       '${dt.hour.toString().padLeft(2, '0')}:'
//       '${dt.minute.toString().padLeft(2, '0')}';
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import '../../../utility/constants.dart';
import 'provider/all_user_provider.dart';
import 'components/all_users_header.dart';
import 'components/stats_row.dart';
import 'components/filter_chips.dart';
import 'components/user_table.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize data when screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AllUsersProvider>().getAllUsers();
    });

    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AllUserHeader(),
            Gap(defaultPadding),
            StatsRow(),
            Gap(defaultPadding),
            FilterChips(),
            Gap(defaultPadding),
            UserTable(),
          ],
        ),
      ),
    );
  }
}
