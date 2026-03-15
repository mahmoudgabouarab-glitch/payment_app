import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/core/network/api_service.dart';
import 'package:payment_app/core/network/cache_helper.dart';
import 'package:payment_app/feature/data/model/customer_model.dart';
import 'package:payment_app/feature/data/model/ephemeral_key_model.dart';
import 'package:payment_app/feature/data/model/payment_model.dart';

class StripeService {
  final ApiServise _apiService;
  StripeService(this._apiService);
  // Create customer
  Future<CustomerModel> createCustomer() async {
    var response = await _apiService.post(endpoint: "customers");
    final customerModel = CustomerModel.fromJson(response);
    await CacheHelper.saveData(key: "CustomerId", value: customerModel.id);
    return customerModel;
  }

  // create ephemeral key
  Future<EphemeralKeyModel> createEphemeralKey({
    required String customerId,
  }) async {
    var response = await _apiService.post(
      endpoint: "ephemeral_keys",
      data: {"customer": customerId},
      headers: {"Stripe-Version": "2023-10-16"},
    );
    final paymentModel = EphemeralKeyModel.fromJson(response);
    return paymentModel;
  }

  // create payment intent
  Future<PaymentModel> createPaymentIntent({
    required int amount,
    required String currency,
    required String customrId,
  }) async {
    var response = await _apiService.post(
      endpoint: "payment_intents",
      data: {"amount": amount, "currency": currency, "customer": customrId},
    );
    final paymentModel = PaymentModel.fromJson(response);
    return paymentModel;
  }

  // init payment sheet
  Future<void> initPaymentSheet({
    required String paymentIntentClientSecret,
    required String customerEphemeralKeySecret,
    required String customerId,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'Mahmoud Gomaa',
        customerEphemeralKeySecret: customerEphemeralKeySecret,
        customerId: customerId,
      ),
    );
  }

  // display payment sheet
  Future<void> displayPaymentSheet() {
    return Stripe.instance.presentPaymentSheet();
  }

  // make payment
  Future makePayment() async {
    var customerId = await CacheHelper.getData(key: "CustomerId");
    if (customerId == null) {
      var customerModel = await createCustomer();
      customerId = customerModel.id;
    }
    var ephemeralKey = await createEphemeralKey(customerId: customerId);
    var response = await createPaymentIntent(
      amount: 100,
      currency: "USD",
      customrId: customerId,
    );
    await initPaymentSheet(
      paymentIntentClientSecret: response.clientSecret,
      customerEphemeralKeySecret: ephemeralKey.secret,
      customerId: customerId,
    );
    await displayPaymentSheet();
  }
}
