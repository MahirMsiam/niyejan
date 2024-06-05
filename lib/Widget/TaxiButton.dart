import 'package:flutter/material.dart';
import 'package:niyejan/brand_colors.dart';

class TaxiButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;

 
  TaxiButton(
      {required this.title, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color),
      ),
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Brand-Bold',
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
