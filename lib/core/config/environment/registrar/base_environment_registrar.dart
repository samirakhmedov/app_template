import 'package:app_template/core/config/environment/build_type.dart';
import 'package:app_template/core/config/environment/environment.dart';
import 'package:app_template/core/config/environment/mobile_services_type.dart';
import 'package:app_template/core/config/environment/raw_environment.dart';
import 'package:app_template/core/config/environment/registrar/environment_registrar.dart';
import 'package:app_template/core/config/environment/store_type.dart';

/// {@template base_environment_registrar}
/// A base environment registrar.
/// {@endtemplate}
class BaseEnvironmentRegistrar implements EnvironmentRegistrar {
  /// The raw environment.
  final RawEnvironment rawEnvironment;

  /// {@macro base_environment_registrar}
  const BaseEnvironmentRegistrar({required this.rawEnvironment});

  @override
  Environment build() {
    final buildType = _buildType();
    final storeType = _storeType();
    final mobileServicesType = _mobileServicesType();

    return Environment(
      buildType: buildType,
      storeType: storeType,
      mobileServicesType: mobileServicesType,
    );
  }

  BuildType _buildType() {
    final flavor = rawEnvironment.appFlavor.toLowerCase();

    if (flavor.contains(_EnvironmentConstants.developmentFlavor)) {
      return BuildType.development;
    }

    if (flavor.contains(_EnvironmentConstants.qaFlavor)) {
      return BuildType.qa;
    }

    return BuildType.production;
  }

  StoreType _storeType() {
    final storeType = rawEnvironment.storeType.toLowerCase();

    if (storeType.contains(_EnvironmentConstants.rustoreStoreType)) {
      return StoreType.rustore;
    }

    if (storeType.contains(_EnvironmentConstants.appgalleryStoreType)) {
      return StoreType.appgallery;
    }

    return StoreType.legacy;
  }

  MobileServicesType _mobileServicesType() {
    final flavor = rawEnvironment.appFlavor.toLowerCase();

    if (flavor.contains(_EnvironmentConstants.hmsFlavor)) {
      return MobileServicesType.hms;
    }

    return MobileServicesType.gms;
  }
}

abstract interface class _EnvironmentConstants {
  static const developmentFlavor = 'dev';
  static const qaFlavor = 'qa';
  static const hmsFlavor = 'hms';
  static const rustoreStoreType = 'rustore';
  static const appgalleryStoreType = 'appgallery';
}
