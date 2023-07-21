import 'package:flutter/material.dart';

import '../screens/showall_screen.dart';
import '../utils/color_themes.dart';
import '../utils/utils.dart';

class ProductsShowcaseVerticalListView extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ProductsShowcaseVerticalListView({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    double height = screenSize.height;
    double titleHeight = 25;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: height,
      width: screenSize.width,
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ShowallScreen();
                    }));
                  },
                  child: const Text(
                    "Show all",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: children,
            ),
          )
        ],
      ),
    );
  }
}

class ProductsShowcaseVerticalListViewForAccScreen extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ProductsShowcaseVerticalListViewForAccScreen({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    double height = screenSize.height;
    double titleHeight = 25;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: height,
      width: screenSize.width,
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight + 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: children,
            ),
          )
        ],
      ),
    );
  }
}
