import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChoosePaymetMethod extends StatefulWidget {
  const ChoosePaymetMethod({super.key});

  @override
  State<ChoosePaymetMethod> createState() => _ChoosePaymetMethodState();
}

class _ChoosePaymetMethodState extends State<ChoosePaymetMethod> {
  List<String> cards = ["assets/visa.svg", "assets/paypal.svg"];
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(right: 10),
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selectedIndex == index
                      ? Color(0xff34A853)
                      : Colors.grey,
                  width: 3,
                ),
              ),
              child: Center(child: SvgPicture.asset(cards[index])),
            ),
          );
        },
      ),
    );
  }
}
