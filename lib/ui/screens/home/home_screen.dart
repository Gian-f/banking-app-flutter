import 'package:banking_app/ui/screens/home/sections/card_section.dart';
import 'package:banking_app/ui/screens/home/sections/finance_section.dart';
import 'package:banking_app/ui/screens/home/sections/goals_section.dart';
import 'package:banking_app/ui/screens/home/sections/transactions_section.dart';
import 'package:banking_app/ui/screens/home/sections/wallet_section.dart';
import 'package:banking_app/ui/screens/transaction/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/app_bar.dart';
import '../profile/profile_screen.dart';
import '../wallet/wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) {
            return;
          }
          await onBackPressDialog(context);
        },
        child: Scaffold(
          appBar: const HomeAppBar(),
          body: ListView(
            children: const [
              SizedBox(
                width: 400,
                height: 115,
                child: WalletSection(),
              ),
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
      ),
    );
  }

  Future<void> onBackPressDialog(BuildContext context) async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Atenção!'),
        content: const Text('Você tem certeza que deseja sair?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sim'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Não'),
          ),
        ],
      ),
    );

    if (shouldPop ?? false) {
      SystemNavigator.pop();
    }
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomePage(),
    const TransactionScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customBottomNavBar(),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
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
          currentPageIndex = index;
          _pageController.jumpToPage(index);
        });
      },
    );
  }
}
