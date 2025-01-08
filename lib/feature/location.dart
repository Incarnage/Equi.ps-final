import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationPicker extends StatefulWidget {
  final Function(String) onLocationSelected;

  const LocationPicker({Key? key, required this.onLocationSelected}) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LatLng? _selectedLocation;
  String _address = "Move the marker to select your location";

  void _updateAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        setState(() {
          _address = "${place.street}, ${place.locality}, ${place.administrativeArea}";
          _selectedLocation = position;
        });
      }
    } catch (e) {
      print("Error retrieving address: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick a Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(14.5995, 120.9842),
              zoom: 15,
            ),
            onTap: (position) {
              _updateAddress(position);
            },
            markers: _selectedLocation == null
                ? {}
                : {
                    Marker(
                      markerId: const MarkerId("selected-location"),
                      position: _selectedLocation!,
                      draggable: true,
                      onDragEnd: (newPosition) => _updateAddress(newPosition),
                    )
                  },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: Text(_address, textAlign: TextAlign.center),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedLocation != null) {
                      widget.onLocationSelected(_address);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Confirm Location"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
