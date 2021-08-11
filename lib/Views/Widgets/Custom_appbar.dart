import 'package:flutter/material.dart';
import 'package:task_zaco/Core/constants/Strings.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 50,
          width: 130,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/shape1.png"))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              Text(
                Strings.mustafaSt,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              border: Border.all(width: 1, color: Colors.black)),
        ),
      ],
    );
  }
}
