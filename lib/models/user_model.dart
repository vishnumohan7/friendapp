class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? status;
  final String? userType;
  final String? avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.status,
    this.userType,
    this.avatar,
  });

  bool get isOnline => status?.toLowerCase() == 'online';
  bool get isBusy => status?.toLowerCase() == 'busy';
  bool get isOffline => status?.toLowerCase() == 'offline';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['username'] ?? 'Unknown',
      email: json['email'] ?? '',
      phone: json['phone'],
      status: json['status']?.toString().toLowerCase(),
      userType: json['usertype']?.toString().toLowerCase(),
      avatar: json['profile_photo_url'],
    );
  }
}

class UserListResponse {
  final List<User> users;
  final bool hasMore;

  UserListResponse({
    required this.users,
    required this.hasMore,
  });

  factory UserListResponse.fromJson(List<dynamic> json) {
    return UserListResponse(
      users: json.map((user) => User.fromJson(user)).toList(),
      hasMore: false, // Update based on your API pagination
    );
  }
}
