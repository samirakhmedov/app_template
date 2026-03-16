import 'dart:async';

import 'package:analytics_interface/analytics_plugin.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

/// Сервис аналитики для GMS.
class Analytics implements AnalyticServiceInterface {
  late final FirebaseAnalytics _instance;

  @override
  Future<void> init() async {
    _instance = FirebaseAnalytics.instance;
  }

  /// Отправить событие в Firebase.
  @override
  void logEvent({required String name, Map<String, Object>? params}) {
    unawaited(_instance.logEvent(name: name, parameters: params ?? {}));
  }

  /// Устанавливает пользовательское свойство в указанное значение.
  @override
  void setUserId(String userId) {
    unawaited(_instance.setUserId(id: userId));
  }

  /// Устанавливает пользовательское свойство в указанное значение.
  @override
  Future<void> setUserProperty({required String name, required String value}) {
    return _instance.setUserProperty(name: name, value: value);
  }
}
