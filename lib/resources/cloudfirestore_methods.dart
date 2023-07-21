import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/order_request_model.dart';
import '../model/product_model.dart';
import '../model/user_details_model.dart';
import '../utils/utils.dart';
import '../widgets/simple_product_widget.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadPerDataToDatabase({required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
      (snap.data() as dynamic),
    );

    return userModel;
  }

  Future<String> uploadJobToDatabase({
    required String title,
    required String description,
    required String skills,
    required String fee,
    required int discount,
    required String type,
    int inStock = 1,
    required String sellerName,
    required String sellerUid,
  }) async {
    title.trim();
    String output = "Something went wrong";

    if (title != "" && fee != "") {
      try {
        String uid = Utils().getUid();
        fee = fee;
        PostModel product = PostModel(
          title: title,
          description: description,
          skills: skills,
          fee: fee,
          type: type,
          inStock: inStock,
          discount: discount,
          uid: uid,
          sellerName: sellerName,
          sellerUid: sellerUid,
        );

        await firebaseFirestore
            .collection("jobs")
            .doc(uid)
            .set(product.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields are not empty";
    }

    return output;
  }

  Future<List<Widget>> getJobsFromDatabase() async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap =
        await firebaseFirestore.collection("jobs").get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      PostModel model =
          PostModel.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(SimplePostWidget(postModel: model));
    }
    return children;
  }

  Future addJobToWishlist({required PostModel postModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("wishlist")
        .doc(postModel.uid)
        .set(postModel.getJson());
  }

  Future deleteJobFromWishlist({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("wishlist")
        .doc(uid)
        .delete();
  }

  Future addProductToOrders({
    required PostModel model,
    required UserDetailsModel userDetails,
  }) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("applied")
        .add(model.getJson());
    await sendProposal(
      model: model,
      userDetails: userDetails,
    );
  }

  Future sendProposal({
    required PostModel model,
    required UserDetailsModel userDetails,
  }) async {
    ApplyModel applyModel =
        ApplyModel(jobName: model.title, jobberName: userDetails.name);
    await firebaseFirestore
        .collection("users")
        .doc(model.sellerUid)
        .collection("proposals")
        .add(applyModel.getJson());
  }
}
