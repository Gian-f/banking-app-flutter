import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:banking_app/ui/screens/auth/login/login_screen.dart';
import 'package:banking_app/ui/screens/auth/signup/sign_up_screen.dart';
import 'package:banking_app/ui/screens/goal/add_goal_screen.dart';
import 'package:banking_app/ui/screens/goal/list_goal_screen.dart';
import 'package:banking_app/ui/screens/home/home_screen.dart';
import 'package:banking_app/ui/screens/profile/profile_screen.dart';
import 'package:banking_app/ui/screens/transaction/transaction_screen.dart';
import 'package:banking_app/ui/screens/wallet/wallet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'data/di/module.dart';
import 'ui/theme/colors.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Blitz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: schemeDark,
        useMaterial3: true,
      ),
      initialRoute: '/',
      home: AnimatedSplashScreen(
          splash: Image.asset("assets/ic_logo.png"),
          nextScreen: LoginScreen(),
          centered: true,
          splashTransition: SplashTransition.slideTransition,
          pageTransitionType: PageTransitionType.rightToLeft,
          animationDuration: Durations.extralong4,
          splashIconSize: 200,
          backgroundColor: CupertinoColors.black),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/transactions': (context) => const TransactionScreen(),
        '/wallet': (context) => const WalletScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/goals': (context) => ListGoalScreen(),
        '/goals/add': (context) => AddGoalScreen(),
      },
    );
  }
}
