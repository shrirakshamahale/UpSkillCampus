import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key, required String startLocation, required String destination});

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  LatLng? _startLatLng;
  LatLng? _endLatLng;

  // Corrected MITE Campus bounds restriction
  final LatLngBounds _miteCampusBounds = LatLngBounds(
    southwest: LatLng(13.0490, 74.9640), // bottom-left (Food court area)
    northeast: LatLng(13.0535, 74.9670), // top-right (GYM & Greens)
  );

  // Accurate MITE Campus location data
  final Map<String, LatLng> locations = {
    'MITE Main Entrance': LatLng(13.050689903907054, 74.96671541061446),
    'Main Block': LatLng(13.05098458113866, 74.96515323346254),
    'PG Block': LatLng(13.050110739655757, 74.96527961934655),
    'Sports Ground': LatLng(13.05121193319527, 74.96590314876343),
    'MITE GYM': LatLng(13.053030521485221, 74.96490000261377),
    'MITE Food Court': LatLng(13.049341072670144, 74.96487049830093),
    'Mechanical Block': LatLng(13.050409764290322, 74.964167759548),
    'MITE Greens': LatLng(13.051619502278417, 74.96472976054392),
    'MITE Stationary': LatLng(13.050594494848506, 74.96494928145448),
    'MITE Library': LatLng(13.051313475325378, 74.96492278755149),
    'Ganapati Temple': LatLng(13.050469133935866, 74.96573652885785),
  };

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    _markers = locations.entries.map((entry) {
      return Marker(
        markerId: MarkerId(entry.key),
        position: entry.value,
        infoWindow: InfoWindow(title: entry.key),
        onTap: () => _handleMarkerTap(entry.key, entry.value),
      );
    }).toSet();
  }

  void _handleMarkerTap(String name, LatLng tappedLatLng) {
    setState(() {
      if (_startLatLng == null || (_startLatLng != null && _endLatLng != null)) {
        _startLatLng = tappedLatLng;
        _endLatLng = null;
        _polylines.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Start location selected: $name')),
        );
      } else if (_endLatLng == null && tappedLatLng != _startLatLng) {
        _endLatLng = tappedLatLng;
        _drawRoute();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Destination selected: $name')),
        );
      }
    });
  }

  void _drawRoute() {
    if (_startLatLng != null && _endLatLng != null) {
      final Polyline polyline = Polyline(
        polylineId: const PolylineId('route_line'),
        color: Colors.blueAccent,
        width: 5,
        patterns: [PatternItem.dot],
        points: [_startLatLng!, _endLatLng!],
      );

      setState(() {
        _polylines = {polyline};
      });
    }
  }

  void _clearRoute() {
    setState(() {
      _startLatLng = null;
      _endLatLng = null;
      _polylines.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Route cleared!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    String routeTitle;
    if (_startLatLng != null && _endLatLng != null) {
      routeTitle = 'Route selected';
    } else if (_startLatLng != null) {
      routeTitle = 'Select destination';
    } else {
      routeTitle = 'Select start location';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(routeTitle),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(13.0513, 74.9657), // Center of campus (Library area)
          zoom: 18,
        ),
        markers: _markers,
        polylines: _polylines,
        mapType: MapType.satellite,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        minMaxZoomPreference: MinMaxZoomPreference(17.5, 20), // Restrict zoom
        cameraTargetBounds: CameraTargetBounds(_miteCampusBounds), // Restrict area
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearRoute,
        tooltip: 'Clear Route',
        child: const Icon(Icons.clear),
      ),
    );
  }
}
