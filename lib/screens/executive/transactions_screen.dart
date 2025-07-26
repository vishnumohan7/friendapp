import 'dart:convert';
import 'package:feme/widgets/executive_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feme/widgets/call_transaction_card.dart';
import 'package:feme/widgets/totalcall_avgduration_card.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List<dynamic> allTransactions = [];
  String selectedTab = 'All';

  @override
  void initState() {
    super.initState();
    loadTransactionData();
  }

  Future<void> loadTransactionData() async {
    final String response =
        await rootBundle.loadString('assets/data/call_transactions.json');
    final data = await json.decode(response);
    setState(() {
      allTransactions = data;
    });
  }

  List<dynamic> get filteredTransactions {
    if (selectedTab == 'Today') {
      return allTransactions
          .where((t) => t['time'].toString().startsWith('Today'))
          .toList();
    } else if (selectedTab == 'Week') {
      return allTransactions
          .where((t) =>
              t['time'].toString().contains('Yesterday') ||
              t['time'].toString().contains('Today') ||
              t['time'].toString().contains('days ago'))
          .toList();
    }
    return allTransactions;
  }

  Widget buildFilterTab(String title) {
    final isSelected = selectedTab == title;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xfff1f5f9) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            'Transactions Summary',
            style: TextStyle(
              color: Color(0xff111827),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xff4B5563)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CoinUsageCard(totalCoins: 1247),
              const SizedBox(height: 10),
              SizedBox(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    AvgDurationCard(
                      title: 'Total Calls',
                      value: '120',
                      iconAssetPath: 'assets/icons/call.png',
                    ),
                    AvgDurationCard(
                      title: 'Avg. Duration',
                      value: '4:32',
                      iconAssetPath: 'assets/icons/clock.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildFilterTab('All'),
                  buildFilterTab('Today'),
                  buildFilterTab('Week'),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: filteredTransactions.map((t) {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
