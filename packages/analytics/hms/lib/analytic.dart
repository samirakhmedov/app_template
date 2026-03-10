import 'dart:async';

import 'package:analytics_interface/analytics_plugin.dart';
import 'package:huawei_analytics/huawei_analytics.dart';

/// Пример реализации Пакета для HMS.
class Analytic implements AnalyticServiceInterface {
  /// Экземпляр аналитики Firebasae.
  late HMSAnalytics _instance;

  @override
  Future<void> init() async {
    _instance = await HMSAnalytics.getInstance();

    return _instance.enableLog();
  }

  /// Отправить событие в Firebase.
  @override
  void logEvent({required String name, Map<String, Object>? params}) {
    unawaited(_instance.onEvent(name, params ?? {}));
  }

  /// Устанавливает пользовательское свойство в указанное значение.
  @override
  void setUserId(String userId) {
    unawaited(_instance.setUserId(userId));
  }

  /// Устанавливает пользовательское свойство в указанное значение.
  @override
  Future<void> setUserProperty({required String name, required String value}) {
    return _instance.addDefaultEventParams({'name': name, 'value': value});
  }
}
