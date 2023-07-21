import 'package:jobby/screens/post_job_screen.dart';

import '../resources/cloudfirestore_methods.dart';
import '../widgets/loading_widget.dart';
import '../widgets/products_showcase_list_view.dart';
import '../widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class ShowallScreen extends StatefulWidget {
  const ShowallScreen({Key? key}) : super(key: key);

  @override
  State<ShowallScreen> createState() => _ShowallScreenState();
}

class _ShowallScreenState extends State<ShowallScreen> {
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
    // List<Widget> temp0 = await CloudFirestoreClass().getProductsFromDiscount(0);
    List<Widget> child = await CloudFirestoreClass().getJobsFromDatabase();
    // ignore: avoid_print
    print("everything is done");
    setState(() {
      children = child;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: SearchBarWidget(
          hasBackButton: false,
          hasLabel: false,
          isReadOnly: true,
        ),
        body: children != null
            ? SizedBox(
                // height: screenSize.height,
                // width: screenSize.width,
                child: ProductsShowcaseVerticalListView(
                    title: "Popular Jobs", children: children!),
              )
            : const LoadingWidget());
  }
}
