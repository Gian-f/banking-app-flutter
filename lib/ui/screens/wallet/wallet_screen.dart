import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBarSection(
          onBackPressed: () {
            Navigator.of(context).pop();
          },
          title: 'Carteira',
        ),
        body: const Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
        ));
  }
}
