import 'package:banking_app/domain/controller/home_controller.dart';
import 'package:banking_app/navigation.dart';
import 'package:banking_app/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/di/module.dart';
import '../../data/model/user.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final homeController = getIt<HomeController>();
  bool isLoading = true;

  @override
  void initState() {
    fetchAllUsers();
    super.initState();
  }

  Future<void> fetchAllUsers() async {
    await homeController.fetchUserData().then((value) => {
          if (value)
            {setState(() => isLoading = false)}
          else
            {setState(() => isLoading = true)}
        });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<User?>(
      valueListenable: homeController.user,
      builder: (context, user, _) {
        return Skeletonizer(
          enabled: isLoading,
          child: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            surfaceTintColor: Theme.of(context).colorScheme.background,
            centerTitle: false,
            title: Text(
              "Olá,\n${user?.name}",
              style: const TextStyle(fontSize: 18),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customIconButton(50, () {
                    navigate(context, "/profile");
                  }, Icons.person, size: 30, context)
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      children: [
                        // customIconButton(15, () {
                        //   showSnackbar(context, const Text("Search"));
                        // }, Icons.search, context),
                        Container(width: 12),
                        customIconButton(15, () {
                          showSnackbar(context, const Text("Not"));
                        }, Icons.notifications, context),
                        Container(width: 12)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class TopBarSection extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  final String title;

  const TopBarSection({
    super.key,
    required this.onBackPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      surfaceTintColor: Theme.of(context).colorScheme.background,
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onBackPressed,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
