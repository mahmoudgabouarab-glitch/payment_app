import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/core/utils/styles.dart';
import 'package:payment_app/core/widgets/btn.dart';
import 'package:payment_app/feature/presentation/view/widgets/mycart/choose_paymet_method.dart';
import 'package:payment_app/feature/presentation/view_model/cubit/payment_cubit.dart';

class MyCartBody extends StatelessWidget {
  const MyCartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Cart', style: Styles.s25)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset('assets/cart.png'),
            SizedBox(height: 25),
            _details("Order Subtotal", "\$42"),
            SizedBox(height: 3),
            _details("Discount", "\$0"),
            SizedBox(height: 3),
            _details("Shipping", "\$8"),
            Divider(height: 30),
            _details("Total", "\$50"),
            SizedBox(height: 16),
            Btn(
              ontap: () {
                _cartbttomsheet(context);
              },
              text: "Complete Payment",
            ),
          ],
        ),
      ),
    );
  }
}

Widget _details(String title, String value) {
  return Row(
    children: [
      Text(title, style: Styles.s18),
      const Spacer(),
      Text(value, style: Styles.s18),
    ],
  );
}

Future<dynamic> _cartbttomsheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            children: [
              const ChoosePaymetMethod(),
              const Spacer(),
              Btn(
                ontap: () {
                  context.read<PaymentCubit>().postPaymentMethods();
                },
                text: "Paypal",
              ),
            ],
          ),
        ),
      );
    },
  );
}
