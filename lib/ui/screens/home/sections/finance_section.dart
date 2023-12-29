import 'package:flutter/material.dart';

import '../../../../data/model/finance.dart';

final financeList = [
  Finance(
    icon: Icons.work,
    name: "My\nBusiness",
    background: Colors.orange,
  ),
  Finance(
    icon: Icons.wallet,
    name: "My\nWallet",
    background: Colors.blue,
  ),
  Finance(
    icon: Icons.star_half,
    name: "Finance\nAnalytics",
    background: Colors.purple,
  ),
  Finance(
    icon: Icons.monetization_on,
    name: "My\nTransactions",
    background: Colors.green,
  ),
];

class FinanceSection extends StatelessWidget {
  const FinanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Finanças',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Ver mais",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
            )
          ],
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: financeList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: FinanceItem(finance: financeList[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class FinanceItem extends StatelessWidget {
  final Finance finance;

  const FinanceItem({super.key, required this.finance});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {},
          child: Container(
            alignment: Alignment.centerLeft,
            width: 140,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: finance.background,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Icon(finance.icon, color: Colors.white),
                  ),
                  Text(
                    finance.name,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
