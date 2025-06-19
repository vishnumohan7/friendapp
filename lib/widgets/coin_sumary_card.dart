import 'package:flutter/material.dart';

class CoinSummaryCard extends StatelessWidget {
  final int totalBalance;
  final int available;
  final int pending;
  final VoidCallback onViewTransactions;

  const CoinSummaryCard({
    super.key,
    required this.totalBalance,
    required this.available,
    required this.pending,
    required this.onViewTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff2563EB), Color(0xFF9333EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Coin Summary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Image.asset('assets/icons/coins.png'),
            ],
          ),
          const SizedBox(height: 16),

          // Amounts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Balance',
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                totalBalance.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Available', style: TextStyle(color: Colors.white70)),
              Text(
                available.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pending', style: TextStyle(color: Colors.white70)),
              Text(
                pending.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // View Transactions button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onViewTransactions,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('View Transactions'),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
