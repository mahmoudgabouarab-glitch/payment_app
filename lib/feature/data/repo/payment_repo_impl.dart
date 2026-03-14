import 'package:dartz/dartz.dart';
import 'package:payment_app/core/network/api_service.dart';
import 'package:payment_app/feature/data/model/payment_model.dart';
import 'package:payment_app/feature/data/repo/payment_repo.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentRepoImpl extends PaymentRepo {
  final ApiServise _api;

  PaymentRepoImpl(this._api);
  @override
  Future<Either<String, PaymentModel>> postPaymentMethods({
    required int amount,
    required String currency,
  }) async {
    try {
      var response = await _api.post(
        endpoint: "payment_intents",
        data: {"amount": amount, "currency": currency},
      );
      final paymentModel = PaymentModel.fromJson(response);
      return Right(paymentModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> initPaymentSheet({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'Mahmoud Gomaa',
      ),
    );
  }

  @override
  Future<void> displayPaymentSheet() {
    return Stripe.instance.presentPaymentSheet();
  }
}
