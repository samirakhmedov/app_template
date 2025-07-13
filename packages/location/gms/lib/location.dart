import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:location_interface/location.dart';

/// Google Location Service.
class LocationService implements LocationServiceInterface {
  @override
  Future<void> initialize() => Future.value();

  @override
  Future<Point?> getLastKnownLocation() async {
    final res = await Geolocator.getLastKnownPosition().timeout(kLocationRequestTimeLimit);

    return res != null ? _toPoint(res) : null;
  }

  @override
  Future<Point> getLocation() => _fetchLocation();

  Future<Point> _fetchLocation() async {
    final res = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        timeLimit: kLocationRequestTimeLimit,
      ),
    );

    return _toPoint(res);
  }
}

Point _toPoint(Position position) => Point(
  position.latitude,
  position.longitude,
);
