import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BenefitsSection extends StatefulWidget {
  const BenefitsSection({super.key});

  @override
  State<BenefitsSection> createState() => _BenefitsSectionState();
}

class _BenefitsSectionState extends State<BenefitsSection> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          child: Skeletonizer(
              enabled: false,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 8),
                    Text("Seus benefícios",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Chip(
                        label: Text("Cliente Premium"),
                        labelPadding: EdgeInsets.all(2)),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                  ])),
        ),
      ),
    );
  }
}
