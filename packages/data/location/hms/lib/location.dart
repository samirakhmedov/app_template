/// Location library.
library;

import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:huawei_location/huawei_location.dart';
import 'package:location_interface/location.dart';

/// Huawei (HMS) Location Service.
class Location implements LocationServiceInterface {
  /// HMS implementation of location services.
  const Location();

  @override
  Future<void> initialize() => FusedLocationProviderClient().initFusedLocationService();

  @override
  Future<Point?> getLastKnownLocation() async {
    try {
      final loc = await FusedLocationProviderClient().getLastLocation();
      final lat = loc.latitude;
      final lon = loc.longitude;
      if (lat == null || lon == null) return null;
      return Point(lat, lon);
    } on Object {
      return null;
    }
  }

  @override
  Future<Point> getLocation() => _fetchLocation();

  Future<Point> _fetchLocation() async {
    final completer = Completer<Point>();
    int? callbackId;
    try {
      final request = LocationRequest()
        ..priority = LocationRequest.PRIORITY_HIGH_ACCURACY
        ..numUpdates = 1;

      callbackId = await FusedLocationProviderClient().requestLocationUpdatesCb(
        request,
        LocationCallback(
          onLocationResult: (result) {
            final loc = result.lastLocation;
            final lat = loc?.latitude;
            final lon = loc?.longitude;
            if (lat != null && lon != null && !completer.isCompleted) {
              completer.complete(Point(lat, lon));
            }
          },
          onLocationAvailability: (_) {},
        ),
      );

      return await completer.future.timeout(kLocationRequestTimeLimit);
    } on PlatformException {
      throw const LocationPermissionNotGrantedException();
    } finally {
      if (callbackId != null) {
        unawaited(
          FusedLocationProviderClient().removeLocationUpdatesCb(callbackId),
        );
      }
    }
  }
}
