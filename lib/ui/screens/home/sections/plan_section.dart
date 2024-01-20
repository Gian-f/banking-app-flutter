import 'package:banking_app/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlanSection extends StatefulWidget {
  const PlanSection({super.key});

  @override
  State<PlanSection> createState() => _PlanSectionState();
}

class _PlanSectionState extends State<PlanSection> {
  String planValue = "R\$ 9,99";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Skeletonizer(
        enabled: false,
        child: Column(children: [
          ListTile(
            title: Expanded(
              child: Text(
                "Assine o premium",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
            subtitle: Expanded(
              // Wrap Row with Expanded
              child: Row(children: [
                Text(
                  "$planValue ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "/mensal",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),
            ),
            trailing: TextButton(
              onPressed: () {},
              child: Text(
                "Escolha o plano",
                style: TextStyle(color: BlueEnd, fontSize: 14),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
