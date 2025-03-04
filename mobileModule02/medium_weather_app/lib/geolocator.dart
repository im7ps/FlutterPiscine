import 'package:geolocator/geolocator.dart';
import 'package:geolocator_plugin/geolocator_plugin.dart';

Future<String> getCoordinates() async {
  // Check for location permissions
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, handle accordingly
    print('Location services are disabled.');
    return('Location services are disabled.');
  }

  // Request location permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permission
      print('Location permission denied');
      return('Location services are disabled.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Handle permission denied forever (e.g. show an error message)
    print('Location permission denied forever');
    return('Location services are disabled.');
  }

  Map<String, num> coordinates = await GeolocatorPlugin().getCoordinates();
  print("${coordinates['latitude']}\n${coordinates['longitude']}");
  String result = '${coordinates['latitude']}\n${coordinates['longitude']}';
  return result;
}
