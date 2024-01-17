import 'package:banking_app/navigation.dart';
import 'package:banking_app/ui/screens/goal/list_goal_screen.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../data/di/module.dart';
import '../../../../data/model/goal.dart';
import '../../../../domain/controller/goal_controller.dart';
import '../../../widgets/pager_indicator.dart';

class GoalsSection extends StatefulWidget {
  const GoalsSection({Key? key}) : super(key: key);

  @override
  _GoalsSectionState createState() => _GoalsSectionState();
}

class _GoalsSectionState extends State<GoalsSection> {
  final PageController pageController = PageController();
  int _currentPage = 0;
  final _controller = getIt<GoalController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllGoals();
    pageController.addListener(() {
      int next = pageController.page!.round();

      if (next != _currentPage) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  Future<void> fetchAllGoals() async {
    await _controller.fetchAllGoals().then((value) => {
          if (value)
            {setState(() => isLoading = false)}
          else
            {setState(() => isLoading = true)}
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
    return ValueListenableBuilder<List<Goal?>>(
      valueListenable: _controller.goals,
      builder: (context, goals, _) {
        return Skeletonizer(
          enabled: isLoading,
          child: Column(
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
                    itemCount: goals.take(3).length,
                    itemBuilder: (context, index) {
                      return GoalItem(goal: goals[index]!);
                    },
                  ),
                ),
              Container(
                alignment: Alignment.center,
                height: 30,
                child: PagerIndicator(
                  itemCount: goals.take(3).length,
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
          ),
        );
      },
    );
  }
}
