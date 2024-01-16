import 'package:banking_app/navigation.dart';
import 'package:banking_app/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../../../data/model/goal.dart';
import '../../../utils/util.dart';
import '../home/sections/goals_section.dart';

enum GoalStatus { ATIVO, INATIVO, CONCLUIDO }

class ListGoalScreen extends StatefulWidget {
  @override
  _ListGoalScreenState createState() => _ListGoalScreenState();
}

class _ListGoalScreenState extends State<ListGoalScreen> {
  GoalStatus selectedChip = GoalStatus.ATIVO;

  void _handleChipSelection(GoalStatus chip) {
    setState(() {
      selectedChip = chip;
    });
  }

  Widget _buildFilterChip(String label, GoalStatus chip) {
    return FilterChip(
      label: Text(label),
      selected: selectedChip == chip,
      selectedColor: Theme.of(context).colorScheme.onSecondary,
      onSelected: (selected) => _handleChipSelection(chip),
    );
  }

  List<Goal> getFilteredGoals() {
    switch (selectedChip) {
      case GoalStatus.ATIVO:
        return goals.where((goal) => goal.status == GoalStatus.ATIVO).toList();
      case GoalStatus.INATIVO:
        return goals
            .where((goal) => goal.status == GoalStatus.INATIVO)
            .toList();
      case GoalStatus.CONCLUIDO:
        return goals
            .where((goal) => goal.status == GoalStatus.CONCLUIDO)
            .toList();
      default:
        return goals;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarSection(
          onBackPressed: () {
            Navigator.of(context).pop();
          },
          title: "Objetivos"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFilterChip('Ativos', GoalStatus.ATIVO),
                  _buildFilterChip('Inativos', GoalStatus.INATIVO),
                  _buildFilterChip('Concluídos', GoalStatus.CONCLUIDO),
                ],
              ),
            ),
            if (getFilteredGoals().isEmpty)
              EmptyGoalsState()
            else
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 4),
                  itemCount: getFilteredGoals().length,
                  itemBuilder: (context, index) {
                    return GoalItem(goal: getFilteredGoals()[index]);
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            navigate(context, "/goals/add");
          }),
    );
  }
}

class GoalItem extends StatelessWidget {
  final Goal goal;

  const GoalItem({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    double progressFraction = goal.currentProgress / goal.goalNumber;

    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Card(
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  'Data prevista: ${dateFormat(goal.expectedDate)}',
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    LinearProgressIndicator(
                      value: progressFraction,
                      color: Theme.of(context).colorScheme.secondary,
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
        ),
      ),
    );
  }
}

class EmptyGoalsState extends StatelessWidget {
  const EmptyGoalsState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Card(
        margin: const EdgeInsets.all(32.0),
        color: theme.colorScheme.surface,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 38.0,
                  backgroundColor: theme.colorScheme.surfaceVariant,
                  child: const Icon(Icons.add, color: Colors.white, size: 44.0),
                ),
                const SizedBox(height: 12),
                Text(
                  'Para adicionar uma meta, clique aqui!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
