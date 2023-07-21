import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../utils/color_themes.dart';
import '../utils/utils.dart';
import '../widgets/custom_main_button.dart';
import '../widgets/products_showcase_list_view.dart';
import '../widgets/simple_product_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("applied")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text("No jobs applied"));
                      } else {
                        List<Widget> children = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          PostModel model = PostModel.getModelFromJson(
                              json: snapshot.data!.docs[i].data());
                          children.add(AppliedJobsWidget(postModel: model));
                        }
                        if (children.isEmpty) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Applied Jobs",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const Center(
                                child: Text("No jobs applied"),
                              )
                            ],
                          );
                        }
                        return ProductsShowcaseVerticalListViewForAccScreen(
                            title: "Applied Jobs", children: children);
                      }
                    }),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("jobs")
                        .where("sellerUid",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        // .collection("orders")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        List<Widget> children = [];
                        for (int i = 0; i < snapshot.data!.docs.length; i++) {
                          PostModel model = PostModel.getModelFromJson(
                              json: snapshot.data!.docs[i].data());
                          children.add(YourJobsWidget(postModel: model));
                        }
                        if (children.isEmpty) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: const [
                                    Text(
                                      "Your Jobs",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const Center(
                                child: Text("No jobs Posted"),
                              )
                            ],
                          );
                        }
                        return ProductsShowcaseVerticalListViewForAccScreen(
                            title: "Your Jobs", children: children);
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                    color: Colors.black,
                    isLoading: false,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
