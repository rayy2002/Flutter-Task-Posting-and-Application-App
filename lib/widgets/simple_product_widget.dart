import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobby/screens/job_screen.dart';
import 'package:jobby/widgets/custom_main_button.dart';
import 'package:jobby/widgets/wishlist_button.dart';

import '../model/product_model.dart';

class SimplePostWidget extends StatelessWidget {
  final PostModel postModel;
  const SimplePostWidget({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JobScreen(postModel: postModel)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          // color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postModel.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Row(
                      children: [
                        Text("₹${postModel.fee}"),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          // margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.shade100,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(postModel.type),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          postModel.sellerName.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    WishlistButton(postModel: postModel),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    CustomMainButton(
                        color: Colors.black,
                        isLoading: false,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      JobScreen(postModel: postModel)));
                        },
                        child: const Text("Apply Now >"))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class YourJobsWidget extends StatelessWidget {
  final PostModel postModel;
  const YourJobsWidget({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        // color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postModel.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("₹${postModel.fee}"),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        // margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade100,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(postModel.type),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              GestureDetector(
                child: const Icon(Icons.delete),
                onTap: () async {
                  var collection = FirebaseFirestore.instance
                      .collection('jobs')
                      .where("sellerUid",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where("title", isEqualTo: postModel.title);
                  var snapshots = await collection.get();
                  for (var doc in snapshots.docs) {
                    await doc.reference.delete();
                  }

                  var coll = FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("proposals")
                      .where("jobName", isEqualTo: postModel.title);
                  var snappy = await coll.get();
                  for (var doc in snappy.docs) {
                    await doc.reference.delete();
                  }

                  var colle = FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("applied")
                      .where("title", isEqualTo: postModel.title);
                  var snap = await colle.get();
                  for (var doc in snap.docs) {
                    await doc.reference.delete();
                  }

                  var collec = FirebaseFirestore.instance
                      .collection('users')
                      .doc(postModel.sellerUid)
                      .collection("proposals")
                      .where("jobName", isEqualTo: postModel.title);
                  var snaps = await collec.get();
                  for (var doc in snaps.docs) {
                    await doc.reference.delete();
                  }
                },
              )
              // const SizedBox(
              //   height: 15,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppliedJobsWidget extends StatelessWidget {
  final PostModel postModel;
  const AppliedJobsWidget({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        // color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postModel.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("₹${postModel.fee}"),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        // margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade100,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(postModel.type),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              GestureDetector(
                child: const Icon(Icons.delete),
                onTap: () async {
                  var colle = FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("applied")
                      .where("title", isEqualTo: postModel.title);
                  var snap = await colle.get();
                  for (var doc in snap.docs) {
                    await doc.reference.delete();
                  }

                  var collec = FirebaseFirestore.instance
                      .collection('users')
                      .doc(postModel.sellerUid)
                      .collection("proposals")
                      .where("jobName", isEqualTo: postModel.title);
                  var snaps = await collec.get();
                  for (var doc in snaps.docs) {
                    await doc.reference.delete();
                  }
                },
              )
              // const SizedBox(
              //   height: 15,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
