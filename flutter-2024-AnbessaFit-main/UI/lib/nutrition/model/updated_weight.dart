class UpdatedWeightModel {
  final int weightId;
  final double weight;

  UpdatedWeightModel({
    required this.weightId,
    required this.weight,
  });

  factory UpdatedWeightModel.fromJson(Map<String, dynamic> json) {
    return UpdatedWeightModel(
      weightId: json['id'] as int, // Assuming the JSON key is 'id' for weightId
      weight: json['weight'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': weightId, // Assuming the JSON key is 'id' for weightId
      'weight': weight,
    };
  }
}
