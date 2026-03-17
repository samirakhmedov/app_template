import 'package:core/src/config/environment/build_type.dart';

final class Environment {
  final BuildType buildType;

  bool get isRelease => buildType == BuildType.production;

  bool get isDevelopment => buildType == BuildType.development;

  bool get isQA => buildType == BuildType.qa;

  const Environment({required this.buildType});
}
