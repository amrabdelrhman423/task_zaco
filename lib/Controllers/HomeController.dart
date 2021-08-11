import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_zaco/Core/constants/Datasource.dart';
import 'package:task_zaco/Model/Address.dart';
import 'package:task_zaco/Model/Category.dart';
import 'package:task_zaco/Model/Deal.dart';
import 'package:task_zaco/Views/Cart/CartScreen.dart';
import 'package:task_zaco/Views/Home/HomeScreen.dart';

ChangeNotifierProvider<HomeNotifier> getHomeController =
    ChangeNotifierProvider<HomeNotifier>(
  (_) => HomeNotifier(),
);

class HomeNotifier extends ChangeNotifier {
  List<Category> categories = [];
  List<Deal> deals = [];
  List<Address> address = [];

  int currentTab = 0;
  List<Widget> pages = [
    HomeScreen(),
    CartScreen(),
  ];
  Widget currentScreen = HomeScreen();
  getCategories() {
    for (int i = 0; i < Datasource.categories.length; i++) {
      Category item = Category.fromJson(Datasource.categories[i]);
      if (categories.length < Datasource.categories.length) {
        categories.add(item);
      }
    }
    print(categories);
    notifyListeners();
  }

  int totalCart = 0;

  calulatePrice() {
    if (totalCart == 0) {
      for (int i = 0; i < Datasource.cart.length; i++) {
        int item = Datasource.cart[i]["price"] * Datasource.cart[i]["item_no"];
        totalCart = totalCart + item;
      }
    }
    print(totalCart);
    notifyListeners();
  }

  getdeals() {
    for (int i = 0; i < Datasource.deals.length; i++) {
      Deal item = Deal.fromJson(Datasource.deals[i]);
      if (deals.length < Datasource.deals.length) {
        deals.add(item);
      }
    }
    print(deals);
    notifyListeners();
  }

  getAddress() {
    for (int i = 0; i < Datasource.addresses.length; i++) {
      Address item = Address.fromJson(Datasource.addresses[i]);
      if (deals.length < Datasource.addresses.length) {
        address.add(item);
      }
    }
    print(address);
    notifyListeners();
  }

  addItem(int index) {
    Datasource.cart[index]["item_no"]++;
    int price = Datasource.cart[index]["price"];
    totalCart = totalCart + price;
    notifyListeners();
  }

  removeItem(int index) {
    if (Datasource.cart[index]["item_no"] == 1) {
      int price = Datasource.cart[index]["price"];
      totalCart = totalCart - price;
      Datasource.cart.remove(Datasource.cart[index]);
      notifyListeners();
    } else {
      Datasource.cart[index]["item_no"]--;
      int price = Datasource.cart[index]["price"];
      totalCart = totalCart - price;
      notifyListeners();
    }
  }

  like(index) {
    deals[index].like = !deals[index].like;
    notifyListeners();
  }

  changePages(int index) {
    currentScreen = pages[index];
    currentTab = index;
    notifyListeners();
  }
}
