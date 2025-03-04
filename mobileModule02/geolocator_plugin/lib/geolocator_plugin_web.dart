// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'dart:async';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'geolocator_plugin_platform_interface.dart';
import 'dart:html' as web;

class GeolocatorPluginWeb extends GeolocatorPluginPlatform {
  /// Constructs a GeolocatorPluginWeb
  GeolocatorPluginWeb();

  static void registerWith(Registrar registrar) {
    GeolocatorPluginPlatform.instance = GeolocatorPluginWeb();
  }

  @override
  Future<Map<String, num>> getCoordinates() async {
    final geolocation = web.window.navigator.geolocation;

    // Use a Completer to handle async operation
    final completer = Completer<Map<String, num>>();

    // Get current position
    geolocation.getCurrentPosition().then((position) {
      // Create a map with latitude and longitude
      final coordinates = {
        'latitude': position.coords?.latitude ?? 0,
        'longitude': position.coords?.longitude ?? 0,
      };

      // Complete the future with the coordinates
      completer.complete(coordinates);
    }).catchError((error) {
      // Handle error if unable to retrieve geolocation
      completer.completeError('Failed to get geolocation: $error');
    });

    // Return the future
    return completer.future;
  }
}