import 'package:analytics_interface/analytics_plugin.dart';

/// Базовый сервис аналитики.
class BaseAnalyticService implements AnalyticServiceInterface {
  /// Сервисы аналитики.
  final Set<AnalyticServiceInterface> services;

  /// Конструктор сервиса аналитики.
  BaseAnalyticService({required this.services});

  @override
  Future<void> init() => Future.wait(services.map((e) => e.init()));

  @override
  void logEvent({required String name, Map<String, Object>? params}) {
    for (final service in services) {
      service.logEvent(name: name, params: params);
    }
  }

  @override
  void setUserId(String userId) {
    for (final service in services) {
      service.setUserId(userId);
    }
  }

  @override
  void setUserProperty({required String name, required String value}) {
    for (final service in services) {
      service.setUserProperty(name: name, value: value);
    }
  }
}
