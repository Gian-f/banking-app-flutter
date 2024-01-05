import 'package:banking_app/ui/screens/auth/login/login_screen.dart';
import 'package:banking_app/ui/screens/auth/signup/sign_up_screen.dart';
import 'package:banking_app/ui/screens/home/home_screen.dart';
import 'package:banking_app/ui/screens/profile/profile_screen.dart';
import 'package:banking_app/ui/screens/transaction/transaction_screen.dart';
import 'package:banking_app/ui/screens/wallet/wallet_screen.dart';
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
      title: 'Budget Blitz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: schemeDark,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/transactions': (context) => const TransactionScreen(),
        '/wallet': (context) => const WalletScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
