import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../providers/user_details_provider.dart';
import '../resources/cloudfirestore_methods.dart';
import '../utils/utils.dart';

// ignore: must_be_immutable
class ApplyButton extends StatefulWidget {
  PostModel postModel;
  ApplyButton({Key? key, required this.postModel}) : super(key: key);

  @override
  State<ApplyButton> createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {
  @override
  Widget build(BuildContext context) {
    // UserDetailsModel userDetailsModel =
    //     Provider.of<UserDetailsProvider>(context).userDetails;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("applied")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          for (int i = 0; i < snapshot.data!.size; i++) {
            if (snapshot.data!.docs[i]['uid'] == widget.postModel.uid) {
              return Container(
                padding: const EdgeInsets.all(10),
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "Applied",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
            continue;
          }
        }
        return GestureDetector(
          onTap: () {
            if (Provider.of<UserDetailsProvider>(context, listen: false)
                    .userDetails
                    .isReg !=
                'true') {
              Utils().showSnackBar(
                  context: context,
                  content: "Sorry you're not registered to do jobs yet");
            } else {
              CloudFirestoreClass().addProductToOrders(
                  model: widget.postModel,
                  userDetails:
                      Provider.of<UserDetailsProvider>(context, listen: false)
                          .userDetails);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 250,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(5)),
            child: const Text(
              "Apply",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        );
      },
    );
  }
}
