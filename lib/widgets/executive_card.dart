import 'package:flutter/material.dart';

class ExecutiveCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final double rating;
  final String status; // 'online', 'offline', 'busy'
  final bool isFavorite;
  final VoidCallback onVideoCall;
  final VoidCallback onCall;
  final VoidCallback onFavorite;

  const ExecutiveCard({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.rating,
    required this.status,
    required this.isFavorite,
    required this.onVideoCall,
    required this.onCall,
    required this.onFavorite,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'online':
        return Colors.green;
      case 'busy':
        return Colors.orange;
      case 'offline':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: _statusColor(status),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(role,
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      ...List.generate(
                          5,
                          (index) => Icon(Icons.star,
                              size: 14,
                              color: index < rating.floor()
                                  ? Colors.amber
                                  : Colors.grey[300])),
                      const SizedBox(width: 4),
                      Text(
                        '($rating)',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.favorite,
                  color: isFavorite ? Colors.red : Colors.grey),
              onPressed: onFavorite,
            ),
            IconButton(
              icon: const Icon(Icons.videocam, color: Colors.green),
              onPressed: onVideoCall,
            ),
            IconButton(
              icon: const Icon(Icons.call, color: Colors.blue),
              onPressed: onCall,
            ),
          ],
        ),
      ),
    );
  }
}
