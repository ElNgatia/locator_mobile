import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:locator_mobile/data/model/user.dart';
import 'package:locator_mobile/map/cubit/map_cubit.dart';


class MapView extends StatefulWidget {
  const MapView({required this.users, super.key});

  final List<User> users;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    context.read<MapCubit>().extractLocation(widget.users);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        if (state is MapLoaded) {
          return GoogleMap(
            markers: markers,
            onMapCreated: (controller) {
              mapController = controller;
              addMarkersToMap(state.location);
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 3,
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<Uint8List?> _getBytesFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<void> addMarkersToMap(Map<String, double>? locations) async {
    if (locations != null) {
      for (final user in widget.users) {
        final lat = double.parse(user.currentLat);
        final lon = double.parse(user.currentLon);
        final userAvatarUrl = user.avatar;

        final bytes = await _getBytesFromUrl(userAvatarUrl);

        if (bytes != null) {
          // Create a marker with the fetched image data
          final marker = Marker(
            markerId: MarkerId(user.id),
            position: LatLng(lat, lon),
            infoWindow: InfoWindow(
              title: user.name,
            ),
            icon: BitmapDescriptor.fromBytes(bytes),
          );

          setState(() {
            markers.add(marker);
          });
        }
      }
    }
  }
}
