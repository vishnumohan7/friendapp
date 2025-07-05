import 'package:feme/core/textstyles.dart';
import 'package:feme/widgets/coin_usage_card.dart';
import 'package:feme/widgets/stat_card.dart';
import 'package:feme/widgets/transaction_card.dart';
import 'package:feme/widgets/transcation_list_data.dart';
import 'package:flutter/material.dart';


enum FilterTab { all, today, week }

class TransactionSummaryScreen extends StatefulWidget {
  const TransactionSummaryScreen({super.key});

  @override
  State<TransactionSummaryScreen> createState() =>
      _TransactionSummaryScreenState();
}

class _TransactionSummaryScreenState extends State<TransactionSummaryScreen> {
  FilterTab selectedTab = FilterTab.all;

  List<TransactionCard> get filteredTransactions {
    final now = DateTime.now();
    return transactions.where((item) {
      switch (selectedTab) {
        case FilterTab.today:
          return item.date.year == now.year &&
              item.date.month == now.month &&
              item.date.day == now.day;
        case FilterTab.week:
          return now.difference(item.date).inDays < 7;
        case FilterTab.all:
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Transaction Summary', style: AppTextStyles.heading3),
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Coin usage card
            CoinUsageCard(
              title: 'Total Coins Used',
              value: '1,247',
              subtitle: 'This month',
              iconPath: 'assets/icons/coins.png',
              iconColor: Colors.amber,
            ),

            /// Stat cards
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: StatCard(
                        title: 'Total Calls',
                        value: '43',
                        icon: Icons.phone,
                        iconColor: Colors.green,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: StatCard(
                        title: 'Avg. Duration',
                        value: '4:32',
                        icon: Icons.timelapse,
                        iconColor: Colors.indigo,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Tab bar
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F3F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: FilterTab.values.map((tab) {
                  final isSelected = selectedTab == tab;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedTab = tab);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          tab.name[0].toUpperCase() + tab.name.substring(1),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.black87 : Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            /// Filtered transaction list
            Expanded(
              child: ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final item = filteredTransactions[index];
                  return TransactionCard(
                    name: item.name,
                    phone: item.phone,
                    time: item.time,
                    coinText: item.coinText,
                    duration: item.duration,
                    status: item.status,
                    icon: item.icon,
                    iconColor: item.iconColor,
                    statusColor: item.statusColor,
                    date: item.date,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
