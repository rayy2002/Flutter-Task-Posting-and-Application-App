import '../model/product_model.dart';
import '../utils/color_themes.dart';
import '../widgets/apply_button_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/wishlist_button.dart';

class JobScreen extends StatefulWidget {
  final PostModel postModel;
  const JobScreen({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  Expanded spaceThingy = Expanded(child: Container());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        child: const Icon(Icons.arrow_back),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.person,
                                size: 75,
                              ),
                              Text(
                                widget.postModel.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                "By ${widget.postModel.sellerName}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.currency_rupee),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.postModel.fee,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.category),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.postModel.skills,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.punch_clock),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.postModel.type,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              " -> About the job",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            widget.postModel.description,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.all(5),
                      child: WishlistButton(postModel: widget.postModel),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    ApplyButton(postModel: widget.postModel)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
