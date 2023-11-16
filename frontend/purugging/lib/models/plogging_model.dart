class PloggingModel {
  final int plogging_id, member_id, start_machine_id, end_machine_id;
  final DateTime created_at, updated_at;
  final int distance, pet_count, can_count;
  final double general_trash_weight;
  final Duration ploggingTime;
  final String? plogging_image;

  PloggingModel({
    required this.plogging_id,
    required this.member_id,
    required this.start_machine_id,
    required this.end_machine_id,
    required this.created_at,
    required this.updated_at,
    required this.distance,
    required this.pet_count,
    required this.can_count,
    required this.general_trash_weight,
    this.plogging_image,
  }) : ploggingTime = updated_at.difference(created_at);
}
