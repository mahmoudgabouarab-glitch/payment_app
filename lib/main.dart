import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/core/network/api_keys.dart';
import 'package:payment_app/core/network/api_service.dart';
import 'package:payment_app/core/network/cache_helper.dart';
import 'package:payment_app/core/network/stripe_service.dart';
import 'package:payment_app/feature/data/repo/payment_repo_impl.dart';
import 'package:payment_app/feature/presentation/view/my_cart_view.dart';
import 'package:payment_app/feature/presentation/view_model/cubit/payment_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = ApiKeys.publishableKey;
  await Stripe.instance.applySettings();
  await CacheHelper().init();
  runApp(const PaymentApp());
}

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PaymentCubit(PaymentRepoImpl(StripeService(ApiServise(Dio())))),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyCartView(),
      ),
    );
  }
}
