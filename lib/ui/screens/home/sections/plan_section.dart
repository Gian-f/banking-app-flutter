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
  Widget build(BuildContext context) {
    return Card(
      child: Skeletonizer(
        enabled: false,
        child: Column(children: [
          ListTile(
            title: Text(
              "Assine o premium",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            subtitle: Row(children: [
              Text(
                "$planValue ",
                style: TextStyle(
                  fontSize: 18,
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
            trailing: TextButton(
              onPressed: () {},
              child: Text(
                "Escolha o plano",
                style: TextStyle(color: BlueEnd, fontSize: 16),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
