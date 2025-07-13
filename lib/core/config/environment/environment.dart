import 'package:app_template/core/config/environment/build_type.dart';
import 'package:app_template/core/config/environment/mobile_services_type.dart';
import 'package:app_template/core/config/environment/store_type.dart';

/// {@template environment}
/// The environment.
/// {@endtemplate}
final class Environment {
  /// The build type.
  final BuildType buildType;

  /// The store type.
  final StoreType storeType;

  /// The mobile services type.
  final MobileServicesType mobileServicesType;

  /// Returns `true` if the build type is [BuildType.production].
  bool get isRelease => buildType == BuildType.production;

  /// Returns `true` if the build type is [BuildType.development].
  bool get isDevelopment => buildType == BuildType.development;

  /// Returns `true` if the build type is [BuildType.qa].
  bool get isQA => buildType == BuildType.qa;

  /// {@macro environment}
  const Environment({
    required this.buildType,
    required this.storeType,
    required this.mobileServicesType,
  });
}
