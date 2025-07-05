import 'package:feme/core/textstyles.dart';
import 'package:feme/widgets/bottom_navigation.dart';
import 'package:feme/widgets/coin_package.dart';
import 'package:feme/widgets/coins_card.dart';
import 'package:flutter/material.dart';


class CoinsScreen extends StatefulWidget {
  const CoinsScreen({super.key});

  @override
  State<CoinsScreen> createState() => _CoinsScreenState();
}

class _CoinsScreenState extends State<CoinsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Purchased Coins', style: AppTextStyles.heading3),
          centerTitle: true,
          actions: [Icon(Icons.more_vert, color: Colors.black54)],
        ),
        bottomNavigationBar: BottomNavBar(currentIndex: 1),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CoinsCard(balance: 1250, lastUpdated: '2 hours ago'),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('Coin Packages', style: AppTextStyles.heading3),
                  Spacer(),
                  Text(
                    'Best Value',
                    style: AppTextStyles.link.copyWith(color: Colors.green),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  // padding: const EdgeInsets.all(16),
                  children: [
                    CoinPackCard(
                      title: "100 Coins",
                      subtitle: "Starter Pack",
                      price: "\$0.99",
                      iconAsset: "assets/icons/coins.png",
                      onBuy: () {},
                      IconBG: Color(0xffFEF9C3),
                    ),
                    CoinPackCard(
                      title: "500 Coins",
                      subtitle: "Value Pack",
                      price: "\$4.99",
                      iconAsset: "assets/icons/coins.png",
                      tag: "Popular",
                      tagColor: Colors.blue,
                      onBuy: () {},
                      IconBG: Color(0xffDBEAFE),
                    ),
                    CoinPackCard(
                      title: "1,200 Coins",
                      subtitle: "Premium Pack",
                      price: "\$9.99",
                      iconAsset: "assets/icons/coins.png",
                      bonusText: "+200 Bonus",
                      bonusColor: Colors.green,
                      tag: "Best Deal",
                      tagColor: Colors.green,
                      onBuy: () {},
                      IconBG: Color(0xffF3E8FF),
                    ),
                    CoinPackCard(
                      title: "3,000 Coins",
                      subtitle: "Ultimate Pack",
                      price: "\$19.99",
                      iconAsset: "assets/icons/coins.png",
                      bonusText: "+800 Bonus",
                      bonusColor: Colors.orange,
                      onBuy: () {},
                      IconBG: Color(0xffFACC15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
