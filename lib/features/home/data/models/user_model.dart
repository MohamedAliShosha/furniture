class UserModel {
  static final DateTime defaultMemberSince = DateTime(2024, 1, 10);

  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? profileImage;
  final DateTime? memberSince;
  final bool isActive;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profileImage,
    DateTime? memberSince,
    this.isActive = true,
  }) : memberSince = memberSince ?? defaultMemberSince;

  /// The copyWith method creates a new copy (new instance) of the UserModel object with the ability to selectively update specific fields while keeping others unchanged.
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImage,
    DateTime? memberSince,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      memberSince: memberSince ?? this.memberSince ?? defaultMemberSince,
      isActive: isActive ?? this.isActive,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profileImage: json['profileImage'] as String?,
      memberSince: json['memberSince'] != null
          ? DateTime.parse(json['memberSince'] as String)
          : defaultMemberSince,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'memberSince': memberSince?.toIso8601String() ??
          defaultMemberSince.toIso8601String(),
      'isActive': isActive,
    };
  }
}
