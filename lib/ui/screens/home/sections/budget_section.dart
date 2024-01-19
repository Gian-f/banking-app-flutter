import 'package:banking_app/data/model/budget_category.dart';
import 'package:banking_app/utils/util.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/budget.dart';

// List<Budget> budgets = [
//   Budget(
//     cardType: CardType.VISA,
//     cardNumber: "3664 7865 3786 3976",
//     cardName: "Business",
//     balance: 456.467,
//     color: [PurpleStart, PurpleEnd],
//   ),
//   Budget(
//     cardType: CardType.MASTERCARD,
//     cardNumber: "3664 7865 3786 3976",
//     cardName: "Business",
//     balance: 456.467,
//     color: [BlueStart, BlueEnd],
//   ),
//   Budget(
//     cardType: CardType.MASTERCARD,
//     cardNumber: "3664 7865 3786 3976",
//     cardName: "Business",
//     balance: 456.467,
//     color: [GreenStart, GreenEnd],
//   ),
//   Budget(
//     cardType: CardType.ADD_CARD,
//     cardNumber: "",
//     cardName: "Adicionar",
//     balance: 0,
//     color: [OrangeStart, OrangeEnd],
//   ),
// ];

class BudgetsSection extends StatelessWidget {
  const BudgetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Budget> getBudgets() {
      return [
        Budget(
          id: 1,
          name: 'Viagens',
          initialAmount: 1000,
          currentAmount: 700,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(Duration(days: 30)),
          category: Category(
              id: 1,
              name: "name",
              iconName: Icons.airplane_ticket_sharp,
              allocatedAmount: 1000),
        ),
        Budget(
          id: 2,
          name: 'Emergências',
          initialAmount: 1000,
          currentAmount: 900,
          startDate: DateTime.now(),
          endDate: DateTime.now().add(Duration(days: 30)),
          category: Category(
              id: 1,
              name: "name",
              iconName: Icons.error_outline,
              allocatedAmount: 1000),
        ),
        Budget(
            id: 3,
            name: 'Custos Mensais',
            initialAmount: 1000,
            currentAmount: 500,
            startDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(days: 30)),
            category: Category(
                id: 1,
                name: "name",
                iconName: Icons.attach_money,
                allocatedAmount: 1000)),
        Budget(
            id: 3,
            name: 'Negócios',
            initialAmount: 2000,
            currentAmount: 300,
            startDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(days: 30)),
            category: Category(
                id: 1,
                name: "name",
                iconName: Icons.business_center_rounded,
                allocatedAmount: 1000)),
      ];
    }

    final List<Budget> budgets = getBudgets();

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: budgets.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.only(left: index == 0 ? 16 : 0, right: 16),
                  child: InkWell(
                    onTap: () {}, // Defina a ação ao tocar no cartão
                    borderRadius: BorderRadius.circular(25),
                    child: BudgetItem(budgets[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BudgetItem extends StatelessWidget {
  final Budget budget;

  const BudgetItem(this.budget, {super.key});

  @override
  Widget build(BuildContext context) {
    final double progress = budget.currentAmount / budget.initialAmount;
    final int remainingDays =
        budget.endDate.difference(budget.startDate).inDays;
    final List<FlSpot> spots = [
      FlSpot(0, budget.initialAmount),
      FlSpot(remainingDays.toDouble(), budget.currentAmount),
    ];

    return Ink(
      width: 250,
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surfaceVariant
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Icon(budget.category.iconName),
            Text(budget.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Container()
          ]),
          Text('Gasto: \$${formatMoney(budget.currentAmount)}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                minX: 0,
                // Defina de acordo com seus dados
                maxX: remainingDays.toDouble(),
                // Defina de acordo com seus dados
                minY: budget.currentAmount,
                // Defina de acordo com seus dados
                maxY: budget.initialAmount,
                // Defina de acordo com seus dados
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.white,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.white),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Faltam $remainingDays dias',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Icon(Icons.timelapse_outlined)
          ])
        ],
      ),
    );
  }
}
