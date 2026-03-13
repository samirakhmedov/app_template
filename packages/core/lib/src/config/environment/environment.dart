import 'package:core/src/config/environment/build_type.dart';
import 'package:core/src/config/environment/mobile_services_type.dart';
import 'package:core/src/config/environment/store_type.dart';

final class Environment {
  final BuildType buildType;

  final StoreType storeType;

  final MobileServicesType mobileServicesType;

  bool get isRelease => buildType == BuildType.production;

  bool get isDevelopment => buildType == BuildType.development;

  bool get isQA => buildType == BuildType.qa;

  const Environment({
    required this.buildType,
    required this.storeType,
    required this.mobileServicesType,
  });
}
