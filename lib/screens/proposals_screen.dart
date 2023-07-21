import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/order_request_model.dart';

class ProposalScreen extends StatefulWidget {
  const ProposalScreen({Key? key}) : super(key: key);

  @override
  State<ProposalScreen> createState() => _ProposalScreenState();
}

class _ProposalScreenState extends State<ProposalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Your Proposals",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 0.7,
                        width: double.infinity,
                        color: const Color(0xFFBFBFBF),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("proposals")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text("No proposals yet"),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                ApplyModel model = ApplyModel.getModelFromJson(
                                    json: snapshot.data!.docs[index].data());
                                return ListTile(
                                  title: Text(
                                    "Job : ${model.jobName}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  onTap: () {
                                    _showMyDialog(context, model.jobberName,
                                        model.jobName);
                                  },
                                  subtitle: Text("Worker: ${model.jobberName}"),
                                  trailing: IconButton(
                                      onPressed: () async {
                                        FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("proposals")
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                      },
                                      icon: const Icon(Icons.delete)),
                                );
                              });
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showMyDialog(context, String name, String desc) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Approve Worker'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("Worker: $name"),
              Text("Description: $desc"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Approve',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
