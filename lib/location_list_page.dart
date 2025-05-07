import 'package:flutter/material.dart';
import 'google_map_page.dart';

class LocationListPage extends StatefulWidget {
  const LocationListPage({super.key});

  @override
  _LocationListPageState createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  String? startLocation; // Variable to hold the selected start location
  String?
  destinationLocation; // Variable to hold the selected destination location

  final List<Map<String, dynamic>> locations = [
    {'name': 'Main Block', 'image': '', 'icon': Icons.location_on},
    {'name': 'PG Block', 'image': '', 'icon': Icons.school},
    {'name': 'Boys Hostel', 'image': '', 'icon': Icons.boy},
    {'name': 'Girls Hostel', 'image': '', 'icon': Icons.girl},
    {'name': 'Sports Ground', 'image': '', 'icon': Icons.sports_cricket},
    {'name': 'MITE GYM', 'image': '', 'icon': Icons.fitness_center},
    {'name': 'MITE Food Court', 'image': '', 'icon': Icons.fastfood},
    {'name': 'MITE Mess', 'image': '', 'icon': Icons.restaurant},
    {'name': 'Mechanical Block', 'image': '', 'icon': Icons.schedule_rounded},
    {'name': 'Parking Area', 'image': '', 'icon': Icons.local_parking},
    {'name': 'MITE Greens', 'image': '', 'icon': Icons.nature},
    {'name': 'MITE Stationary', 'image': '', 'icon': Icons.book},
    {'name': 'MITE Library', 'image': '', 'icon': Icons.library_books},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Start and Destination Locations')),
      body: Stack(
        children: [
          // Network background image
          Positioned.fill(
            child: Image.network(
              '<YOUR_IMAGE_URL>', // <-- replace with your image URL
              fit: BoxFit.cover,
            ),
          ),

          // Optional dark overlay for readability
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          // Centered content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (startLocation == null)
                    ElevatedButton(
                      onPressed: () async {
                        final selectedStartLocation = await _selectLocation(
                          context,
                        );
                        setState(() {
                          startLocation = selectedStartLocation;
                        });
                      },
                      child: Text('Select Start Location'),
                    ),
                  if (startLocation != null)
                    Text(
                      'Start Location: $startLocation',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),

                  SizedBox(height: 20),

                  if (startLocation != null && destinationLocation == null)
                    ElevatedButton(
                      onPressed: () async {
                        final selectedDestinationLocation =
                            await _selectLocation(context);
                        setState(() {
                          destinationLocation = selectedDestinationLocation;
                        });
                      },
                      child: Text('Select Destination Location'),
                    ),
                  if (destinationLocation != null)
                    Text(
                      'Destination Location: $destinationLocation',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),

                  SizedBox(height: 30),

                  if (startLocation != null && destinationLocation != null)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => GoogleMapPage(
                                  startLocation: startLocation!,
                                  destination: destinationLocation!,
                                ),
                          ),
                        );
                      },
                      child: Text('View Route on Google Map'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the location list and select a location
  Future<String?> _selectLocation(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select a Location'),
          content: SingleChildScrollView(
            child: Column(
              children:
                  locations.map((location) {
                    return ListTile(
                      title: Text(location['name']!),
                      onTap: () {
                        Navigator.pop(context, location['name']);
                      },
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }
}
