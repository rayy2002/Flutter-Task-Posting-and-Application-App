import 'package:jobby/screens/post_job_screen.dart';

import '../resources/cloudfirestore_methods.dart';
import '../utils/utils.dart';
import '../widgets/loading_widget.dart';
import '../widgets/products_showcase_list_view.dart';
import '../widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? children;

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<Widget> child = await CloudFirestoreClass().getJobsFromDatabase();
    // ignore: avoid_print
    print("everything is done");
    setState(() {
      children = child;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          elevation: 3,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const PostJobScreen();
            }));
          },
          child: const Icon(Icons.add),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(275),
          child: SearchBarWidget(
            hasBackButton: false,
            hasLabel: true,
            isReadOnly: true,
          ),
        ),
        body: children != null
            ? SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: ProductsShowcaseVerticalListView(
                    title: "Popular Jobs", children: children!),
              )
            : const LoadingWidget());
  }
}
