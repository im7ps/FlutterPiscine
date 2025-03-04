import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'geolocator_plugin_platform_interface.dart';

/// An implementation of [GeolocatorPluginPlatform] that uses method channels.
class MethodChannelGeolocatorPlugin extends GeolocatorPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('geolocator_plugin');

  @override
  Future<Map<String, num>> getCoordinates() async {
    print("miao miao");
    try {
      final Map<dynamic, dynamic> result = await methodChannel.invokeMethod('getCoordinates');
      print(result);
      Map<String, num> coordinates = {
            'latitude': result['latitude'],
            'longitude': result['longitude'],
          };
      print(coordinates);
      return coordinates;
    } 
    on PlatformException catch (e) {
      throw 'Error getting location: ${e.message}';
    }
  }
}

