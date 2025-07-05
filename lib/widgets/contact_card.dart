import 'package:feme/core/textstyles.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final VoidCallback onAudioCall;
  final VoidCallback onVideoCall;
  final bool isOnline;
  final bool isFavorite;

  const ContactCard({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.onAudioCall,
    required this.onVideoCall,
    this.isOnline = false,
    this.isFavorite = false,
  });

  void _showCallOptions(BuildContext context, Offset buttonOffset) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonOffset.dx,
        buttonOffset.dy,
        overlay.size.width - buttonOffset.dx,
        overlay.size.height - buttonOffset.dy,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem(
          value: 'audio',
          child: Row(
            children: const [
              Icon(Icons.call, color: Colors.blue),
              SizedBox(width: 8),
              Text('Audio Call'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'video',
          child: Row(
            children: const [
              Icon(Icons.videocam, color: Colors.deepPurple),
              SizedBox(width: 8),
              Text('Video Call'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'audio') {
        onAudioCall();
      } else if (value == 'video') {
        onVideoCall();
      }
    });
  }

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
          /// Profile Image with status
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

          /// Name and Role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.label),
                Text(role, style: AppTextStyles.caption),
              ],
            ),
          ),

          /// Favorite Icon
          Icon(
            Icons.star,
            color: isFavorite ? Colors.amber : Colors.grey.shade400,
          ),
          const SizedBox(width: 8),

          /// Call Button (with floating popup)
          Builder(
            builder: (context) {
              return ElevatedButton.icon(
                onPressed: () {
                  final RenderBox button = context.findRenderObject() as RenderBox;
                  final Offset offset = button.localToGlobal(Offset.zero);
                  _showCallOptions(context, offset);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.call, size: 18),
                label: const Text("Call"),
              );
            },
          ),
        ],
      ),
    );
  }
}
