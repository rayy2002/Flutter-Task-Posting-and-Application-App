class PostModel {
  // final String url;
  final String title;
  final String description;
  final String skills;
  final String type;
  final int inStock;
  final String fee;
  final int discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  // final int rating;
  // final int noOfRating;

  PostModel({
    // required this.url,
    required this.title,
    required this.fee,
    required this.discount,
    required this.description,
    required this.skills,
    required this.type,
    this.inStock = 1,
    required this.uid,
    required this.sellerName,
    required this.sellerUid,
    // required this.rating,
    // required this.noOfRating,
  });

  Map<String, dynamic> getJson() {
    return {
      // 'url': url,
      'title': title,
      'fee': fee,
      'description': description,
      'discount': discount,
      'skills': skills,
      'type': type,
      'inStock': inStock,
      'uid': uid,
      'sellerName': sellerName,
      'sellerUid': sellerUid,
      // 'rating': rating,
      // 'noOfRating': noOfRating,
    };
  }

  factory PostModel.getModelFromJson({required Map<String, dynamic> json}) {
    return PostModel(
      // url: json["url"],
      title: json["title"],
      fee: json["fee"],
      skills: json["skills"],
      description: json["description"],
      inStock: json["inStock"],
      type: json["type"],
      discount: json["discount"],
      uid: json["uid"],
      sellerName: json["sellerName"],
      sellerUid: json["sellerUid"],
      // rating: json["rating"],
      // noOfRating: json["noOfRating"],
    );
  }
}
