final contactList = [
  Contact(
    name: "Alice John",
    role: "Senior Executive",
    imageUrl: "assets/images/img1.png",
    isOnline: true,
    isFavorite: true,
    status: 'online', // ✅
  ),
  Contact(
    name: "David Lee",
    role: "Manager",
    imageUrl: "assets/images/img2.png",
    isOnline: true,
    isFavorite: false,
    status: 'online', // ✅
  ),
  Contact(
    name: "Sophia Patel",
    role: "Coordinator",
    imageUrl: "assets/images/img3.png",
    isOnline: false,
    isFavorite: true,
    status: 'busy', // ✅
  ),
  Contact(
    name: "Michael Brown",
    role: "Support",
    imageUrl: "assets/images/img2.png",
    isOnline: false,
    isFavorite: false,
    status: 'offline', // ✅
  ),
];

class Contact {
  final String name;
  final String role;
  final String imageUrl;
  final bool isOnline;
  final bool isFavorite;
  final String status;

  Contact({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.isOnline,
    required this.isFavorite,
    required this.status, // ✅
  });
}
