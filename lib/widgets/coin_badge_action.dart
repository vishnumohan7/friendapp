import 'package:flutter/material.dart';

class CoinBadge extends StatelessWidget {
  final int coins;

  const CoinBadge({super.key, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9C4), // Light yellow
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.monetization_on, color: Color(0xFFB8860B), size: 16),
          const SizedBox(width: 4),
          Text(
            coins.toString(),
            style: const TextStyle(
              color: Color(0xFFB8860B),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
