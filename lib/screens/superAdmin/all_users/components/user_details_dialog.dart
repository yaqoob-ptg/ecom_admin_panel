import 'package:admin/models/user.dart';
import 'package:admin/utility/constants.dart';
import 'package:admin/utility/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../provider/all_user_provider.dart';
import 'shared_widgets.dart';

void showUserDetailsDialog(
    BuildContext context, User user, AllUsersProvider prov) {
  showDialog(
    context: context,
    builder: (_) => _UserDetailsDialog(user: user, prov: prov),
  );
}

class _UserDetailsDialog extends StatelessWidget {
  final User user;
  final AllUsersProvider prov;
  const _UserDetailsDialog({required this.user, required this.prov});

  @override
  Widget build(BuildContext context) {
    final avatarColor = _colorFromName(user.name ?? '?');
    final isActive = user.isActive ?? true;
    final isApproved = user.isApproved ?? false;
    final isAdmin = user.role == 'admin';

    return Dialog(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 16 : 60,
        vertical: 24,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: avatarColor.withOpacity(0.1),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  border: Border(
                    bottom: BorderSide(color: avatarColor.withOpacity(0.2)),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: avatarColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: avatarColor.withOpacity(0.6), width: 2),
                      ),
                      child: Center(
                        child: Text(
                          (user.name?.isNotEmpty ?? false)
                              ? user.name![0].toUpperCase()
                              : '?',
                          style: TextStyle(
                              color: avatarColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name ?? 'Unknown',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const Gap(4),
                          Text(user.email ?? '',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.white60)),
                          const Gap(8),
                          Wrap(spacing: 6, runSpacing: 6, children: [
                            RoleBadge(role: user.role ?? 'user'),
                            StatusBadge(isActive: isActive),
                            if (isAdmin) ApprovalBadge(isApproved: isApproved),
                          ]),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded,
                          color: Colors.white54),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Body
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionLabel('Personal Information'),
                    const Gap(12),
                    _InfoGrid(children: [
                      _InfoTile(
                          icon: Icons.badge_rounded,
                          label: 'Full Name',
                          value: user.name ?? '—'),
                      _InfoTile(
                          icon: Icons.email_rounded,
                          label: 'Email',
                          value: user.email ?? '—',
                          copyable: true),
                      _InfoTile(
                          icon: Icons.phone_rounded,
                          label: 'Phone',
                          value: user.phone ?? '—'),
                      _InfoTile(
                          icon: Icons.location_on_rounded,
                          label: 'Location',
                          value: user.location ?? '—'),
                    ]),
                    const Gap(20),
                    const Divider(color: Colors.white12),
                    const Gap(16),
                    _SectionLabel('Account Details'),
                    const Gap(12),
                    _InfoGrid(children: [
                      _InfoTile(
                          icon: Icons.fingerprint_rounded,
                          label: 'User ID',
                          value: user.sId ?? '—',
                          copyable: true,
                          mono: true),
                      _InfoTile(
                          icon: Icons.shield_rounded,
                          label: 'Role',
                          value: user.role ?? '—'),
                      _InfoTile(
                          icon: Icons.verified_rounded,
                          label: 'Email Verified',
                          value: (user.isVerified ?? false) ? 'Yes ✓' : 'No ✗',
                          valueColor: (user.isVerified ?? false)
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFFF6B6B)),
                      _InfoTile(
                          icon: Icons.toggle_on_rounded,
                          label: 'Account Status',
                          value: isActive ? 'Active' : 'Blocked',
                          valueColor: isActive
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFFF6B6B)),
                      if (isAdmin)
                        _InfoTile(
                            icon: Icons.how_to_reg_rounded,
                            label: 'Admin Approved',
                            value: isApproved ? 'Yes ✓' : 'Pending ✗',
                            valueColor: isApproved
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFFFFC107)),
                      _InfoTile(
                          icon: Icons.calendar_today_rounded,
                          label: 'Joined',
                          value: _formatDate(user.createdAt)),
                      _InfoTile(
                          icon: Icons.update_rounded,
                          label: 'Last Updated',
                          value: _formatDate(user.updatedAt)),
                    ]),
                    const Gap(20),
                    const Divider(color: Colors.white12),
                    const Gap(16),
                    _SectionLabel('Security & Activity'),
                    const Gap(12),
                    _InfoGrid(children: [
                      _InfoTile(
                          icon: Icons.login_rounded,
                          label: 'Last Login',
                          value: _formatDateTime(user.lastLoginAt)),
                      _InfoTile(
                          icon: Icons.router_rounded,
                          label: 'Last IP',
                          value: user.lastLoginIp ?? '—',
                          mono: true),
                      _InfoTile(
                          icon: Icons.warning_amber_rounded,
                          label: 'Failed Logins',
                          value: '${user.failedLoginAttempts ?? 0}',
                          valueColor: (user.failedLoginAttempts ?? 0) > 0
                              ? const Color(0xFFFF9800)
                              : null),
                      _InfoTile(
                          icon: Icons.lock_clock_rounded,
                          label: 'Account Locked',
                          value: user.isAccountLocked
                              ? 'Yes — ${user.lockUntilRemaining}'
                              : 'No',
                          valueColor: user.isAccountLocked
                              ? const Color(0xFFFF6B6B)
                              : const Color(0xFF4CAF50)),
                    ]),
                    if ((user.loginHistory?.isNotEmpty) ?? false) ...[
                      const Gap(20),
                      const Divider(color: Colors.white12),
                      const Gap(16),
                      _SectionLabel('Recent Login History'),
                      const Gap(12),
                      ...(user.loginHistory ?? []).reversed.take(5).map(
                            (h) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: _LoginHistoryTile(history: h),
                            ),
                          ),
                    ],
                    const Gap(24),
                    _SectionLabel('Quick Actions'),
                    const Gap(12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        if (isAdmin)
                          _DialogActionBtn(
                            label: isApproved
                                ? 'Revoke Approval'
                                : 'Approve Admin',
                            icon: isApproved
                                ? Icons.remove_circle_outline
                                : Icons.check_circle_outline_rounded,
                            color: isApproved
                                ? Colors.orange
                                : const Color(0xFF4CAF50),
                            onTap: () {
                              Navigator.pop(context);
                              prov.toggleAdminApproval(user);
                            },
                          ),
                        _DialogActionBtn(
                          label: isActive ? 'Block User' : 'Unblock User',
                          icon: isActive
                              ? Icons.block_rounded
                              : Icons.lock_open_rounded,
                          color: isActive
                              ? const Color(0xFFFF6B6B)
                              : const Color(0xFF4CAF50),
                          onTap: () {
                            Navigator.pop(context);
                            prov.toggleUserActive(user);
                          },
                        ),
                        _DialogActionBtn(
                          label: 'Force Logout',
                          icon: Icons.logout_rounded,
                          color: Colors.orange,
                          onTap: () {
                            Navigator.pop(context);
                            prov.forceLogout(user);
                          },
                        ),
                        _DialogActionBtn(
                          label: 'Delete User',
                          icon: Icons.delete_outline_rounded,
                          color: Colors.red,
                          onTap: () {
                            Navigator.pop(context);
                            prov.deleteUser(user);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper widgets for dialog
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
          fontSize: 10,
          letterSpacing: 1.4,
          fontWeight: FontWeight.bold,
          color: Colors.white38),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final List<Widget> children;
  const _InfoGrid({required this.children});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    if (isMobile) {
      return Column(
        children: children
            .map((c) =>
                Padding(padding: const EdgeInsets.only(bottom: 8), child: c))
            .toList(),
      );
    }
    final rows = <Widget>[];
    for (int i = 0; i < children.length; i += 2) {
      rows.add(Row(children: [
        Expanded(child: children[i]),
        const Gap(10),
        Expanded(
            child: i + 1 < children.length
                ? children[i + 1]
                : const SizedBox.shrink()),
      ]));
      if (i + 2 < children.length) rows.add(const Gap(8));
    }
    return Column(children: rows);
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final bool copyable;
  final bool mono;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.copyable = false,
    this.mono = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white30),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        const TextStyle(fontSize: 10, color: Colors.white38)),
                const Gap(2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: mono ? 11 : 13,
                    color: valueColor ?? Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontFamily: mono ? 'monospace' : null,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          if (copyable)
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$label copied!'),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ));
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 6),
                child:
                    Icon(Icons.copy_rounded, size: 14, color: Colors.white30),
              ),
            ),
        ],
      ),
    );
  }
}

