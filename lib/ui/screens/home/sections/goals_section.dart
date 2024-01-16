import 'package:banking_app/navigation.dart';
import 'package:banking_app/ui/screens/goal/list_goal_screen.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/goal.dart';
import '../../../widgets/pager_indicator.dart';

List<Goal> goals = [
  Goal(
    name: 'Nova casa',
    icon: Icons.home,
    currentProgress: 32000.0,
    goalNumber: 200000.0,
    status: GoalStatus.ATIVO,
    expectedDate: DateTime.now(),
  ),
  Goal(
    name: 'Novo Celular',
    icon: Icons.phone_android,
    currentProgress: 1400.0,
    goalNumber: 2300.0,
    status: GoalStatus.INATIVO,
    expectedDate: DateTime.now(),
  ),
  Goal(
    name: 'Novo Veículo',
    icon: Icons.directions_car,
    currentProgress: 10000.0,
    goalNumber: 20000.0,
    status: GoalStatus.ATIVO,
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
                onPressed: () {
                  navigate(context, "/goals");
                },
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
