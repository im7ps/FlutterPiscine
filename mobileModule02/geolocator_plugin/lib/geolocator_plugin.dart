
import 'geolocator_plugin_platform_interface.dart';

class GeolocatorPlugin {
  Future<Map<String, num>> getCoordinates() {
    return GeolocatorPluginPlatform.instance.getCoordinates();
  }
}
