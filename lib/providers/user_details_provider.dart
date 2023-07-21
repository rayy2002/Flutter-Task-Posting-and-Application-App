import '../model/user_details_model.dart';
import '../resources/cloudfirestore_methods.dart';
import 'package:flutter/material.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(
            name: "Loading",
            // address: "Loading",
            // registred: "Loading",
            isReg: "Loading");

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
