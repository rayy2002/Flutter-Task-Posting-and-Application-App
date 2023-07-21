import '../model/product_model.dart';
import '../widgets/loading_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String query;
  const ResultsScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  SearchBarWidget(
                    isReadOnly: false,
                    hasBackButton: true,
                    hasLabel: false,
                    autofocus: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Showing results for ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                          TextSpan(
                            text: query,
                            style: const TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("jobs")
                        .where("title", isEqualTo: query)
                        .get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1, childAspectRatio: 2.7),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                PostModel post = PostModel.getModelFromJson(
                                    json: snapshot.data!.docs[index].data());
                                return SimplePostWidget(
                                  postModel: post,
                                );
                              }),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
