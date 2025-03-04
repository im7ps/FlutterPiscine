import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'geolocator_plugin_method_channel.dart';

abstract class GeolocatorPluginPlatform extends PlatformInterface {
  /// Constructs a GeolocatorPluginPlatform.
  GeolocatorPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static GeolocatorPluginPlatform _instance = MethodChannelGeolocatorPlugin();

  /// The default instance of [GeolocatorPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelGeolocatorPlugin].
  static GeolocatorPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GeolocatorPluginPlatform] when
  /// they register themselves.
  static set instance(GeolocatorPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<String, num>> getCoordinates() {
    throw UnimplementedError('getCoordinates() has not been implemented.');
  }
}
