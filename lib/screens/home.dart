import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:to_do_notes/screens/notes.dart';
import 'package:to_do_notes/screens/profile.dart';
import 'package:to_do_notes/screens/to_do.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller =
        PersistentTabController(initialIndex: 0);

    List<Widget> buildScreen() {
      return const [
        ToDo(),
        Notes(),
        Profile(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarItem() {
      return [
        PersistentBottomNavBarItem(
          icon: const ImageIcon(
            AssetImage('images/to-do-blue.png'),
          ),
          inactiveIcon: const ImageIcon(
            AssetImage('images/to-do.png'),
          ),
          title: ('To Do'),
        ),
        PersistentBottomNavBarItem(
          icon: const ImageIcon(
            AssetImage('images/notes-blue.png'),
          ),
          inactiveIcon: const ImageIcon(
            AssetImage('images/notes.png'),
          ),
          title: ('Notes'),
        ),
        PersistentBottomNavBarItem(
          icon: const ImageIcon(
            AssetImage('images/profile-blue.png'),
            size: 32,
          ),
          inactiveIcon: const ImageIcon(
            AssetImage('images/profile.png'),
          ),
          title: ('Profile'),
        ),
      ];
    }

    return Scaffold(
      body: SafeArea(
        child: PersistentTabView(
          context,
          controller: controller,
          screens: buildScreen(),
          items: navBarItem(),
          confineInSafeArea: true,
          backgroundColor: const Color(0xFFD9E2FF),
          navBarStyle: NavBarStyle.style1,
          popAllScreensOnTapAnyTabs: true,
        ),
      ),
    );
  }
}
