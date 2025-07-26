class CallTransaction {
  final String name;
  final String phoneNumber;
  final String coinsUsed;
  final String duration;
  final String time;
  final String status;
  final String iconAssetPath;

  CallTransaction({
    required this.name,
    required this.phoneNumber,
    required this.coinsUsed,
    required this.duration,
    required this.time,
    required this.status,
    required this.iconAssetPath,
  });

  factory CallTransaction.fromJson(Map<String, dynamic> json) {
    return CallTransaction(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      coinsUsed: json['coinsUsed'],
      duration: json['duration'],
      time: json['time'],
      status: json['status'],
      iconAssetPath: json['iconAssetPath'],
    );
  }
}
