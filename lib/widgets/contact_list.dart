
import 'package:feme/models/contact_model.dart';

final contactList = [
  Contact(
    name: "Alice John",
    role: "Senior Executive",
    imageUrl: "assets/images/img1.png",
    isOnline: true,
    isFavorite: true,
    status: 'online', rating: 5, // ✅
  ),
  Contact(
    name: "David Lee",
    role: "Manager",
    imageUrl: "assets/images/img2.png",
    isOnline: true,
    isFavorite: false,
    status: 'online', // ✅
    rating: 5,
  ),
  Contact(
    name: "Sophia Patel",
    role: "Coordinator",
    imageUrl: "assets/images/img3.png",
    isOnline: false,
    isFavorite: true,
    status: 'busy', // ✅
    rating: 5,
  ),
  Contact(
    name: "Michael Brown",
    role: "Support",
    imageUrl: "assets/images/img2.png",
    isOnline: false,
    isFavorite: false,
    status: 'offline', // ✅
    rating: 5,
  ),
];

// class Contact {
//   final String name;
//   final String role;
//   final String imageUrl;
//   final bool isOnline;
//   final bool isFavorite;
//   final String status;

//   Contact({
//     required this.name,
//     required this.role,
//     required this.imageUrl,
//     required this.isOnline,
//     required this.isFavorite,
//     required this.status, // ✅
//   });
// }
