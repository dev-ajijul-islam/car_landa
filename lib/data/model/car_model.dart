class CarModel {
  final String sId;
  final String title;
  final String brand;
  final String model;
  final int year;
  final Pricing pricing;
  final Location location;
  final Media media;
  final Flags flags;
  final Specs specs;
  final Costs costs;
  final String carTypeId;
  final String description;
  bool ? isFavorite;
  final InquiryContacts inquiryContacts;

  CarModel({
    required this.sId,
    required this.title,
    required this.brand,
    required this.model,
    required this.year,
    required this.pricing,
    required this.location,
    required this.media,
    required this.flags,
    required this.specs,
    required this.costs,
    required this.carTypeId,
    required this.description,
    required this.inquiryContacts,
    this.isFavorite
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      sId: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
      model: json['model']?.toString() ?? '',
      year: _parseInt(json['year']),
      pricing: Pricing.fromJson(json['pricing'] ?? {}),
      location: Location.fromJson(json['location'] ?? {}),
      media: Media.fromJson(json['media'] ?? {}),
      flags: Flags.fromJson(json['flags'] ?? {}),
      specs: Specs.fromJson(json['specs'] ?? {}),
      costs: Costs.fromJson(json['costs'] ?? {}),
      carTypeId: json['carTypeId']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isFavorite: json['isFavorite'] ?? '',
      inquiryContacts: InquiryContacts.fromJson(json['inquiryContacts'] ?? {}),
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) return parsed;
      final doubleParsed = double.tryParse(value);
      if (doubleParsed != null) return doubleParsed.toInt();
      return 0;
    }
    return 0;
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'title': title,
      'brand': brand,
      'model': model,
      'year': year,
      'pricing': pricing.toJson(),
      'location': location.toJson(),
      'media': media.toJson(),
      'flags': flags.toJson(),
      'specs': specs.toJson(),
      'costs': costs.toJson(),
      'carTypeId': carTypeId,
      'description': description,
      'inquiryContacts': inquiryContacts.toJson(),
    };
  }
}

class Pricing {
  final double originalPrice;
  final double sellingPrice;
  final String currency;
  final Discount? discount;
  final String sId;

  Pricing({
    required this.originalPrice,
    required this.sellingPrice,
    required this.currency,
    this.discount,
    required this.sId,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      originalPrice: CarModel._parseDouble(json['originalPrice']),
      sellingPrice: CarModel._parseDouble(json['sellingPrice']),
      currency: json['currency']?.toString() ?? 'USD',
      discount: json['discount'] != null
          ? Discount.fromJson(json['discount'])
          : null,
      sId: json['_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'originalPrice': originalPrice,
      'sellingPrice': sellingPrice,
      'currency': currency,
      'discount': discount?.toJson(),
      '_id': sId,
    };
  }
}

class Discount {
  final String type;
  final double value;
  final String sId;

  Discount({
    required this.type,
    required this.value,
    required this.sId,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      type: json['type']?.toString() ?? '',
      value: CarModel._parseDouble(json['value']),
      sId: json['_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
      '_id': sId,
    };
  }
}

class Location {
  final String country;
  final String city;
  final String area;
  final String sId;

  Location({
    required this.country,
    required this.city,
    required this.area,
    required this.sId,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      country: json['country']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      area: json['area']?.toString() ?? '',
      sId: json['_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'city': city,
      'area': area,
      '_id': sId,
    };
  }
}

class Media {
  final String thumbnail;
  final List<String> gallery;
  final String sId;

  Media({
    required this.thumbnail,
    required this.gallery,
    required this.sId,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      thumbnail: json['thumbnail']?.toString() ?? '',
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((item) => item?.toString() ?? '')
          .where((item) => item.isNotEmpty)
          .toList() ?? [],
      sId: json['_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'thumbnail': thumbnail,
      'gallery': gallery,
      '_id': sId,
    };
  }
}

class Flags {
  final bool isFeatured;
  final bool isHotDeal;
  final bool isActive;
  final String sId;

  Flags({
    required this.isFeatured,
    required this.isHotDeal,
    required this.isActive,
    required this.sId,
  });

  factory Flags.fromJson(Map<String, dynamic> json) {
    return Flags(
      isFeatured: json['isFeatured'] as bool? ?? false,
      isHotDeal: json['isHotDeal'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      sId: json['_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isFeatured': isFeatured,
      'isHotDeal': isHotDeal,
      'isActive': isActive,
      '_id': sId,
    };
  }
}

class Specs {
  final double mileageKm;
  final double enginePowerHp;
  final String fuelType;
  final int cylinders;
  final String transmission;
  final int seats;
  final String interiorColor;
  final String exteriorColor;
  final String sId;

  Specs({
    required this.mileageKm,
    required this.enginePowerHp,
    required this.fuelType,
    required this.cylinders,
    required this.transmission,
    required this.seats,
    required this.interiorColor,
    required this.exteriorColor,
    required this.sId,
  });

  factory Specs.fromJson(Map<String, dynamic> json) {
    return Specs(
      mileageKm: CarModel._parseDouble(json['mileageKm']),
      enginePowerHp: CarModel._parseDouble(json['enginePowerHp']),
      fuelType: json['fuelType']?.toString() ?? '',
      cylinders: CarModel._parseInt(json['cylinders']),
      transmission: json['transmission']?.toString() ?? '',
      seats: CarModel._parseInt(json['seats']),
      interiorColor: json['interiorColor']?.toString() ?? '',
      exteriorColor: json['exteriorColor']?.toString() ?? '',
      sId: json['_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mileageKm': mileageKm,
      'enginePowerHp': enginePowerHp,
      'fuelType': fuelType,
      'cylinders': cylinders,
      'transmission': transmission,
      'seats': seats,
      'interiorColor': interiorColor,
      'exteriorColor': exteriorColor,
      '_id': sId,
    };
  }
}

class Costs {
  final double shipping;
  final double customClearance;
  final String sId;

  Costs({
    required this.shipping,
    required this.customClearance,
    required this.sId,
  });

  factory Costs.fromJson(Map<String, dynamic> json) {
    return Costs(
      shipping: CarModel._parseDouble(json['shipping']),
      customClearance: CarModel._parseDouble(json['customClearance']),
      sId: json['_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipping': shipping,
      'customClearance': customClearance,
      '_id': sId,
    };
  }
}

class InquiryContacts {
  final bool call;
  final bool message;
  final bool whatsapp;
  final String sId;

  InquiryContacts({
    required this.call,
    required this.message,
    required this.whatsapp,
    required this.sId,
  });

  factory InquiryContacts.fromJson(Map<String, dynamic> json) {
    return InquiryContacts(
      call: json['call'] as bool? ?? false,
      message: json['message'] as bool? ?? false,
      whatsapp: json['whatsapp'] as bool? ?? false,
      sId: json['_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'call': call,
      'message': message,
      'whatsapp': whatsapp,
      '_id': sId,
    };
  }
}