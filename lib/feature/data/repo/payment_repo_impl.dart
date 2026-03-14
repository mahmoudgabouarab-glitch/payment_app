import 'package:dartz/dartz.dart';
import 'package:payment_app/core/network/stripe_service.dart';
import 'package:payment_app/feature/data/repo/payment_repo.dart';

class PaymentRepoImpl extends PaymentRepo {
  final StripeService _stripeService;

  PaymentRepoImpl(this._stripeService);
  @override
  Future<Either<String, void>> makePayment() async {
    try {
      await _stripeService.makePayment();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
