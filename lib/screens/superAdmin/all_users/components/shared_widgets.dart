import 'package:admin/models/user.dart';
import 'package:admin/screens/superAdmin/all_users/components/user_details_dialog.dart';
import 'package:admin/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../provider/all_user_provider.dart';

class AvatarWidget extends StatelessWidget {
  final String name;
  final double size;
  const AvatarWidget({required this.name, required this.size});

  @override
  Widget build(BuildContext context) {
    final color = _colorFromName(name);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: size * 0.45),
        ),
      ),
    );
  }
}

class NameCell extends StatelessWidget {
  final User user;
  const NameCell({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      AvatarWidget(name: user.name ?? '?', size: 32),
      const Gap(12),
      Flexible(
        child: Text(user.name ?? 'Unknown',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis),
      ),
    ]);
  }
}

class RoleBadge extends StatelessWidget {
  final String role;
  const RoleBadge({required this.role});

  @override
  Widget build(BuildContext context) {
    final (color, emoji) = _roleConfig(role);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text('$emoji  $role',
          style: TextStyle(
              fontSize: 12, color: color, fontWeight: FontWeight.w600)),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final bool isActive;
  const StatusBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF4CAF50) : const Color(0xFFFF6B6B);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const Gap(6),
        Text(isActive ? 'Active' : 'Blocked',
            style: TextStyle(
                fontSize: 12, color: color, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

class ApprovalBadge extends StatelessWidget {
  final bool isApproved;
  const ApprovalBadge({required this.isApproved});

  @override
  Widget build(BuildContext context) {
    final color =
        isApproved ? const Color(0xFF4CAF50) : const Color(0xFFFFC107);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(isApproved ? '✓ Approved' : '⏳ Pending',
          style: TextStyle(
              fontSize: 12, color: color, fontWeight: FontWeight.w600)),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final User user;
  final AllUsersProvider prov;

  const ActionButtons({
    required this.user,
    required this.prov,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = user.isActive ?? true;
    final isApproved = user.isApproved ?? false;
    final isAdmin = user.role == 'admin';

    return Row(mainAxisSize: MainAxisSize.min, children: [
      ActionIconBtn(
        tooltip: 'View Details',
        icon: Icons.info_outline_rounded,
        color: Colors.white54,
        onTap: () => showUserDetailsDialog(context, user, prov),
      ),
      const Gap(8),
      if (isAdmin) ...[
        ActionIconBtn(
          tooltip: isApproved ? 'Revoke Approval' : 'Approve Admin',
          icon: isApproved
              ? Icons.remove_circle_outline
              : Icons.check_circle_outline_rounded,
          color: isApproved ? Colors.orange : const Color(0xFF4CAF50),
          onTap: () => prov.toggleAdminApproval(user),
        ),
        const Gap(8),
      ],
      ActionIconBtn(
        tooltip: isActive ? 'Block User' : 'Unblock User',
        icon: isActive ? Icons.block_rounded : Icons.lock_open_rounded,
        color: isActive ? const Color(0xFFFF6B6B) : const Color(0xFF4CAF50),
        onTap: () => prov.toggleUserActive(user),
      ),
      const Gap(8),
      ActionIconBtn(
        tooltip: 'Delete User',
        icon: Icons.delete_outline_rounded,
        color: Colors.red,
        onTap: () => _confirmDelete(context),
      ),
    ]);
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text('Delete ${user.name}?',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        content: const Text('This action cannot be undone.',
            style: TextStyle(color: Colors.white60, fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(context);
              prov.deleteUser(user);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class CompactActionButtons extends StatelessWidget {
  final User user;
  final AllUsersProvider prov;

  const CompactActionButtons({
    required this.user,
    required this.prov,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = user.isActive ?? true;
    final isApproved = user.isApproved ?? false;
    final isAdmin = user.role == 'admin';

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert_rounded, size: 20),
      color: bgColor,
      itemBuilder: (_) => [
        _pmi('details', Icons.info_outline_rounded, 'View Details',
            Colors.white70),
        if (isAdmin)
          _pmi(
              'approve',
              isApproved
                  ? Icons.remove_circle_outline
                  : Icons.check_circle_outline,
              isApproved ? 'Revoke Approval' : 'Approve Admin',
              isApproved ? Colors.orange : const Color(0xFF4CAF50)),
        _pmi(
            'block',
            isActive ? Icons.block_rounded : Icons.lock_open_rounded,
            isActive ? 'Block User' : 'Unblock User',
            isActive ? const Color(0xFFFF6B6B) : const Color(0xFF4CAF50)),
        _pmi(
            'delete', Icons.delete_outline_rounded, 'Delete', Colors.redAccent),
      ],
      onSelected: (val) {
        switch (val) {
          case 'details':
            showUserDetailsDialog(context, user, prov);
            break;
          case 'approve':
            prov.toggleAdminApproval(user);
            break;
          case 'block':
            prov.toggleUserActive(user);
            break;
          case 'delete':
            _confirmDelete(context);
            break;
        }
      },
    );
  }

  PopupMenuItem<String> _pmi(
      String val, IconData icon, String label, Color color) {
    return PopupMenuItem(
      value: val,
      child: Row(children: [
        Icon(icon, size: 18, color: color),
        const Gap(8),
        Text(label, style: TextStyle(color: color)),
      ]),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text('Delete ${user.name}?',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        content: const Text('This action cannot be undone.',
            style: TextStyle(color: Colors.white60, fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(context);
              prov.deleteUser(user);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class ActionIconBtn extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const ActionIconBtn({
    required this.tooltip,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}

Color _colorFromName(String name) {
  final palette = [
    const Color(0xFF667EEA),
    const Color(0xFF4CAF50),
    const Color(0xFFFF9800),
    const Color(0xFFE91E63),
    const Color(0xFF00BCD4),
    const Color(0xFF9C27B0),
  ];
  if (name.isEmpty) return palette[0];
  return palette[name.codeUnitAt(0) % palette.length];
}

(Color, String) _roleConfig(String role) {
  switch (role) {
    case 'superAdmin':
      return (const Color(0xFFFF6B6B), '👑');
    case 'admin':
      return (const Color(0xFF667EEA), '🛡️');
    case 'user':
      return (const Color(0xFF4CAF50), '👤');
    case 'guest':
      return (Colors.orange, '👻');
    default:
      return (Colors.grey, '•');
  }
}
