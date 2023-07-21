// ignore_for_file: unused_local_variable

import 'dart:typed_data';
import '../providers/user_details_provider.dart';
import '../resources/cloudfirestore_methods.dart';
import '../utils/color_themes.dart';
import '../utils/utils.dart';
import '../widgets/custom_main_button.dart';
import '../widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: duplicate_import
import '../providers/user_details_provider.dart';
import '../widgets/text_field_widget.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({Key? key}) : super(key: key);

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  bool isLoading = false;
  int selected = 2;
  Uint8List? image;
  TextEditingController titleController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  List<int> keysForDiscount = [0, 70, 60, 50];

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    costController.dispose();
    descriptionController.dispose();
    skillController.dispose();
    typeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: !isLoading
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.arrow_back,
                          size: 65,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "What job you want to get done?",
                          style: GoogleFonts.croissantOne(
                            textStyle: const TextStyle(
                              fontSize: 45,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        TextFieldWidget(
                            title: "Title",
                            controller: titleController,
                            obscureText: false,
                            hintText: "What job is to be done?"),
                        TextFieldWidget(
                            title: "About the Job",
                            controller: descriptionController,
                            obscureText: false,
                            hintText: "Describe the job"),
                        TextFieldWidget(
                            title: "Type",
                            controller: typeController,
                            obscureText: false,
                            hintText: "Is it one time or regular?"),
                        TextFieldWidget(
                            title: "Required Skills",
                            controller: skillController,
                            obscureText: false,
                            hintText: "What skills are needed to do the job"),
                        TextFieldWidget(
                            title: "Fee",
                            controller: costController,
                            obscureText: false,
                            hintText: "Budget"),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomMainButton(
                          color: Colors.black,
                          isLoading: isLoading,
                          onPressed: () async {
                            String output = await CloudFirestoreClass()
                                .uploadJobToDatabase(
                                    // image: image,
                                    title: titleController.text,
                                    fee: costController.text,
                                    discount: keysForDiscount[selected - 1],
                                    description: descriptionController.text,
                                    type: typeController.text,
                                    skills: skillController.text,
                                    sellerName:
                                        Provider.of<UserDetailsProvider>(
                                                context,
                                                listen: false)
                                            .userDetails
                                            .name,
                                    sellerUid:
                                        FirebaseAuth.instance.currentUser!.uid);
                            if (output == "success") {
                              // ignore: use_build_context_synchronously
                              Utils().showSnackBar(
                                  context: context, content: "Job Posted");
                              // ignore: use_build_context_synchronously
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            } else {
                              // ignore: use_build_context_synchronously
                              Utils().showSnackBar(
                                  context: context, content: output);
                            }
                          },
                          child: const Text(
                            "GET IT DONE",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const LoadingWidget(),
    );
  }
}
