import 'package:flutter/material.dart';

class AvgDurationCard extends StatelessWidget {
  final String title;
  final String value;
  final String iconAssetPath; // asset path for the icon

  const AvgDurationCard({
    super.key,
    required this.title,
    required this.value,
    required this.iconAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Icon Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Image.asset(
                iconAssetPath,
                width: 16,
                height: 16,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Value
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.normal,
              color: Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}
