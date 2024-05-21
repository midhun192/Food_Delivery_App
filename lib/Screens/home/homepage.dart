import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/cart/cart_hisory.dart';
import 'package:food_delivery_app/Screens/home/main_food_page.dart';
import 'package:food_delivery_app/utils/Colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selectedIndex = 0;
  // List pages = [
  //   MainFoodPage(),
  //   Container(child: Center(child: Text("Page 2"))),
  //   Container(child: Center(child: Text("Page 3"))),
  //   Container(child: Center(child: Text("Page 4"))),
  // ];

  // void onNavTap(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onNavTap,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.archive,
              ),
              label: "History"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "User"),
        ],
      ),
    );
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        tabs: [
          PersistentTabConfig(
            screen: const MainFoodPage(),
            item: ItemConfig(
              icon: Icon(Icons.home),
              activeForegroundColor: AppColors.mainColor,
              inactiveForegroundColor: Colors.amberAccent,
              title: "Home",
            ),
          ),
          PersistentTabConfig(
            screen: Container(child: Center(child: Text("Page 3"))),
            item: ItemConfig(
              icon: Icon(Icons.archive),
              activeForegroundColor: AppColors.mainColor,
              inactiveForegroundColor: Colors.amberAccent,
              title: "History",
            ),
          ),
          PersistentTabConfig(
            screen: const CartHistory(),
            item: ItemConfig(
              icon: Icon(Icons.shopping_cart),
              activeForegroundColor: AppColors.mainColor,
              inactiveForegroundColor: Colors.amberAccent,
              title: "Cart",
            ),
          ),
          PersistentTabConfig(
            screen: Container(child: Center(child: Text("Page 3"))),
            item: ItemConfig(
              icon: Icon(Icons.person),
              activeForegroundColor: AppColors.mainColor,
              inactiveForegroundColor: Colors.amberAccent,
              title: "Me",
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style8BottomNavBar(
          navBarConfig: navBarConfig,
        ),
      ),
    );
  }
}
