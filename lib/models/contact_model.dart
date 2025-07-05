class Contact {
  final String name;
  final String role;
  final String imageUrl;
  final double rating;
  final String status;
  final bool isOnline;
  final bool isFavorite;

  Contact({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.rating,
    required this.status,
    this.isOnline = false,
    this.isFavorite = false,
  });
}
