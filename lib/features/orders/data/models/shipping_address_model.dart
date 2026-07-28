class ShippingAddressModel {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String zipcode;
  final String phone;
  final bool isDefault;

  ShippingAddressModel({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.phone,
    this.isDefault = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'city': city,
      'status': state,
      'zipcode': zipcode,
      'phone': phone,
      'isDefault': isDefault,
    };
  }

  factory ShippingAddressModel.fromJson(Map<String, dynamic> jsonData) {
    return ShippingAddressModel(
      id: jsonData['id'],
      name: jsonData['name'],
      address: jsonData['address'],
      city: jsonData['city'],
      state: jsonData['status'],
      zipcode: jsonData['zipcode'],
      phone: jsonData['phone'],
      isDefault: jsonData['isDefault'] ?? false,
    );
  }

  ShippingAddressModel copyWith({
    String? id,
    String? name,
    String? address,
    String? city,
    String? status,
    String? zipcode,
    String? phone,
    bool? isDefault,
  }) {
    return ShippingAddressModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      state: status ?? state,
      zipcode: zipcode ?? this.zipcode,
      phone: phone ?? this.phone,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
