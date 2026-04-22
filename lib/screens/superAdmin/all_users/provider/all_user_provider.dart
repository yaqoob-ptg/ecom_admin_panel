// import 'dart:developer';
// import 'package:admin/models/user.dart';
// import 'package:admin/services/http_services.dart';
// import 'package:admin/utility/snack_bar_helper.dart';
// import 'package:flutter/material.dart';

// class AllUsersProvider extends ChangeNotifier {
//   HttpService service = HttpService();

//   List<User> _allUsers = [];
//   List<User> _filteredUsers = [];
//   bool isLoading = false;
//   String _selectedRole = 'All';
//   String _searchKeyword = '';

//   List<User> get users => _filteredUsers;
//   String get selectedRole => _selectedRole;

//   final List<String> roleFilters = ['All', 'user', 'admin', 'guest'];

//   Future<void> getAllUsers({bool showSnack = false}) async {
//     try {
//       isLoading = true;
//       notifyListeners();

//       // Fetch all users from super admin endpoint
//       final response =
//           await service.getItems(endpointUrl: 'super-admin/users?limit=500');

//       if (response.isOk) {
//         final body = response.body;
//         final List usersJson = body['data']['users'] ?? [];
//         _allUsers = usersJson.map((json) => User.fromJson(json)).toList();
//         _applyFilters();
//         if (showSnack)
//           SnackBarHelper.showSuccessSnackBar('Users loaded successfully');
//       } else {
//         if (showSnack) {
//           SnackBarHelper.showErrorSnackBar(
//             response.body?['message'] ?? 'Failed to load users',
//           );
//         }
//       }
//     } catch (e) {
//       log('Error loading users: $e');
//       if (showSnack) SnackBarHelper.showErrorSnackBar('Error: $e');
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   void filterByRole(String role) {
//     _selectedRole = role;
//     _applyFilters();
//   }

//   void filterByKeyword(String keyword) {
//     _searchKeyword = keyword.toLowerCase();
//     _applyFilters();
//   }

//   void _applyFilters() {
//     List<User> result = List.from(_allUsers);

//     // Role filter
//     if (_selectedRole != 'All') {
//       result = result.where((u) => u.role == _selectedRole).toList();
//     }

//     // Search filter
//     if (_searchKeyword.isNotEmpty) {
//       result = result.where((u) {
//         final nameMatch = (u.name ?? '').toLowerCase().contains(_searchKeyword);
//         final emailMatch =
//             (u.email ?? '').toLowerCase().contains(_searchKeyword);
//         return nameMatch || emailMatch;
//       }).toList();
//     }

//     _filteredUsers = result;
//     notifyListeners();
//   }

//   /// Toggle block/unblock for a user
//   Future<void> toggleUserActive(User user) async {
//     final newStatus = !(user.isActive ?? true);
//     try {
//       final response = await service.updateItem(
//         endpointUrl: 'super-admin/users/${user.sId}/toggle-active',
//         itemData: {'isActive': newStatus},
//         itemId: '',
//       );

//       if (response.isOk) {
//         final idx = _allUsers.indexWhere((u) => u.sId == user.sId);
//         if (idx != -1) {
//           _allUsers[idx] = _allUsers[idx].copyWith(isActive: newStatus);
//         }
//         _applyFilters();
//         SnackBarHelper.showSuccessSnackBar(
//           newStatus
//               ? 'User unblocked successfully'
//               : 'User blocked and logged out',
//         );
//       } else {
//         SnackBarHelper.showErrorSnackBar(
//           response.body?['message'] ?? 'Failed to update user status',
//         );
//       }
//     } catch (e) {
//       log('Error toggling user active: $e');
//       SnackBarHelper.showErrorSnackBar('Error: $e');
//     }
//   }

//   /// Approve / unapprove an admin
//   Future<void> toggleAdminApproval(User user) async {
//     final newApproval = !(user.isApproved ?? false);
//     try {
//       final response = await service.updateItem(
//         endpointUrl: 'super-admin/users/${user.sId}/approve',
//         itemData: {'isApproved': newApproval},
//         itemId: '',
//       );

//       if (response.isOk) {
//         final idx = _allUsers.indexWhere((u) => u.sId == user.sId);
//         if (idx != -1) {
//           _allUsers[idx] = _allUsers[idx].copyWith(isApproved: newApproval);
//         }
//         _applyFilters();
//         SnackBarHelper.showSuccessSnackBar(
//           newApproval
//               ? 'Admin approved successfully'
//               : 'Admin approval revoked',
//         );
//       } else {
//         SnackBarHelper.showErrorSnackBar(
//           response.body?['message'] ?? 'Failed to update approval',
//         );
//       }
//     } catch (e) {
//       log('Error toggling admin approval: $e');
//       SnackBarHelper.showErrorSnackBar('Error: $e');
//     }
//   }

//   /// Delete a user
//   Future<void> deleteUser(User user) async {
//     try {
//       final response = await service.deleteItem(
//         endpointUrl: 'super-admin/users',
//         itemId: user.sId ?? '',
//       );

//       if (response.isOk) {
//         _allUsers.removeWhere((u) => u.sId == user.sId);
//         _applyFilters();
//         SnackBarHelper.showSuccessSnackBar('User deleted successfully');
//       } else {
//         SnackBarHelper.showErrorSnackBar(
//           response.body?['message'] ?? 'Failed to delete user',
//         );
//       }
//     } catch (e) {
//       log('Error deleting user: $e');
//       SnackBarHelper.showErrorSnackBar('Error: $e');
//     }
//   }

//   // Stats helpers
//   int get totalUsers => _allUsers.length;
//   int get totalAdmins => _allUsers.where((u) => u.role == 'admin').length;
//   int get pendingAdmins => _allUsers
//       .where((u) => u.role == 'admin' && !(u.isApproved ?? false))
//       .length;
//   int get blockedUsers => _allUsers.where((u) => !(u.isActive ?? true)).length;
// }
import 'dart:developer';
import 'package:admin/models/user.dart';
import 'package:admin/services/http_services.dart';
import 'package:admin/utility/snack_bar_helper.dart';
import 'package:flutter/material.dart';

class AllUsersProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<User> _allUsers = [];
  List<User> _filteredUsers = [];
  bool isLoading = false;

  // 'All' | 'admin' | 'user' | 'guest' | 'pending'
  String _selectedFilter = 'All';
  String _searchKeyword = '';

  List<User> get users => _filteredUsers;
  String get selectedFilter => _selectedFilter;

  // All filter options shown as chips
  final List<String> roleFilters = ['All', 'admin', 'user', 'guest', 'pending'];

  // ─── Fetch ────────────────────────────────────────────────────────────────

  Future<void> getAllUsers({bool showSnack = false}) async {
    try {
      isLoading = true;
      notifyListeners();

      final response =
          await service.getItems(endpointUrl: 'super-admin/users?limit=500');

      if (response.isOk) {
        final List usersJson = response.body['data']['users'] ?? [];
        _allUsers = usersJson.map((j) => User.fromJson(j)).toList();
        _applyFilters();
        if (showSnack) SnackBarHelper.showSuccessSnackBar('Users loaded');
      } else {
        if (showSnack)
          SnackBarHelper.showErrorSnackBar(
              response.body?['message'] ?? 'Failed to load users');
      }
    } catch (e) {
      log('getAllUsers error: $e');
      if (showSnack) SnackBarHelper.showErrorSnackBar('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ─── Filters ─────────────────────────────────────────────────────────────

  void setFilter(String filter) {
    _selectedFilter = filter;
    _applyFilters();
  }

  void filterByKeyword(String keyword) {
    _searchKeyword = keyword.toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    List<User> result = List.from(_allUsers);

    switch (_selectedFilter) {
      case 'pending':
        // Admins who exist but are NOT yet approved
        result = result
            .where((u) => u.role == 'admin' && !(u.isApproved ?? false))
            .toList();
        break;
      case 'All':
        break; // no role filter
      default:
        result = result.where((u) => u.role == _selectedFilter).toList();
    }

    if (_searchKeyword.isNotEmpty) {
      result = result.where((u) {
        return (u.name ?? '').toLowerCase().contains(_searchKeyword) ||
            (u.email ?? '').toLowerCase().contains(_searchKeyword);
      }).toList();
    }

    _filteredUsers = result;
    notifyListeners();
  }

  // ─── Actions ──────────────────────────────────────────────────────────────

  /// Block / unblock — also invalidates refresh token server-side
  Future<void> toggleUserActive(User user) async {
    final newStatus = !(user.isActive ?? true);
    try {
      final response = await service.updateItem(
        endpointUrl: 'super-admin/users/${user.sId}/toggle-active',
        itemData: {'isActive': newStatus},
        itemId: '',
      );

      if (response.isOk) {
        _patchUser(user.sId, (u) => u.copyWith(isActive: newStatus));
        SnackBarHelper.showSuccessSnackBar(newStatus
            ? 'User unblocked successfully'
            : 'User blocked and logged out');
      } else {
        SnackBarHelper.showErrorSnackBar(
            response.body?['message'] ?? 'Failed to update status');
      }
    } catch (e) {
      log('toggleUserActive error: $e');
      SnackBarHelper.showErrorSnackBar('Error: $e');
    }
  }

  /// Approve / revoke admin
  Future<void> toggleAdminApproval(User user) async {
    final newApproval = !(user.isApproved ?? false);
    try {
      final response = await service.updateItem(
        endpointUrl: 'super-admin/users/${user.sId}/approve',
        itemData: {'isApproved': newApproval},
        itemId: '',
      );

      if (response.isOk) {
        _patchUser(user.sId, (u) => u.copyWith(isApproved: newApproval));
        SnackBarHelper.showSuccessSnackBar(newApproval
            ? 'Admin approved successfully'
            : 'Admin approval revoked');
      } else {
        SnackBarHelper.showErrorSnackBar(
            response.body?['message'] ?? 'Failed to update approval');
      }
    } catch (e) {
      log('toggleAdminApproval error: $e');
      SnackBarHelper.showErrorSnackBar('Error: $e');
    }
  }

  /// Force logout — clears refresh token without blocking the account
  Future<void> forceLogout(User user) async {
    try {
      final response = await service.addItem(
        endpointUrl: 'super-admin/users/${user.sId}/logout',
        itemData: {},
      );

      if (response.isOk) {
        SnackBarHelper.showSuccessSnackBar('User logged out from all devices');
      } else {
        SnackBarHelper.showErrorSnackBar(
            response.body?['message'] ?? 'Force logout failed');
      }
    } catch (e) {
      log('forceLogout error: $e');
      SnackBarHelper.showErrorSnackBar('Error: $e');
    }
  }

  /// Delete user permanently
  Future<void> deleteUser(User user) async {
    try {
      final response = await service.deleteItem(
        endpointUrl: 'super-admin/users',
        itemId: user.sId ?? '',
      );

      if (response.isOk) {
        _allUsers.removeWhere((u) => u.sId == user.sId);
        _applyFilters();
        SnackBarHelper.showSuccessSnackBar('User deleted successfully');
      } else {
        SnackBarHelper.showErrorSnackBar(
            response.body?['message'] ?? 'Failed to delete user');
      }
    } catch (e) {
      log('deleteUser error: $e');
      SnackBarHelper.showErrorSnackBar('Error: $e');
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  /// Optimistically update one user in the list without a full refetch
  void _patchUser(String? id, User Function(User) patch) {
    if (id == null) return;
    final idx = _allUsers.indexWhere((u) => u.sId == id);
    if (idx != -1) _allUsers[idx] = patch(_allUsers[idx]);
    _applyFilters();
  }

  // ─── Stats ────────────────────────────────────────────────────────────────

  int get totalUsers => _allUsers.length;
  int get totalAdmins => _allUsers.where((u) => u.role == 'admin').length;
  int get pendingAdmins => _allUsers
      .where((u) => u.role == 'admin' && !(u.isApproved ?? false))
      .length;
  int get blockedUsers => _allUsers.where((u) => !(u.isActive ?? true)).length;
}
