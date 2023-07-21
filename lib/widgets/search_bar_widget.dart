// ignore_for_file: unused_local_variable

// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobby/model/user_details_model.dart';
import 'package:provider/provider.dart';
import '../providers/user_details_provider.dart';
import '../screens/results_screen.dart';
import '../screens/search_screen.dart';
import '../utils/color_themes.dart';
import '../utils/utils.dart';

class SearchBarWidget extends StatelessWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;
  final bool hasLabel;
  final bool autofocus;
  SearchBarWidget(
      {Key? key,
      this.autofocus = false,
      required this.isReadOnly,
      required this.hasBackButton,
      required this.hasLabel})
      : preferredSize = const Size.fromHeight(84),
        super(key: key);

  @override
  final Size preferredSize;

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      color: Colors.grey.shade100,
      // width: 0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    Size screenSize = Utils().getScreenSize();
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Container(
        color: backgroundColor,
        child: Column(
          children: [
            hasLabel
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Heyy ${userDetails.name}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w100,
                                      color: Colors.grey,
                                      fontSize: 20),
                                ),
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.chat_bubble,
                                    size: 25,
                                  ),
                                )
                              ],
                            ),
                            Text("Find Your Creative Job",
                                style: GoogleFonts.croissantOne(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 50),
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                hasBackButton
                    ? IconButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        icon: const Icon(Icons.arrow_back))
                    : Container(),
                Expanded(
                  // width: screenSize.width * 0.7,
                  child: Container(
                    width: screenSize.width - 2,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        // BoxShadow(
                        //   color: Colors.black.withOpacity(0.2),
                        //   blurRadius: 8,
                        //   spreadRadius: 1,
                        //   offset: const Offset(0, 5),
                        // ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: hasBackButton
                              ? MediaQuery.of(context).size.width - 72
                              : MediaQuery.of(context).size.width - 80,
                          child: TextField(
                            cursorColor: Colors.black,
                            enabled: true,
                            // focusNode: inputNode,
                            autofocus: true,
                            onSubmitted: (String query) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ResultsScreen(query: query),
                                ),
                              );
                            },
                            readOnly: isReadOnly,
                            onTap: () {
                              if (isReadOnly) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchScreen()));
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Search For Jobs",
                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              filled: true,
                              enabledBorder: border,
                              border: border,
                              focusedBorder: border,
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        hasBackButton
                            ? Container()
                            : Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black,
                                ),
                                child: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
