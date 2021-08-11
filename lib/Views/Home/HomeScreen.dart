import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_zaco/Controllers/HomeController.dart';
import 'package:task_zaco/Core/constants/Colors.dart';
import 'package:task_zaco/Core/constants/Strings.dart';
import 'package:task_zaco/Model/Address.dart';
import 'package:task_zaco/Model/Category.dart';
import 'package:task_zaco/Model/Deal.dart';

import 'package:task_zaco/Views/Widgets/Custom_appbar.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final homeController = watch(getHomeController);

    if (homeController.categories.isEmpty) {
      homeController.getCategories();
    }

    if (homeController.deals.isEmpty) {
      homeController.getdeals();
    }
    if (homeController.address.isEmpty) {
      homeController.getAddress();
    }
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(),
                  _buildsearchItem(),
                  Container(
                    height: 70,
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.address.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            _buildCardAddress(
                                context, homeController.address[index]),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildCategorySection(homeController.categories),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        Strings.deals,
                        style: TextStyle(
                            color: ColorsStyle.sectionTitleColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 110,
                    child: ListView.builder(
                      itemCount: homeController.deals.length,
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            _buildDealsSections(
                                context,
                                homeController.deals[index],
                                homeController,
                                index),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: HexColor("#FEC8BD")),
                    child: Row(
                      children: [],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

Widget _buildDealsSections(
    context, Deal deal, HomeNotifier homeController, index) {
  return Column(
    children: [
      Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      color: HexColor(deal.dealColor.toString()),
                      borderRadius: BorderRadius.circular(15)),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: InkWell(
                      onTap: () => homeController.like(index),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Icon(
                            deal.like == false
                                ? Icons.favorite_border_outlined
                                : Icons.favorite,
                            color: deal.like ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  deal.dealTitle.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  deal.dealSubtitle.toString(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                    ),
                    Text(
                      deal.dealAway.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "\$" + "${deal.priceAfter}",
                      style: TextStyle(
                          color: ColorsStyle.priceColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "\$" + "${deal.priceBefor}",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}

Widget _buildCategorySection(List<Category> categories) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.exploreCategory,
            style: TextStyle(
                color: ColorsStyle.sectionTitleColor,
                fontWeight: FontWeight.bold),
          ),
          Text(
            Strings.seeAll,
            style: TextStyle(color: ColorsStyle.seeAllColor, fontSize: 12),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 110,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              HexColor(categories[index].catColor.toString())),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(categories[index].catName.toString())
                  ],
                ),
              );
            }),
      )
    ],
  );
}

Widget _buildCardAddress(context, Address addres) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.55,
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: ColorsStyle.searchbarborderColor),
        borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(15)),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addres.addressType.toString(),
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                addres.addressStreet.toString(),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              Text(
                addres.addressDetails.toString(),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget _buildsearchItem() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    child: Container(
      color: ColorsStyle.searchbarColor,
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Search in thousands of products',
            hintStyle:
                TextStyle(color: ColorsStyle.searchhintColor, fontSize: 15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(color: ColorsStyle.searchbarborderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    BorderSide(color: ColorsStyle.searchbarborderColor)),
            prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.search))),
      ),
    ),
  );
}

// class RPSCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // path_20145
//     double path_20145_xs = size.width / 375;
//     double path_20145_ys = size.height / 791;

//     Path path_20145 = Path()
//       ..moveTo(97.08 * path_20145_xs, 0 * path_20145_ys)
//       ..lineTo(17 * path_20145_xs, 0 * path_20145_ys)
//       ..cubicTo(7.61 * path_20145_xs, 0 * path_20145_ys, 0 * path_20145_xs,
//           7.61 * path_20145_ys, 0 * path_20145_xs, 17 * path_20145_ys)
//       ..cubicTo(0 * path_20145_xs, 26.39 * path_20145_ys, 7.61 * path_20145_xs,
//           34 * path_20145_ys, 17 * path_20145_xs, 34 * path_20145_ys)
//       ..lineTo(112.83 * path_20145_xs, 34 * path_20145_ys)
//       ..cubicTo(
//           118.42 * path_20145_xs,
//           34 * path_20145_ys,
//           122.95 * path_20145_xs,
//           29.47 * path_20145_ys,
//           122.95 * path_20145_xs,
//           23.88 * path_20145_ys)
//       ..cubicTo(
//           122.95 * path_20145_xs,
//           21.33 * path_20145_ys,
//           121.98 * path_20145_xs,
//           18.87 * path_20145_ys,
//           120.25 * path_20145_xs,
//           17 * path_20145_ys)
//       ..lineTo(109.55 * path_20145_xs, 5.45 * path_20145_ys)
//       ..cubicTo(
//           106.33 * path_20145_xs,
//           1.97 * path_20145_ys,
//           101.81 * path_20145_xs,
//           0 * path_20145_ys,
//           97.08 * path_20145_xs,
//           0 * path_20145_ys)
//       ..close();

//     path_20145 =
//         path_20145.shift(Offset(11 * path_20145_xs, -734 * path_20145_ys));

//     Paint path_20145_fillPaint = Paint()
//       ..style = PaintingStyle.fill
//       ..color = Color(0x0000);

//     canvas.drawPath(path_20145, path_20145_fillPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
