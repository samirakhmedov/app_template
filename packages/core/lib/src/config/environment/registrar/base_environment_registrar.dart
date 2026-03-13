import 'package:core/src/config/environment/build_type.dart';
import 'package:core/src/config/environment/environment.dart';
import 'package:core/src/config/environment/mobile_services_type.dart';
import 'package:core/src/config/environment/raw_environment.dart';
import 'package:core/src/config/environment/registrar/environment_registrar.dart';
import 'package:core/src/config/environment/store_type.dart';

class BaseEnvironmentRegistrar implements EnvironmentRegistrar {
  final RawEnvironment rawEnvironment;

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
