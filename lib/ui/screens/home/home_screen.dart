import 'package:banking_app/domain/controller/goal_controller.dart';
import 'package:banking_app/domain/controller/home_controller.dart';
import 'package:banking_app/ui/screens/home/sections/benefits_section.dart';
import 'package:banking_app/ui/screens/home/sections/budget_section.dart';
import 'package:banking_app/ui/screens/home/sections/financial_section.dart';
import 'package:banking_app/ui/screens/home/sections/goals_section.dart';
import 'package:banking_app/ui/screens/home/sections/help_section.dart';
import 'package:banking_app/ui/screens/home/sections/plan_section.dart';
import 'package:banking_app/ui/screens/home/sections/services_section.dart';
import 'package:banking_app/ui/screens/home/sections/wallet_section.dart';
import 'package:banking_app/ui/screens/transaction/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/di/module.dart';
import '../../../data/model/goal.dart';
import '../../../navigation.dart';
import '../../widgets/app_bar.dart';
import '../profile/profile_screen.dart';
import '../wallet/wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final controller = getIt<HomeController>();
  final goalsController = getIt<GoalController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) {
            return;
          }
          await onBackPressDialog(context);
        },
        child: Scaffold(
          appBar: HomeAppBar(),
          body: ListView(
            children: [
              Container(
                width: screenWidth,
                height: screenWidth * 0.30,
                child: WalletSection(),
              ),
              Container(
                width: screenWidth,
                height: screenWidth * 0.40,
                child: ServicesSection(),
              ),
              Container(
                width: screenWidth,
                height: screenWidth * 0.5,
                child: BudgetsSection(),
              ),
              SizedBox(height: 30),
              Container(
                width: screenWidth,
                height: screenWidth * 0.22,
                child: PlanSection(),
              ),
              SizedBox(height: 15),
              ValueListenableBuilder<List<Goal?>>(
                valueListenable: goalsController.goals,
                builder: (context, builder, _) {
                  return Container(
                    width: screenWidth,
                    height: goalsController.goals.value.isEmpty
                        ? screenWidth
                        : screenWidth * 0.7,
                    child: GoalsSection(),
                  );
                },
              ),
              Container(
                width: screenWidth,
                height: screenWidth * 0.17,
                child: BenefitsSection(),
              ),
              SizedBox(height: 15),
              Container(
                width: screenWidth,
                height: screenWidth * 0.22,
                child: HelpSection(),
              ),
              SizedBox(height: 15),
              Container(
                width: screenWidth,
                height: screenWidth * 1.2,
                child: FinancialSection(),
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
            onPressed: () => logout(context),
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
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      const TransactionScreen(),
      const WalletScreen(),
      const ProfileScreen(),
    ];
  }

  final PageController _pageController = PageController();

  int currentPageIndex = 0;

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

void logout(BuildContext context) {
  final controller = getIt<HomeController>();
  const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  storage.deleteAll();
  controller.user.value = null;
  navigateFinish(context, "/login");
}
