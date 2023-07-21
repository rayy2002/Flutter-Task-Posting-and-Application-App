class ApplyModel {
  final String jobName;
  final String jobberName;

  ApplyModel({
    required this.jobName,
    required this.jobberName,
  });

  Map<String, dynamic> getJson() => {
        'jobName': jobName,
        'jobberName': jobberName,
      };

  factory ApplyModel.getModelFromJson({required Map<String, dynamic> json}) {
    return ApplyModel(jobName: json["jobName"], jobberName: json["jobberName"]);
  }
}
