import 'package:flutter/material.dart';
import 'package:locator_mobile/home/home.dart';


class RootLayout extends StatefulWidget {
  const RootLayout({super.key});

  @override
  State<RootLayout> createState() => _RootLayoutState();
}

class _RootLayoutState extends State<RootLayout> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<Widget> _screens = [
    const HomePage(),
    // const Driving(),
    // const Safety(),
    // const Chat(),
    // const ProfilePage(userId: null,),
  ];

  void onScreenChanged(int index) {
    setState(() {
      // BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _rootLayoutBody(),
      bottomNavigationBar: _rootLayoutBottomNavBar(context),
    );
  }

PageView _rootLayoutBody() {
    return PageView(
      controller: pageController,
      onPageChanged: onScreenChanged,
      children: _screens,
    );
  }

BottomAppBar _rootLayoutBottomNavBar(BuildContext context) {
  return BottomAppBar(
    color: Colors.white,
    shape: const CircularNotchedRectangle(),
    child: ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _bottomAppBarItem(
                  context,
                  label: 'Location',
                  icon: Icons.location_on,
                  selectedIcon: Icons.location_on_outlined,
                  screen: 0,
                ),
                _bottomAppBarItem(
                  context,
                  label: 'Driving',
                  icon: Icons.directions_car_outlined,
                  selectedIcon: Icons.directions_car,
                  screen: 1,
                ),
                _bottomAppBarItem(
                  context,
                  label: 'Safety',
                  icon: Icons.safety_divider_outlined,
                  selectedIcon: Icons.safety_divider,
                  screen: 2,
                ),
                _bottomAppBarItem(
                  context,
                  label: 'Chat',
                  icon: Icons.chat_outlined,
                  selectedIcon: Icons.chat,
                  screen: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _bottomAppBarItem(
    BuildContext context, {
    required String label,
    required IconData icon,
    required IconData selectedIcon,
    required int screen,
  }) {
    return GestureDetector(
      onTap: () {
        // BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(screen);

        pageController.animateToPage(
          screen,
          duration: const Duration(milliseconds: 10),
          curve: Curves.fastLinearToSlowEaseIn,
        );
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 30,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
