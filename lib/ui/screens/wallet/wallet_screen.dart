import 'package:flutter/material.dart';

import '../../../navigation.dart';
import '../../widgets/app_bar.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBarSection(
          onBackPressed: () {
            navigate(context, "/wallet");
          },
          title: 'Carteira',
        ),
        body: const Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
        ));
  }
}
