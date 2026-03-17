import 'package:core/src/config/environment/build_type.dart';
import 'package:core/src/config/environment/environment.dart';
import 'package:core/src/config/environment/raw_environment.dart';
import 'package:core/src/config/environment/registrar/environment_registrar.dart';

class BaseEnvironmentRegistrar implements EnvironmentRegistrar {
  final RawEnvironment rawEnvironment;

  const BaseEnvironmentRegistrar({required this.rawEnvironment});

  @override
  Environment build() => Environment(buildType: _buildType());

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
}

abstract interface class _EnvironmentConstants {
  static const developmentFlavor = 'dev';
  static const qaFlavor = 'qa';
}
