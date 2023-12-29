import 'package:banking_app/utils/util.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/goal.dart';
import '../../../widgets/pager_indicator.dart';

List<Goal> goals = [
  Goal(
    name: 'Nova casa',
    icon: Icons.home,
    currentProgress: 32000.0,
    goalNumber: 200000.0,
    expectedDate: DateTime.now(),
  ),
  Goal(
    name: 'Novo Celular',
    icon: Icons.phone_android,
    currentProgress: 1400.0,
    goalNumber: 2300.0,
    expectedDate: DateTime.now(),
  ),
  Goal(
    name: 'Novo Veículo',
    icon: Icons.directions_car,
    currentProgress: 10000.0,
    goalNumber: 20000.0,
    expectedDate: DateTime.now(),
  ),
];

class GoalsSection extends StatefulWidget {
  const GoalsSection({Key? key}) : super(key: key);

  @override
  _GoalsSectionState createState() => _GoalsSectionState();
}

class _GoalsSectionState extends State<GoalsSection> {
  final PageController pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      int next = pageController.page!.round();

      if (next != _currentPage) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    pageController.removeListener(() {});
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Objetivos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (goals.isNotEmpty)
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Ver mais',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
          ],
        ),
        if (goals.isEmpty)
          const EmptyGoalsState()
        else
          Flexible(
            fit: FlexFit.loose,
            child: PageView.builder(
              controller: pageController,
              itemCount: goals.length,
              itemBuilder: (context, index) {
                return GoalItem(goal: goals[index]);
              },
            ),
          ),
        Container(
          alignment: Alignment.center,
          height: 30,
          child: PagerIndicator(
            itemCount: goals.length,
            currentPage: _currentPage,
            onPageSelected: (index) {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
              );
            },
          ),
        ),
      ],
    );
  }
}

class GoalItem extends StatelessWidget {
  final Goal goal;

  const GoalItem({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    double progressFraction = goal.currentProgress / goal.goalNumber;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              child: Icon(goal.icon, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              goal.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              'Data prevista: ${dateFormat(goal.expectedDate)}',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Stack(
              children: [
                LinearProgressIndicator(
                  value: progressFraction,
                  borderRadius: BorderRadius.circular(6),
                  minHeight: 20,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Text('${(progressFraction * 100).toInt()}%',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Salvo:\n${formatMoney(goal.currentProgress)}'),
                Text('Objetivo:\n${formatMoney(goal.goalNumber)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyGoalsState extends StatelessWidget {
  const EmptyGoalsState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.add, color: Colors.white),
            ),
            SizedBox(height: 12),
            Text('Para adicionar uma meta, clique aqui!'),
          ],
        ),
      ),
    );
  }
}
