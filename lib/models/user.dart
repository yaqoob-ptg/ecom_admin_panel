// class User {
//   String? sId;
//   String? name;
//   String? email;
//   String? phone;
//   String? role;
//   bool? isVerified;
//   DateTime? guestExpiresAt;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   User({
//     this.sId,
//     this.name,
//     this.email,
//     this.phone,
//     this.role,
//     this.isVerified,
//     this.guestExpiresAt,
//     this.createdAt,
//     this.updatedAt,
//     this.iV,
//   });

//   bool get isGuest => role == 'guest';

//   bool get isAdmin => role == 'admin';

//   bool get isSuperAdmin => role == "superAdmin";

//   bool get isRegularUser => role == 'user';

//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     role = json['role'];
//     isVerified = json['isVerified'];
//     guestExpiresAt = json['guestExpiresAt'] != null
//         ? DateTime.tryParse(json['guestExpiresAt'])
//         : null;
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': sId,
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'role': role,
//       'isVerified': isVerified,
//       'guestExpiresAt': guestExpiresAt?.toIso8601String(),
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       '__v': iV,
//     };
//   }

//   User copyWith({
//     String? sId,
//     String? name,
//     String? email,
//     String? phone,
//     String? role,
//     bool? isVerified,
//     DateTime? guestExpiresAt,
//     String? createdAt,
//     String? updatedAt,
//     int? iV,
//   }) {
//     return User(
//       sId: sId ?? this.sId,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       phone: phone ?? this.phone,
//       role: role ?? this.role,
//       isVerified: isVerified ?? this.isVerified,
//       guestExpiresAt: guestExpiresAt ?? this.guestExpiresAt,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       iV: iV ?? this.iV,
//     );
//   }

//   @override
//   String toString() {
//     return 'User(id: $sId, name: $name, email: $email, role: $role, isVerified: $isVerified)';
//   }
// }

class User {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? location;
  String? role;
  bool? isVerified;
  bool? isActive;
  String? verificationToken;
  DateTime? verificationTokenExpires;
  DateTime? guestExpiresAt;
  String? refreshToken;

  // Password reset fields
  String? resetPasswordToken;
  DateTime? resetPasswordExpires;
  PasswordResetRequests? passwordResetRequests;

  // Security settings
  SecuritySettings? securitySettings;

  // Login tracking
  int? failedLoginAttempts;
  DateTime? lockUntil;
  List<LoginHistory>? loginHistory;
  DateTime? lastLoginAt;
  String? lastLoginIp;

  // Account deactivation
  DateTime? deactivatedAt;
  String? deactivationReason;
//for admins approved
  bool? isApproved;

  // Timestamps
  String? createdAt;
  String? updatedAt;
  int? iV;

