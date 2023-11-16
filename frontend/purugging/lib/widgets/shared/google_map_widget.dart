import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:purugging/services/google_map_services.dart';

class GoogleMapWidget extends StatelessWidget {
  // 생성자
  const GoogleMapWidget({
    super.key,
    this.zoom,
    required Completer<GoogleMapController> controller,
    required this.followingUser,
    required this.startPosition,
    required this.polylines,
    required this.markers,
  }) : _controller = controller;

  // 인자
  final Completer<GoogleMapController> _controller;
  final LatLng startPosition;
  final bool followingUser;
  final double? zoom;
  final Set<Polyline> polylines;
  final List<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: startPosition, zoom: zoom == null? GoogleMapServices.basicZoom : zoom!),
      mapType: MapType.normal,
      myLocationEnabled: followingUser,
      myLocationButtonEnabled: followingUser,
      polylines: polylines,
      markers: Set.from(markers),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}