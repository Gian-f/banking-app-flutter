import 'package:banking_app/navigation.dart';
import 'package:banking_app/ui/screens/profile/profile_screen.dart';
import 'package:banking_app/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      title: const Text(
        "Olá,\nGian Felipe da Silva",
        style: TextStyle(fontSize: 16),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          customIconButton(50, () {
            navigate(context, const ProfileScreen());
          }, Icons.person, size: 30, context)
        ]),
      ),
      actions: [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    customIconButton(15, () {
                      showSnackbar(context, const Text("Search"));
                    }, Icons.search, context),
                    Container(width: 12),
                    customIconButton(15, () {
                      showSnackbar(context, const Text("Not"));
                    }, Icons.notifications, context),
                    Container(width: 12)
                  ],
                )),
          ],
        )
      ],
    );
  }
}
