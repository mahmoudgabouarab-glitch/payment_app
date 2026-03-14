import 'package:payment_app/feature/data/model/payment_model.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepo {
  Future<Either<String, PaymentModel>> postPaymentMethods({
    required int amount,
    required String currency,
  });
}