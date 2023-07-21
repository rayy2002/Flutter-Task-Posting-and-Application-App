class UserDetailsModel {
  final String name;
  // final String address;
  final String isReg;
  UserDetailsModel(
      {required this.name,
      // required this.address,
      required this.isReg});

  Map<String, dynamic> getJson() => {
        'name': name,
        // 'address': address,
        'isReg': isReg
      };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      name: json["name"],
      // address: json["address"],
      isReg: json["isReg"],
    );
  }
}
