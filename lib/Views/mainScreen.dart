import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_zaco/Controllers/HomeController.dart';
import 'package:task_zaco/Core/constants/Colors.dart';
import 'package:task_zaco/Core/constants/Strings.dart';

class MainScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final homeController = watch(getHomeController);
    homeController.calulatePrice();
    return Scaffold(
        body: homeController.pages[homeController.currentTab],
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey)),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: -30,
                    child: Container(
                      height: 70,
                      width: 70,
                      child: FloatingActionButton(
                        backgroundColor: ColorsStyle.floatbuttonColor,
                        child: Stack(
                          children: [
                            Text(
                              "\$" + "${homeController.totalCart}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Image.asset(
                              "assets/cart.png",
                              scale: 1,
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                homeController.changePages(0);
                              },
                              minWidth: 40,
                              child: Column(
                                children: [
                                  Icon(Icons.store_outlined,
                                      color: homeController.currentTab == 0
                                          ? HexColor("#D93E11")
                                          : Colors.grey),
                                  Text(
                                    Strings.grocery,
                                    style: TextStyle(
                                        color: homeController.currentTab == 0
                                            ? HexColor("#D93E11")
                                            : Colors.grey),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                homeController.changePages(0);
                              },
                              minWidth: 40,
                              child: Column(
                                children: [
                                  Icon(Icons.notifications_none_outlined,
                                      color: Colors.grey),
                                  Text(
                                    Strings.news,
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                homeController.changePages(1);
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.favorite_border_outlined,
                                      color: Colors.grey),
                                  Text(
                                    Strings.favorties,
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                homeController.changePages(1);
                              },
                              minWidth: 40,
                              child: Column(
                                children: [
                                  Icon(Icons.account_balance_wallet_outlined,
                                      color: homeController.currentTab == 1
                                          ? HexColor("#D93E11")
                                          : Colors.grey),
                                  Text(
                                    Strings.cart,
                                    style: TextStyle(
                                        color: homeController.currentTab == 1
                                            ? HexColor("#D93E11")
                                            : Colors.grey),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
