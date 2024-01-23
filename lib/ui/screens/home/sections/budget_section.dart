import 'package:banking_app/data/model/budget_category.dart';
import 'package:flutter/material.dart';

import '../../../../data/model/budget.dart';
import '../../../../utils/util.dart';

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
      name: 'Custos Mensais',
      initialAmount: 1500,
      currentAmount: 700,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      category: Category(
          id: 1,
          name: "name",
          iconName: Icons.airplane_ticket_sharp,
          allocatedAmount: 1000),
    ),
  ];
}

class BudgetsSection extends StatelessWidget {
  const BudgetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Budget> budgets = getBudgets();

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Orçamentos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Ver mais",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: budgets.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(15),
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

  const BudgetItem(this.budget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = budget.currentAmount / budget.initialAmount;
    final int remainingDays =
        budget.endDate.difference(budget.startDate).inDays;

    final List<PieChartData> chartData = [
      PieChartData(Colors.blue, progress * 100),
      PieChartData(Colors.grey, (100 - progress * 100)),
    ];
    final isSingleBudget = getBudgets().length == 1;

    return Ink(
      width: isSingleBudget ? MediaQuery.of(context).size.width * 0.9 : 320,
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surfaceVariant,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(budget.category.iconName),
              Text(
                budget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "${formatMoney(budget.currentAmount)} / ${formatMoney(budget.initialAmount)}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Progresso do orçamento",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              PieChart(
                data: chartData,
                radius: 20,
                strokeWidth: 4,
              ),
            ],
          ),
          Divider(color: Colors.white),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Faltam $remainingDays dias',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.timelapse_outlined),
            ],
          ),
        ],
      ),
    );
  }
}

class PieChartData {
  const PieChartData(this.color, this.percent);

  final Color color;
  final double percent;
}

class PieChart extends StatelessWidget {
  PieChart({
    required this.data,
    required this.radius,
    this.strokeWidth = 3,
    this.child,
    Key? key,
  })  : assert(data.fold<double>(0, (sum, data) => sum + data.percent) <= 100),
        super(key: key);

  final List<PieChartData> data;
  // radius of chart
  final double radius;
  // width of stroke
  final double strokeWidth;
  // optional child; can be used for text for example
  final Widget? child;

  @override
  Widget build(context) {
    return CustomPaint(
      painter: _Painter(strokeWidth, data),
      size: Size.square(radius),
      child: SizedBox.square(
        // calc diameter
        dimension: radius * 2,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class _PainterData {
  const _PainterData(this.paint, this.radians);

  final Paint paint;
  final double radians;
}

class _Painter extends CustomPainter {
  _Painter(double strokeWidth, List<PieChartData> data) {
    // convert chart data to painter data
    dataList = data
        .map((e) => _PainterData(
              Paint()
                ..color = e.color
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..strokeCap = StrokeCap.round,
              // remove padding from stroke
              (e.percent - _padding) * _percentInRadians,
            ))
        .toList();
  }

  static const _percentInRadians = 0.062831853071796;
  // this is the gap between strokes in percent
  static const _padding = 4;
  static const _paddingInRadians = _percentInRadians * _padding;
  // 0 radians is to the right, but since we want to start from the top
  // we'll use -90 degrees in radians
  static const _startAngle = -1.570796 + _paddingInRadians / 2;

  late final List<_PainterData> dataList;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    // keep track of start angle for next stroke
    double startAngle = _startAngle;

    for (final data in dataList) {
      final path = Path()..addArc(rect, startAngle, data.radians);

      startAngle += data.radians + _paddingInRadians;

      canvas.drawPath(path, data.paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
