import 'dart:async';
import 'dart:math';

import 'package:huawei_location/huawei_location.dart';
import 'package:location_interface/location.dart';

/// Huawei Location Service.
class LocationService implements LocationServiceInterface {
  final _locationProvider = FusedLocationProviderClient();

  @override
  Future<void> initialize() async {
    await _locationProvider.initFusedLocationService();

    /// Метод [initFusedLocationService] отрабатывает мнгновенно,
    /// но по факту инициализация не закончена,
    /// поэтому делаем задержку.
    await Future.delayed(const Duration(seconds: 1));

    await _locationProvider.setMockMode(false);
  }

  @override
  Future<Point?> getLastKnownLocation() {
    final res =
        _locationProvider.getLastLocation().timeout(kLocationRequestTimeLimit).then(_toPoint);

    return res;
  }

  @override
  Future<Point> getLocation() async {
    try {
      final status = await _locationProvider.checkLocationSettings(
        LocationSettingsRequest(
          requests: [
            LocationRequest(),
          ],
        ),
      );
      if (!status.hmsLocationUsable) {
        throw LocationPermissionNotGrantedException();
      }
      await _locationProvider.requestLocationUpdates(LocationRequest());
      final location = await _locationProvider.getLastLocation().timeout(kLocationRequestTimeLimit);

      return _toPoint(location)!;
    } on Object catch (_) {
      throw LocationPermissionNotGrantedException();
    }
  }
}

Point? _toPoint(Location position) => position.latitude == null || position.longitude == null
    ? null
    : Point(
        position.latitude!,
        position.longitude!,
      );
