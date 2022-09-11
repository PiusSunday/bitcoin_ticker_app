import 'package:flutter/material.dart';

class ReusablePriceCard extends StatelessWidget {
  const ReusablePriceCard({
    Key? key,
    required this.crypto,
    required this.rate,
    required this.currency,
  }) : super(key: key);

  final String crypto;
  final String rate;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal.shade800,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $rate $currency',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
