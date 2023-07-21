import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_details_provider.dart';
import '../resources/cloudfirestore_methods.dart';
import '../utils/constants.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  changePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    CloudFirestoreClass().getNameAndAddress();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailsProvider>(context).getData();
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[400]!, width: 1),
              ),
            ),
            child: TabBar(
              indicator: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black, width: 4),
                ),
              ),
              onTap: changePage,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Icon(
                    Icons.home_outlined,
                    color:
                        currentPage == 0 ? Colors.black : Colors.grey.shade500,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.card_travel_outlined,
                    color:
                        currentPage == 1 ? Colors.black : Colors.grey.shade500,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.bookmark_border_outlined,
                    color:
                        currentPage == 2 ? Colors.black : Colors.grey.shade500,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.account_circle_outlined,
                    color:
                        currentPage == 3 ? Colors.black : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
