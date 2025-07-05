import 'package:flutter/material.dart';

class CoinPackCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String iconAsset; // Replace with your icon path or icon
  final String? tag; // e.g. "Popular" or "Best Deal"
  final Color? tagColor;
  final String? bonusText; // e.g. "+200 Bonus"
  final Color? bonusColor;
  final Color? IconBG;
  final VoidCallback onBuy;

  const CoinPackCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.iconAsset,
    this.tag,
    this.tagColor,
    this.bonusText,
    this.bonusColor,
    this.IconBG,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Icon with background
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:  IconBG,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(iconAsset, width: 32, height: 32),
            ),
            const SizedBox(width: 12),

            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (tag != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: tagColor ?? Colors.blue,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            tag!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                  if (bonusText != null)
                    Text(
                      bonusText!,
                      style: TextStyle(
                        color: bonusColor ?? Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),

            // Price & Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: onBuy,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    minimumSize: const Size(70, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text("Buy Now", style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
