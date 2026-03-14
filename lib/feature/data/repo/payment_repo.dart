import 'package:dartz/dartz.dart';

abstract class PaymentRepo {
  Future<Either<String, void>> makePayment();
}
