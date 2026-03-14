import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/feature/data/repo/payment_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._repo) : super(PaymentInitial());
  final PaymentRepo _repo;

  Future<void> postPaymentMethods() async {
    emit(PaymentLoading());
    final result = await _repo.makePayment();
    result.fold((l) => emit(PaymentFailure(l)), (r) => emit(PaymentSuccess()));
  }
}
