class User {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? role;
  bool? isVerified;
  DateTime? guestExpiresAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User({
    this.sId,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.guestExpiresAt,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  bool get isGuest => role == 'guest';

  bool get isAdmin => role == 'admin';

  bool get isRegularUser => role == 'user';

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    isVerified = json['isVerified'];
    guestExpiresAt = json['guestExpiresAt'] != null
        ? DateTime.tryParse(json['guestExpiresAt'])
        : null;
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
      'role': role,
      'isVerified': isVerified,
      'guestExpiresAt': guestExpiresAt?.toIso8601String(),
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
    String? role,
    bool? isVerified,
    DateTime? guestExpiresAt,
    String? createdAt,
    String? updatedAt,
    int? iV,
  }) {
    return User(
      sId: sId ?? this.sId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      guestExpiresAt: guestExpiresAt ?? this.guestExpiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      iV: iV ?? this.iV,
    );
  }

  @override
  String toString() {
    return 'User(id: $sId, name: $name, email: $email, role: $role, isVerified: $isVerified)';
  }
}
