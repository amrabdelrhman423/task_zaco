import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_zaco/Controllers/HomeController.dart';
import 'package:task_zaco/Core/constants/Colors.dart';
import 'package:task_zaco/Core/constants/Datasource.dart';
import 'package:task_zaco/Core/constants/Strings.dart';
import 'package:task_zaco/Views/Widgets/Custom_appbar.dart';

class CartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final homeController = watch(getHomeController);

    homeController.calulatePrice();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              CustomAppBar(),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    Strings.cart,
                    style: TextStyle(
                        fontSize: 20,
                        color: ColorsStyle.sectionTitleColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: Datasource.cart.length,
                    itemBuilder: (context, index) => _buildItemCart(
                        Datasource.cart[index], homeController, index)),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildItemCart(cart, homecontroller, index) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: HexColor(cart["cart_color"]),
                  borderRadius: BorderRadius.circular(15)),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart["cart_title"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  cart["sub_title"],
                  style:
                      TextStyle(color: ColorsStyle.seeAllColor, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "\$" + cart["price"].toString(),
                  style: TextStyle(color: ColorsStyle.priceColor, fontSize: 16),
                )
              ],
            ),
            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    homecontroller.removeItem(index);
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration:
                          BoxDecoration(color: ColorsStyle.cartAddandRemove),
                      child: Icon(
                        cart["item_no"] == 1 ? Icons.delete : Icons.remove,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  cart["item_no"].toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    homecontroller.addItem(index);
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      decoration:
                          BoxDecoration(color: ColorsStyle.cartAddandRemove),
                      child: Icon(
                        Icons.add,
                      )),
                ),
              ],
            )
          ],
        ));
  }
}
