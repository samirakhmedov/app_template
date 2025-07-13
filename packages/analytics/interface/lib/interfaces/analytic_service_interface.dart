/// Основная абстракция для работы с сервисом аналитики.
abstract interface class AnalyticServiceInterface {
  /// Отправить событие в сервис аналитики.
  void logEvent({required String name, Map<String, Object>? params});

  /// Отправить св-ва пользователя.
  void setUserProperty({required String name, required String value});

  /// Установить id пользователя.
  void setUserId(String userId);

  /// Инициализировать сервис аналитики.
  Future<void> init();
}
