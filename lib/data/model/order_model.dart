import 'package:car_hub/data/model/car_model.dart';

class OrderModel {
  final String? sId;
  final String carId;
  final Map<String, dynamic>? carData;
  final String userId;
  final String deliveryOption;
  final double totalAmount;
  final String paymentMethod;
  final String paymentStatus;
  final String fullName;
  final String email;
  final String phone;
  final String location;
  final DateTime? createdAt;
  final String? paymentTransactionId;
  final DateTime? paymentDate;
  final bool? ipnValidated;

  OrderModel({
    this.sId,
    required this.carId,
    this.carData,
    required this.userId,
    required this.deliveryOption,
    required this.totalAmount,
    required this.paymentMethod,
    this.paymentStatus = 'Pending',
    required this.fullName,
    required this.email,
    required this.phone,
    required this.location,
    this.createdAt,
    this.paymentTransactionId,
    this.paymentDate,
    this.ipnValidated,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    String carId = '';
    Map<String, dynamic>? carData;

    if (json['carId'] is String) {
      carId = json['carId'];
    } else if (json['carId'] is Map<String, dynamic>) {
      carData = json['carId'] as Map<String, dynamic>;
      carId = carData['_id']?.toString() ?? '';
    } else if (json['carId'] != null) {
      carId = json['carId'].toString();
    }

    String userId = '';
    if (json['userId'] is String) {
      userId = json['userId'];
    } else if (json['userId'] != null) {
      userId = json['userId'].toString();
    }

    return OrderModel(
      sId: json['_id']?.toString(),
      carId: carId,
      carData: carData,
      userId: userId,
      deliveryOption: json['deliveryOption']?.toString() ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      paymentStatus: json['paymentStatus']?.toString() ?? 'Pending',
      fullName: json['fullName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : null,
      paymentTransactionId: json['paymentTransactionId']?.toString(),
      paymentDate: json['paymentDate'] != null
          ? DateTime.parse(json['paymentDate'].toString())
          : null,
      ipnValidated: json['ipnValidated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'userId': userId,
      'deliveryOption': deliveryOption,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'location': location,
      'paymentTransactionId': paymentTransactionId,
      'paymentDate': paymentDate?.toIso8601String(),
      'ipnValidated': ipnValidated,
    };
  }

  String get carTitle {
    if (carData != null && carData!['title'] != null) {
      return carData!['title'];
    }
    if (carData != null &&
        carData!['brand'] != null &&
        carData!['model'] != null) {
      return '${carData!['brand']} ${carData!['model']}';
    }
    return 'Car Order';
  }

  String? get carImage {
    if (carData != null && carData!['media'] != null) {
      if (carData!['media'] is Map) {
        final media = carData!['media'] as Map<String, dynamic>;
        if (media['thumbnail'] != null) {
          return media['thumbnail'].toString();
        } else if (media['gallery'] is List &&
            (media['gallery'] as List).isNotEmpty) {
          return media['gallery'][0].toString();
        }
      }
    }
    return null;
  }

  String get carModelYear {
    if (carData != null) {
      final brand = carData!['brand']?.toString() ?? '';
      final model = carData!['model']?.toString() ?? '';
      final year = carData!['year']?.toString() ?? '';

      List<String> parts = [];
      if (brand.isNotEmpty) parts.add(brand);
      if (model.isNotEmpty) parts.add(model);
      if (year.isNotEmpty) parts.add(year);

      if (parts.isNotEmpty) {
        return parts.join(' • ');
      }
    }
    return '';
  }

  String? get carPrice {
    if (carData != null && carData!['pricing'] != null) {
      if (carData!['pricing'] is Map) {
        final pricing = carData!['pricing'] as Map<String, dynamic>;
        final sellingPrice = pricing['sellingPrice']?.toString();
        final currency = pricing['currency']?.toString() ?? '';
        if (sellingPrice != null) {
          return '\$$sellingPrice $currency';
        }
      }
    }
    return null;
  }

  String get carLocation {
    if (carData != null && carData!['location'] != null) {
      if (carData!['location'] is Map) {
        final location = carData!['location'] as Map<String, dynamic>;
        final city = location['city']?.toString() ?? '';
        final country = location['country']?.toString() ?? '';
        if (city.isNotEmpty && country.isNotEmpty) {
          return '$city, $country';
        } else if (city.isNotEmpty) {
          return city;
        } else if (country.isNotEmpty) {
          return country;
        }
      }
    }
    return '';
  }

  String get formattedDate {
    if (createdAt != null) {
      return '${createdAt!.day}/${createdAt!.month}/${createdAt!.year}';
    }
    return '';
  }

  bool get isPaid => paymentStatus == 'Paid';
  bool get isPending => paymentStatus == 'Pending';
  bool get isFailed => paymentStatus == 'Failed';

  String get formattedPaymentDate {
    if (paymentDate != null) {
      return '${paymentDate!.day}/${paymentDate!.month}/${paymentDate!.year}';
    }
    return '';
  }
}