import 'package:flutter/material.dart';

class CoinUsageCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final String iconPath;
  final Color iconColor;

  const CoinUsageCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.iconPath,
    this.iconColor = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Takes full width
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row: Title + Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Image.asset(
                iconPath,
                color: iconColor,
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Value
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),

          /// Subtitle
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
