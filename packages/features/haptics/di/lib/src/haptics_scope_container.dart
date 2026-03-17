import 'package:app_di/app_di.dart';
import 'package:app_presentation/app_presentation.dart';
import 'package:haptics_data/haptics_data.dart';
import 'package:haptics_di/src/i_haptics_scope.dart';
import 'package:haptics_domain/haptics_domain.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template haptics_scope_container}
/// A container for the haptics scope.
/// {@endtemplate}
class HapticsScopeContainer extends ChildScopeContainer<IAppScope> implements IHapticsScope {
  /// The haptics service dependency.
  late final hapticsServiceDep = rawAsyncDep<IHapticsService>(
    HapticsService.new,
    init: (service) => service.initialize(),
    dispose: (service) => service.dispose(),
  );

  /// The haptics repository dependency.
  late final hapticsRepositoryDep = dep<IHapticsRepository>(
    () => HapticsRepository(
      service: hapticsServiceDep.get,
      logger: parent.logger,
    ),
  );

  /// The haptics bloc dependency.
  late final hapticsBlocDep = rawAsyncDep<HapticsBloc>(
    () => HapticsBloc(repository: hapticsRepositoryDep.get),
    init: (bloc) async => bloc.add(const HapticsEvent.initialize()),
    dispose: (bloc) => bloc.close(),
  );

  @override
  List<Set<AsyncDepType>> get initializeQueue => [
    {hapticsServiceDep},
    {hapticsBlocDep},
  ];

  @override
  HapticsBloc get hapticsBloc => hapticsBlocDep.get;

  /// {@macro haptics_scope_container}
  HapticsScopeContainer({required super.parent});
}
