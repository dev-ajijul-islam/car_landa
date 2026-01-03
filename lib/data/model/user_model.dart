class UserModel {
  final String? id;


  final String name;
  final String email;


  final String? phone;
  final String? address;
  final String? passportIdUrl;
  final String? photo;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.passportIdUrl,
    this.photo,
  });

  // ---------- From JSON ----------
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      address: json['address'],
      passportIdUrl: json['passportIdUrl'],
    );
  }

  // ---------- To JSON ----------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (passportIdUrl != null) 'passportIdUrl': passportIdUrl,
    };
  }


  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? passportIdUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      passportIdUrl: passportIdUrl ?? this.passportIdUrl,
    );
  }
}
