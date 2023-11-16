import 'package:flutter/material.dart';

class ContainerButtonWidget extends StatelessWidget {
  final Function() handleFunc;
  final String btnTxt;
  final Color boxColor, txtColor;

  const ContainerButtonWidget({
    super.key,
    required this.handleFunc,
    required this.btnTxt,
    required this.boxColor,
    required this.txtColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => handleFunc(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
                blurRadius: 3,
                spreadRadius: 1)
          ],
          color: boxColor,
        ),
        child: Center(
            child: Text(
          btnTxt,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w800, color: txtColor),
        )),
      ),
    );
  }
}
