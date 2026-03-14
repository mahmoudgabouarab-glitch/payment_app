import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/core/network/api_service.dart';
import 'package:payment_app/feature/data/model/payment_model.dart';

class StripeService {
  final ApiServise _apiService;

  StripeService(this._apiService);

  Future<PaymentModel> createPaymentIntent({
    required int amount,
    required String currency,
  }) async {
    var response = await _apiService.post(
      endpoint: "payment_intents",
      data: {"amount": amount, "currency": currency},
    );
    final paymentModel = PaymentModel.fromJson(response);
    return paymentModel;
  }

  Future<void> initPaymentSheet({
    required String paymentIntentClientSecret,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'Mahmoud Gomaa',
      ),
    );
  }

  Future<void> displayPaymentSheet() {
    return Stripe.instance.presentPaymentSheet();
  }

  Future makePayment() async {
    var response = await createPaymentIntent(amount: 100, currency: "USD");
    await initPaymentSheet(paymentIntentClientSecret: response.clientSecret);
    await displayPaymentSheet();
  }
}
