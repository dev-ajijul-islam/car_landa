class CarModel {
  String? sId;
  String? title;
  String? brand;
  String? model;
  int? year;
  Pricing? pricing;
  Location? location;
  Media? media;
  Flags? flags;
  Specs? specs;
  Costs? costs;
  String? carTypeId;
  String? description;
  InquiryContacts? inquiryContacts;

  CarModel({
    sId,
    title,
    brand,
    model,
    year,
    pricing,
    location,
    media,
    flags,
    specs,
    costs,
    carTypeId,
    description,
    inquiryContacts,
  });

  CarModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    brand = json['brand'];
    model = json['model'];
    year = json['year'];
    pricing = json['pricing'] != null
        ? Pricing.fromJson(json['pricing'])
        : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    media = json['media'] != null ? Media.fromJson(json['media']) : null;
    flags = json['flags'] != null ? Flags.fromJson(json['flags']) : null;
    specs = json['specs'] != null ? Specs.fromJson(json['specs']) : null;
    costs = json['costs'] != null ? Costs.fromJson(json['costs']) : null;
    carTypeId = json['carTypeId'];
    description = json['description'];
    inquiryContacts = json['inquiryContacts'] != null
        ? InquiryContacts.fromJson(json['inquiryContacts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['brand'] = brand;
    data['model'] = model;
    data['year'] = year;
    if (pricing != null) {
      data['pricing'] = pricing!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (media != null) {
      data['media'] = media!.toJson();
    }
    if (flags != null) {
      data['flags'] = flags!.toJson();
    }
    if (specs != null) {
      data['specs'] = specs!.toJson();
    }
    if (costs != null) {
      data['costs'] = costs!.toJson();
    }
    data['carTypeId'] = carTypeId;
    data['description'] = description;
    if (inquiryContacts != null) {
      data['inquiryContacts'] = inquiryContacts!.toJson();
    }
    return data;
  }
}

class Pricing {
  int? originalPrice;
  int? sellingPrice;
  String? currency;
  Discount? discount;
  String? sId;

  Pricing({originalPrice, sellingPrice, currency, discount, sId});

  Pricing.fromJson(Map<String, dynamic> json) {
    originalPrice = json['originalPrice'];
    sellingPrice = json['sellingPrice'];
    currency = json['currency'];
    discount = json['discount'] != null
        ? Discount.fromJson(json['discount'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['originalPrice'] = originalPrice;
    data['sellingPrice'] = sellingPrice;
    data['currency'] = currency;
    if (discount != null) {
      data['discount'] = discount!.toJson();
    }
    data['_id'] = sId;
    return data;
  }
}

class Discount {
  String? type;
  int? value;
  String? sId;

  Discount({type, value, sId});

  Discount.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['_id'] = sId;
    return data;
  }
}

class Location {
  String? country;
  String? city;
  String? area;
  String? sId;

  Location({country, city, area, sId});

  Location.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    area = json['area'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['city'] = city;
    data['area'] = area;
    data['_id'] = sId;
    return data;
  }
}

class Media {
  String? thumbnail;
  List<String>? gallery;
  String? sId;

  Media({thumbnail, gallery, sId});

  Media.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    gallery = json['gallery'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumbnail'] = thumbnail;
    data['gallery'] = gallery;
    data['_id'] = sId;
    return data;
  }
}

class Flags {
  bool? isFeatured;
  bool? isHotDeal;
  bool? isActive;
  String? sId;

  Flags({isFeatured, isHotDeal, isActive, sId});

  Flags.fromJson(Map<String, dynamic> json) {
    isFeatured = json['isFeatured'];
    isHotDeal = json['isHotDeal'];
    isActive = json['isActive'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFeatured'] = isFeatured;
    data['isHotDeal'] = isHotDeal;
    data['isActive'] = isActive;
    data['_id'] = sId;
    return data;
  }
}

class Specs {
  int? mileageKm;
  int? enginePowerHp;
  String? fuelType;
  int? cylinders;
  String? transmission;
  int? seats;
  String? interiorColor;
  String? exteriorColor;
  String? sId;

  Specs({
    mileageKm,
    enginePowerHp,
    fuelType,
    cylinders,
    transmission,
    seats,
    interiorColor,
    exteriorColor,
    sId,
  });

  Specs.fromJson(Map<String, dynamic> json) {
    mileageKm = json['mileageKm'];
    enginePowerHp = json['enginePowerHp'];
    fuelType = json['fuelType'];
    cylinders = json['cylinders'];
    transmission = json['transmission'];
    seats = json['seats'];
    interiorColor = json['interiorColor'];
    exteriorColor = json['exteriorColor'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mileageKm'] = mileageKm;
    data['enginePowerHp'] = enginePowerHp;
    data['fuelType'] = fuelType;
    data['cylinders'] = cylinders;
    data['transmission'] = transmission;
    data['seats'] = seats;
    data['interiorColor'] = interiorColor;
    data['exteriorColor'] = exteriorColor;
    data['_id'] = sId;
    return data;
  }
}

class Costs {
  int? shipping;
  int? customClearance;
  String? sId;

  Costs({shipping, customClearance, sId});

  Costs.fromJson(Map<String, dynamic> json) {
    shipping = json['shipping'];
    customClearance = json['customClearance'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shipping'] = shipping;
    data['customClearance'] = customClearance;
    data['_id'] = sId;
    return data;
  }
}

class InquiryContacts {
  bool? call;
  bool? message;
  bool? whatsapp;
  String? sId;

  InquiryContacts({call, message, whatsapp, sId});

  InquiryContacts.fromJson(Map<String, dynamic> json) {
    call = json['call'];
    message = json['message'];
    whatsapp = json['whatsapp'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['call'] = call;
    data['message'] = message;
    data['whatsapp'] = whatsapp;
    data['_id'] = sId;
    return data;
  }
}