  User({
    this.sId,
    this.name,
    this.email,
    this.phone,
    this.location,
    this.role,
    this.isVerified,
    this.isActive,
    this.verificationToken,
    this.verificationTokenExpires,
    this.guestExpiresAt,
    this.refreshToken,
    this.resetPasswordToken,
    this.resetPasswordExpires,
    this.passwordResetRequests,
    this.securitySettings,
    this.failedLoginAttempts,
    this.lockUntil,
    this.loginHistory,
    this.lastLoginAt,
    this.lastLoginIp,
    this.deactivatedAt,
    this.deactivationReason,
    this.isApproved,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  // Helper getters
  bool get isGuest => role == 'guest';
  bool get isAdmin => role == 'admin';
  bool get isSuperAdmin => role == "superAdmin";
  bool get isRegularUser => role == 'user';
  bool get isAccountLocked {
    if (lockUntil == null) return false;
    return lockUntil!.isAfter(DateTime.now());
  }

  String get lockUntilRemaining {
    if (!isAccountLocked) return '';
    final duration = lockUntil!.difference(DateTime.now());
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes min ${seconds}s';
  }

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    role = json['role'];
    isVerified = json['isVerified'];
    isActive = json['isActive'] ?? true; // Default to true if not present
    verificationToken = json['verificationToken'];
    verificationTokenExpires = json['verificationTokenExpires'] != null
        ? DateTime.tryParse(json['verificationTokenExpires'])
        : null;
    guestExpiresAt = json['guestExpiresAt'] != null
        ? DateTime.tryParse(json['guestExpiresAt'])
        : null;
    refreshToken = json['refreshToken'];
    resetPasswordToken = json['resetPasswordToken'];
    resetPasswordExpires = json['resetPasswordExpires'] != null
        ? DateTime.tryParse(json['resetPasswordExpires'])
        : null;
    passwordResetRequests = json['passwordResetRequests'] != null
        ? PasswordResetRequests.fromJson(json['passwordResetRequests'])
        : null;
    securitySettings = json['securitySettings'] != null
        ? SecuritySettings.fromJson(json['securitySettings'])
        : null;
    failedLoginAttempts = json['failedLoginAttempts'] ?? 0;
    lockUntil =
        json['lockUntil'] != null ? DateTime.tryParse(json['lockUntil']) : null;
    loginHistory = json['loginHistory'] != null
        ? (json['loginHistory'] as List)
            .map((item) => LoginHistory.fromJson(item))
            .toList()
        : [];
    lastLoginAt = json['lastLoginAt'] != null
        ? DateTime.tryParse(json['lastLoginAt'])
        : null;
    lastLoginIp = json['lastLoginIp'];
    deactivatedAt = json['deactivatedAt'] != null
        ? DateTime.tryParse(json['deactivatedAt'])
        : null;
    deactivationReason = json['deactivationReason'];
    isApproved = json['isApproved'] ?? false;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
      'role': role,
      'isVerified': isVerified,
      'isActive': isActive,
      'verificationToken': verificationToken,
      'verificationTokenExpires': verificationTokenExpires?.toIso8601String(),
      'guestExpiresAt': guestExpiresAt?.toIso8601String(),
      'refreshToken': refreshToken,
      'resetPasswordToken': resetPasswordToken,
      'resetPasswordExpires': resetPasswordExpires?.toIso8601String(),
      'passwordResetRequests': passwordResetRequests?.toJson(),
      'securitySettings': securitySettings?.toJson(),
      'failedLoginAttempts': failedLoginAttempts,
      'lockUntil': lockUntil?.toIso8601String(),
      'loginHistory': loginHistory?.map((e) => e.toJson()).toList(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'lastLoginIp': lastLoginIp,
      'deactivatedAt': deactivatedAt?.toIso8601String(),
      'deactivationReason': deactivationReason,
      'isApproved': isApproved,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }

  User copyWith({
    String? sId,
    String? name,
    String? email,
    String? phone,
    String? location,
    String? role,
    bool? isVerified,
    bool? isActive,
    String? verificationToken,
    DateTime? verificationTokenExpires,
    DateTime? guestExpiresAt,
    String? refreshToken,
    String? resetPasswordToken,
    DateTime? resetPasswordExpires,
    PasswordResetRequests? passwordResetRequests,
    SecuritySettings? securitySettings,
    int? failedLoginAttempts,
    DateTime? lockUntil,
    List<LoginHistory>? loginHistory,
    DateTime? lastLoginAt,
    String? lastLoginIp,
    DateTime? deactivatedAt,
    String? deactivationReason,
    bool? isApproved,
    String? createdAt,
    String? updatedAt,
    int? iV,
  }) {
    return User(
      sId: sId ?? this.sId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      verificationToken: verificationToken ?? this.verificationToken,
      verificationTokenExpires:
          verificationTokenExpires ?? this.verificationTokenExpires,
      guestExpiresAt: guestExpiresAt ?? this.guestExpiresAt,
      refreshToken: refreshToken ?? this.refreshToken,
      resetPasswordToken: resetPasswordToken ?? this.resetPasswordToken,
      resetPasswordExpires: resetPasswordExpires ?? this.resetPasswordExpires,
      passwordResetRequests:
          passwordResetRequests ?? this.passwordResetRequests,
      securitySettings: securitySettings ?? this.securitySettings,
      failedLoginAttempts: failedLoginAttempts ?? this.failedLoginAttempts,
      lockUntil: lockUntil ?? this.lockUntil,
      loginHistory: loginHistory ?? this.loginHistory,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      lastLoginIp: lastLoginIp ?? this.lastLoginIp,
      deactivatedAt: deactivatedAt ?? this.deactivatedAt,
      deactivationReason: deactivationReason ?? this.deactivationReason,
      isApproved: isApproved ?? this.isApproved,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      iV: iV ?? this.iV,
    );
  }

  @override
  String toString() {
    return 'User(id: $sId, name: $name, email: $email, role: $role, isVerified: $isVerified, isActive: $isActive, isLocked: $isAccountLocked)';
  }
}

// Password Reset Requests Sub-document
class PasswordResetRequests {
  int? count;
  DateTime? firstRequestDate;
  DateTime? lastResetDate;

  PasswordResetRequests({
    this.count,
    this.firstRequestDate,
    this.lastResetDate,
  });

  factory PasswordResetRequests.fromJson(Map<String, dynamic> json) {
    return PasswordResetRequests(
      count: json['count'],
      firstRequestDate: json['firstRequestDate'] != null
          ? DateTime.tryParse(json['firstRequestDate'])
          : null,
      lastResetDate: json['lastResetDate'] != null
          ? DateTime.tryParse(json['lastResetDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'firstRequestDate': firstRequestDate?.toIso8601String(),
      'lastResetDate': lastResetDate?.toIso8601String(),
    };
  }
}

// Security Settings Sub-document
class SecuritySettings {
  bool? twoFactorEnabled;
  String? twoFactorSecret;
  bool? loginAlerts;
  int? sessionTimeout;

  SecuritySettings({
    this.twoFactorEnabled,
    this.twoFactorSecret,
    this.loginAlerts,
    this.sessionTimeout,
  });

  factory SecuritySettings.fromJson(Map<String, dynamic> json) {
    return SecuritySettings(
      twoFactorEnabled: json['twoFactorEnabled'] ?? false,
      twoFactorSecret: json['twoFactorSecret'],
      loginAlerts: json['loginAlerts'] ?? true,
      sessionTimeout: json['sessionTimeout'] ?? 15,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'twoFactorEnabled': twoFactorEnabled,
      'twoFactorSecret': twoFactorSecret,
      'loginAlerts': loginAlerts,
      'sessionTimeout': sessionTimeout,
    };
  }
}

// Login History Sub-document
class LoginHistory {
  DateTime? timestamp;
  String? ip;
  String? userAgent;
  bool? success;

  LoginHistory({
    this.timestamp,
    this.ip,
    this.userAgent,
    this.success,
  });

  factory LoginHistory.fromJson(Map<String, dynamic> json) {
    return LoginHistory(
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : null,
      ip: json['ip'],
      userAgent: json['userAgent'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp?.toIso8601String(),
      'ip': ip,
      'userAgent': userAgent,
      'success': success,
    };
  }
}