class _LoginHistoryTile extends StatelessWidget {
  final LoginHistory history;
  const _LoginHistoryTile({required this.history});

  @override
  Widget build(BuildContext context) {
    final ok = history.success ?? false;
    final color = ok ? const Color(0xFF4CAF50) : const Color(0xFFFF6B6B);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(ok ? Icons.check_circle_rounded : Icons.cancel_rounded,
              size: 16, color: color),
          const Gap(10),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_formatDateTime(history.timestamp),
                  style: const TextStyle(fontSize: 12, color: Colors.white70)),
              if (history.ip != null)
                Text('IP: ${history.ip}',
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white38,
                        fontFamily: 'monospace')),
            ]),
          ),
          Text(ok ? 'Success' : 'Failed',
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

class _DialogActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _DialogActionBtn({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: color),
      label: Text(label, style: TextStyle(color: color, fontSize: 13)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color.withOpacity(0.5)),
        backgroundColor: color.withOpacity(0.08),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

// Helper functions
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

String _formatDateTime(DateTime? dt) {
  if (dt == null) return '—';
  return '${dt.day.toString().padLeft(2, '0')}/'
      '${dt.month.toString().padLeft(2, '0')}/${dt.year}  '
      '${dt.hour.toString().padLeft(2, '0')}:'
      '${dt.minute.toString().padLeft(2, '0')}';
}
