import 'package:flutter/material.dart';

import '../../../../data/model/financial_movements.dart';
import '../../../../utils/util.dart';

final transactions = [
  FinancialMovements(
    name: "Salário",
    description: "Salário fixo",
    category: "Trabalho",
    type: TransactionType.entrada,
    icon: Icons.fastfood,
    price: 2000.0,
    date: DateTime.now(),
  ),
  FinancialMovements(
    name: "Ifood",
    description: "Fast Food",
    category: "Comida",
    type: TransactionType.saida,
    icon: Icons.fastfood,
    price: 200.0,
    date: DateTime.now(),
  ),
  FinancialMovements(
    name: "Academia",
    description: "Basquete",
    category: "Saúde",
    type: TransactionType.saida,
    icon: Icons.sports_basketball,
    price: 80.0,
    date: DateTime.now(),
  ),
  FinancialMovements(
    name: "PS5",
    description: "Console",
    category: "Video Games",
    type: TransactionType.saida,
    icon: Icons.sports_esports,
    price: 600.0,
    date: DateTime.now(),
  ),
  FinancialMovements(
    name: "Academia",
    description: "Musculação",
    category: "Saúde",
    type: TransactionType.saida,
    icon: Icons.fitness_center,
    price: 100.0,
    date: DateTime.now(),
  ),
];

class FinancialSection extends StatelessWidget {
  const FinancialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Movimentações',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (transactions.isNotEmpty)
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
        SizedBox(height: 12),
        if (transactions.isEmpty)
          const EmptyTransactionState()
        else
          Column(
            children: transactions.reversed
                .take(4)
                .map((transaction) =>
                    FinancialMovementItem(movement: transaction))
                .toList(),
          ),
      ],
    );
  }
}

class FinancialMovementItem extends StatelessWidget {
  final FinancialMovements movement;

  const FinancialMovementItem({super.key, required this.movement});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          leading: Icon(movement.icon),
          title: Text(movement.name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movement.description,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 17)),
              Text(movement.category,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 14)),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                movement.type == TransactionType.entrada
                    ? "+ ${formatMoney(movement.price)}"
                    : "- ${formatMoney(movement.price)}",
                style: movement.type == TransactionType.entrada
                    ? const TextStyle(fontSize: 17, color: Colors.green)
                    : const TextStyle(fontSize: 17, color: Colors.red),
              ),
              const SizedBox(height: 9),
              Text(
                formatDateAgo(movement.date),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyTransactionState extends StatelessWidget {
  const EmptyTransactionState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Nenhuma transação foi encontrada!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
