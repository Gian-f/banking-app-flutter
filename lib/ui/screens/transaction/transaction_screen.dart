import 'package:banking_app/navigation.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBarSection(
          onBackPressed: () {
            navigateFinish(context, "/home");
          },
          title: 'Transações',
        ),
        body: const Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
        ));
  }
}
