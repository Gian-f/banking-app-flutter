import 'package:flutter/material.dart';

import '../../../../data/model/transaction.dart';
import '../../../../utils/util.dart';

final transactions = [
  Transaction(
    name: "Salário",
    description: "Salário fixo",
    category: "Trabalho",
    type: TransactionType.entrada,
    icon: Icons.fastfood,
    price: 687.0,
    date: DateTime.now(),
  ),
  Transaction(
    name: "Ifood",
    description: "Fast Food",
    category: "Comida",
    type: TransactionType.saida,
    icon: Icons.fastfood,
    price: 200.0,
    date: DateTime.now(),
  ),
  Transaction(
    name: "Academia",
    description: "Basquete",
    category: "Saúde",
    type: TransactionType.saida,
    icon: Icons.sports_basketball,
    price: 80.0,
    date: DateTime.now(),
  ),
  Transaction(
    name: "PS5",
    description: "Console",
    category: "Video Games",
    type: TransactionType.saida,
    icon: Icons.sports_esports,
    price: 600.0,
    date: DateTime.now(),
  ),
  Transaction(
    name: "Academia",
    description: "Musculação",
    category: "Saúde",
    type: TransactionType.saida,
    icon: Icons.fitness_center,
    price: 100.0,
    date: DateTime.now(),
  ),
  Transaction(
    name: "Taxa do lixo",
    description: "Imposto",
    category: "Gasto",
    type: TransactionType.saida,
    icon: Icons.cleaning_services,
    price: 100.0,
    date: DateTime.now(),
  ),
];

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Transações',
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
        if (transactions.isEmpty)
          const EmptyTransactionState()
        else
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(transaction: transactions[index]);
              },
            ),
          ),
      ],
    );
  }
}

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          leading: Icon(transaction.icon),
          title: Text(transaction.name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transaction.description,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 17)),
              Text(transaction.category,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 14)),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction.type == TransactionType.entrada
                    ? "+ ${formatMoney(transaction.price)}"
                    : "- ${formatMoney(transaction.price)}",
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 9),
              Text(
                formatDateAgo(transaction.date),
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
