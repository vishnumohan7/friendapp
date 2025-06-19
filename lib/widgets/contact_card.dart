import 'package:flutter/material.dart';
import 'package:friend_app/constants/textstyles.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final VoidCallback onCall;
  final bool isOnline;
  final bool isFavorite;

  const ContactCard({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.onCall,
    this.isOnline = false,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // Profile Image with status dot
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              if (isOnline)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),

          // Name and role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.label),
                Text(role, style: AppTextStyles.caption),
              ],
            ),
          ),

          // Star Icon
          Icon(
            Icons.star,
            color: isFavorite ? Colors.amber : Colors.grey.shade400,
          ),
          const SizedBox(width: 8),

          // Call Button
          ElevatedButton.icon(
            onPressed: onCall,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.call, size: 18),
            label: const Text("Call"),
          ),
        ],
      ),
    );
  }
}
