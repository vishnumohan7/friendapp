import 'dart:convert';
import 'package:feme/widgets/call_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'transactions_screen.dart'; // Ensure this is correctly importing CallTransactionCard

class ExecutiveEarningsCard extends StatelessWidget {
  final double totalEarnings;
  final double availableBalance;
  final double pendingAmount;
  final VoidCallback onViewTransactions;

  const ExecutiveEarningsCard({
    super.key,
    required this.totalEarnings,
    required this.availableBalance,
    required this.pendingAmount,
    required this.onViewTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff2563EB), Color(0xFF9333EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Earnings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$${totalEarnings.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAmountColumn('Available', '\$${availableBalance.toStringAsFixed(2)}'),
              _buildAmountColumn('Pending', '\$${pendingAmount.toStringAsFixed(2)}'),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onViewTransactions,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.white),
                ),
              ),
              child: const Text('My Transactions'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountColumn(String label, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class ExecutiveDashboardScreen extends StatefulWidget {
  const ExecutiveDashboardScreen({super.key});

  @override
  State<ExecutiveDashboardScreen> createState() => _ExecutiveDashboardScreenState();
}

class _ExecutiveDashboardScreenState extends State<ExecutiveDashboardScreen> {
  List<dynamic> transactions = [];

  @override
  void initState() {
    super.initState();
    loadTransactionData();
  }

  Future<void> loadTransactionData() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/call_transactions.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      setState(() {
        transactions = jsonData;
      });
    } catch (e) {
      print("Error loading transaction data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: const [
          Icon(Icons.notifications_none_outlined, color: Color(0xff4B5563)),
          SizedBox(width: 10),
          Icon(Icons.menu, color: Color(0xff4B5563)),
          SizedBox(width: 20),
        ],
        elevation: 4,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Color(0xff111827),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Earnings Summary Card
            ExecutiveEarningsCard(
              totalEarnings: 1250.00,
              availableBalance: 1000.00,
              pendingAmount: 250.00,
              onViewTransactions: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TransactionsScreen()),
                );
              },
            ),
            const SizedBox(height: 20),

            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // Display transaction list
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: transactions.map((t) {
                return CallTransactionCard(
                  name: t['name'],
                  phoneNumber: t['phoneNumber'],
                  coinsUsed: t['coinsUsed'],
                  duration: t['duration'],
                  time: t['time'],
                  status: t['status'],
                  iconAssetPath: t['iconAssetPath'],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
