import 'package:banking_app/ui/screens/auth/login/login_screen.dart';
import 'package:banking_app/ui/screens/home/sections/card_section.dart';
import 'package:banking_app/ui/screens/home/sections/finance_section.dart';
import 'package:banking_app/ui/screens/home/sections/goals_section.dart';
import 'package:banking_app/ui/screens/home/sections/transactions_section.dart';
import 'package:banking_app/ui/screens/home/sections/wallet_section.dart';
import 'package:banking_app/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'ui/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: schemeDark,
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: customBottomNavBar(),
      body: <Widget>[
        // Add your page widgets here
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListView(
            children: const [
              WalletSection(),
              SizedBox(
                width: 400,
                height: 200,
                child: CardsSection(),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 400,
                height: 300,
                child: GoalsSection(),
              ),
              SizedBox(
                width: 400,
                height: 230,
                child: FinanceSection(),
              ),
              SizedBox(
                width: 400,
                height: 400,
                child: TransactionsSection(),
              ),
            ],
          ),
        ),
        // More pages...
      ][currentPageIndex],
    );
  }

  NavigationBar customBottomNavBar() {
    return NavigationBar(
      indicatorColor: Theme.of(context).colorScheme.surfaceVariant,
      destinations: const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_balance_outlined),
          selectedIcon: Icon(Icons.account_balance),
          label: 'Transações',
        ),
        NavigationDestination(
          icon: Icon(Icons.wallet_outlined),
          selectedIcon: Icon(Icons.wallet),
          label: 'Carteira',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_2_outlined),
          selectedIcon: Icon(Icons.person_2),
          label: 'Perfil',
        ),
      ],
      selectedIndex: currentPageIndex,
      onDestinationSelected: (int index) {
        setState(() {
          // currentPageIndex = index;
        });
      },
    );
  }
}
