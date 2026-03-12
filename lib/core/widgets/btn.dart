import 'package:flutter/material.dart';
import 'package:payment_app/core/utils/styles.dart';

class Btn extends StatelessWidget {
  final void Function()? ontap;

  final String? text;
  final double? minWidth;
  final Color? color;
  final Widget? child;

  const Btn({
    super.key,
    required this.ontap,

    this.text,
    this.minWidth,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: ontap,
      color: color ?? const Color(0xff665AF0),
      child:
          child ??
          Center(
            child: Text(
              text ?? "",
              style: Styles.s22,
            ),
          ),
    );
  }
}
