import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/PhysicalGoods.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/SSLCProductInitializer.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

enum PaymentStatus { pending, processing, success, failed }

class PaymentProvider extends ChangeNotifier {
  PaymentStatus _status = PaymentStatus.pending;
  bool _isLoading = false;
  String? _errorMessage;
  String? _transactionId;

  PaymentStatus get status => _status;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get transactionId => _transactionId;

  Future<void> processPayment({
    required String orderId,
    required double totalAmount,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required String customerAddress,
    required String carTitle,
    required String deliveryOption,
  }) async {
    _isLoading = true;
    _status = PaymentStatus.processing;
    _errorMessage = null;
    notifyListeners();

    try {
      final sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
          store_id: "carla69540721933be",
          store_passwd: "carla69540721933be@ssl",
          total_amount: totalAmount,
          tran_id: "${orderId}_${DateTime.now().millisecondsSinceEpoch}",
          currency: SSLCurrencyType.BDT,
          product_category: "Automotive",
          sdkType: SSLCSdkType.TESTBOX,
        ),
      );

      sslcommerz.addCustomerInfoInitializer(
        customerInfoInitializer: SSLCCustomerInfoInitializer(
          customerState: customerAddress.split(',').length > 1
              ? customerAddress.split(',')[1].trim()
              : "",
          customerName: customerName,
          customerEmail: customerEmail,
          customerPhone: customerPhone,
          customerAddress1: customerAddress,
          customerCity: customerAddress.split(',').first,
          customerCountry: "Bangladesh",
          customerPostCode: "1000",
        ),
      );

      sslcommerz.addProductInitializer(
        sslcProductInitializer: SSLCProductInitializer.WithPhysicalGoodsProfile(
          productName: carTitle,
          productCategory: "Car",
          physicalGoods: PhysicalGoods(
            productProfile: "physical-goods",
            physicalGoods: "Car Purchase",
          ),
        ),
      );

      final response = await sslcommerz.payNow();

      if (response.status == 'SUCCESS') {
        _status = PaymentStatus.success;
        _transactionId = response.tranId;
      } else {
        _status = PaymentStatus.failed;
        _errorMessage = response.status ?? "Payment failed";
      }
    } catch (e) {
      _status = PaymentStatus.failed;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _status = PaymentStatus.pending;
    _isLoading = false;
    _errorMessage = null;
    _transactionId = null;
    notifyListeners();
  }
}
