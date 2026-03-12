import 'package:flutter/material.dart';
import 'package:payment_app/core/utils/styles.dart';
import 'package:payment_app/core/widgets/btn.dart';

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
            Btn(ontap: () {}, text: "Complete Payment"),
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
