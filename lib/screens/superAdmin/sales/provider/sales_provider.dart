import 'dart:developer';
import 'package:admin/models/api_response.dart';
import 'package:admin/models/user.dart';
import 'package:admin/services/http_services.dart';
import 'package:admin/utility/snack_bar_helper.dart';
import 'package:flutter/material.dart';

class SalesProvider extends ChangeNotifier {
  final HttpService _httpService = HttpService();

  // Data states
  Map<String, dynamic> _dashboardStats = {};
  List<User> _recentUsers = [];
  List<SalesPerAdmin> _salesPerAdmin = [];
  Map<String, dynamic> _userStats = {};
  List<User> _allUsers = [];

  bool _isLoading = false;
  bool _isLoadingUsers = false;
  String? _errorMessage;

  // Getters
  Map<String, dynamic> get dashboardStats => _dashboardStats;
  List<User> get recentUsers => _recentUsers;
  List<SalesPerAdmin> get salesPerAdmin => _salesPerAdmin;
  Map<String, dynamic> get userStats => _userStats;
  List<User> get allUsers => _allUsers;
  bool get isLoading => _isLoading;
  bool get isLoadingUsers => _isLoadingUsers;
  String? get errorMessage => _errorMessage;

  // Load all dashboard data
  Future<void> loadDashboardData() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await Future.wait([
        loadStats(),
        loadRecentUsers(),
        loadSalesPerAdmin(),
      ]);
    } catch (e) {
      _errorMessage = 'Failed to load dashboard data: $e';
      SnackBarHelper.showErrorSnackBar(_errorMessage!);
    } finally {
      _setLoading(false);
    }
  }

  // Load system statistics
  Future<void> loadStats() async {
    try {
      final response =
          await _httpService.getItems(endpointUrl: 'super-admin/stats');
      if (response.isOk && response.body != null) {
        _dashboardStats = response.body['data'] ?? {};
        notifyListeners();
      }
    } catch (e) {
      log('Error loading stats: $e');
      rethrow;
    }
  }

  // Load recent users
  Future<void> loadRecentUsers({int limit = 5}) async {
    try {
      final response = await _httpService.getItems(
          endpointUrl: 'super-admin/users/recent/$limit');
      if (response.isOk && response.body != null) {
        final List<dynamic> usersData = response.body['data'];
        _recentUsers = usersData.map((json) => User.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      log('Error loading recent users: $e');
      rethrow;
    }
  }

  // Load sales per admin
  Future<void> loadSalesPerAdmin() async {
    try {
      final response = await _httpService.getItems(
          endpointUrl: 'super-admin/sales-per-admin');
      if (response.isOk && response.body != null) {
        final data = response.body['data'];
        _salesPerAdmin = (data['salesPerAdmin'] as List)
            .map((json) => SalesPerAdmin.fromJson(json))
            .toList();
        notifyListeners();
      }
    } catch (e) {
      log('Error loading sales per admin: $e');
      rethrow;
    }
  }

  // Load all users with pagination and filters
  Future<void> loadAllUsers({
    String? role,
    int page = 1,
    int limit = 10,
    bool refresh = false,
  }) async {
    if (!refresh && _isLoadingUsers) return;

    _isLoadingUsers = true;
    notifyListeners();

    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };
      if (role != null && role.isNotEmpty) queryParams['role'] = role;

      final response = await _httpService.getItems(
        endpointUrl: 'super-admin/users',
        // queryParams: queryParams
      );

      if (response.isOk && response.body != null) {
        final data = response.body['data'];
        if (refresh) {
          _allUsers = (data['users'] as List)
              .map((json) => User.fromJson(json))
              .toList();
        } else {
          _allUsers.addAll(
              (data['users'] as List).map((json) => User.fromJson(json)));
        }
        notifyListeners();
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('Failed to load users: $e');
    } finally {
      _isLoadingUsers = false;
      notifyListeners();
    }
  }

  // Update user role
  Future<bool> updateUserRole(String userId, String newRole) async {
    try {
      final response = await _httpService.updateItem(
        endpointUrl: 'super-admin/users/$userId/role',
        itemData: {'role': newRole},
        itemId: userId,
      );

      if (response.isOk) {
        final apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('User role updated successfully');
          await loadDashboardData(); // Refresh data
          return true;
        }
      }
      SnackBarHelper.showErrorSnackBar('Failed to update user role');
      return false;
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('Error: $e');
      return false;
    }
  }

  // Delete user
  Future<bool> deleteUser(String userId) async {
    try {
      final response = await _httpService.deleteItem(
        endpointUrl: 'super-admin/users/$userId',
        itemId: userId,
      );

      if (response.isOk) {
        final apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('User deleted successfully');
          await loadDashboardData();
          return true;
        }
      }
      SnackBarHelper.showErrorSnackBar('Failed to delete user');
      return false;
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('Error: $e');
      return false;
    }
  }

  // Force logout user
  Future<bool> forceLogoutUser(String userId) async {
    try {
      final response = await _httpService.addItem(
        endpointUrl: 'super-admin/users/$userId/logout',
        itemData: {},
      );

      if (response.isOk) {
        final apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('User logged out successfully');
          return true;
        }
      }
      SnackBarHelper.showErrorSnackBar('Failed to logout user');
      return false;
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('Error: $e');
      return false;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void refreshData() {
    loadDashboardData();
  }
}

// Model for Sales Per Admin
class SalesPerAdmin {
  final String adminId;
  final String adminName;
  final String adminEmail;
  final double totalSales;
  final int orderCount;

  SalesPerAdmin({
    required this.adminId,
    required this.adminName,
    required this.adminEmail,
    required this.totalSales,
    required this.orderCount,
  });

  factory SalesPerAdmin.fromJson(Map<String, dynamic> json) {
    return SalesPerAdmin(
      adminId: json['adminId'] ?? '',
      adminName: json['adminName'] ?? '',
      adminEmail: json['adminEmail'] ?? '',
      totalSales: (json['totalSales'] ?? 0).toDouble(),
      orderCount: json['orderCount'] ?? 0,
    );
  }
}
