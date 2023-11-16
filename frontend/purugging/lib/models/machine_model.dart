import 'package:google_maps_flutter/google_maps_flutter.dart';

class MachineModel {
  int machine_id;
  int bag_status;
  double pet_status;
  double can_status;
  double trash_status;
  LatLng machine_location;

  MachineModel({
    required this.machine_id,
    required this.bag_status,
    required this.pet_status,
    required this.can_status,
    required this.trash_status,
    required this.machine_location,
  });
}
