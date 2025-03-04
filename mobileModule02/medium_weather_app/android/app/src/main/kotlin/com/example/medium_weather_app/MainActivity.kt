package com.example.medium_weather_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.content.Context
import android.os.Bundle
import android.util.Log

class MainActivity: FlutterActivity() {
    private val CHANNEL = "geolocator_plugin"
    private var isRequestingLocation = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getCoordinates") {
                getCoordinates(result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getCoordinates(result: MethodChannel.Result) {
        if (isRequestingLocation) {
            result.error("ALREADY_REQUESTING", "Location request already in progress", null)
            return
        }

        isRequestingLocation = true
        val locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager

        val locationListener = object : LocationListener {
            override fun onLocationChanged(location: Location) {
                val latitude = location.latitude
                val longitude = location.longitude
                val locationMap = mapOf("latitude" to latitude, "longitude" to longitude)
                result.success(locationMap)
                locationManager.removeUpdates(this)
                isRequestingLocation = false
            }

            override fun onStatusChanged(provider: String?, status: Int, extras: Bundle?) {}
            override fun onProviderEnabled(provider: String) {}
            override fun onProviderDisabled(provider: String) {}
        }

        try {
            locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0L, 0f, locationListener)
        } catch (e: SecurityException) {
            result.error("PERMISSION_DENIED", "Location permission denied", null)
            isRequestingLocation = false
        }
    }
}