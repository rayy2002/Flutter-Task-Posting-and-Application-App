import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../model/post_model.dart';
import '../model/product_model.dart';
import '../resources/cloudfirestore_methods.dart';

// ignore: must_be_immutable
class WishlistButton extends StatefulWidget {
  PostModel postModel;
  WishlistButton({Key? key, required this.postModel}) : super(key: key);

  @override
  State<WishlistButton> createState() => _WishlistButtonState();
}

class _WishlistButtonState extends State<WishlistButton> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("wishlist")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            for (int i = 0; i < snapshot.data!.size; i++) {
              if (snapshot.data!.docs[i]['uid'] == widget.postModel.uid) {
                return GestureDetector(
                  child: const Icon(
                    Icons.bookmark,
                    color: Colors.black,
                  ),
                  onTap: () {
                    //remove from wishlist
                    CloudFirestoreClass()
                        .deleteJobFromWishlist(uid: widget.postModel.uid);
                  },
                );
              }
              continue;
            }
          }
          return GestureDetector(
            child: const Icon(
              Icons.bookmark,
              color: Color.fromARGB(255, 143, 143, 143),
            ),
            onTap: () {
              //add to wishlist
              CloudFirestoreClass()
                  .addJobToWishlist(postModel: widget.postModel);
            },
          );
        });
  }
}
