import 'dart:math';

/// Интерфейс для получения локации.
///
/// Нужен для получения текущей локации и последней известной локации.
///
/// Интерфейс нужен для разделения сервисов получения локации (например, для Huawei и Google).
///
/// Возвращает [Point] с координатами, где x - latitude, a y - longitude.
abstract interface class LocationServiceInterface {
  /// Инициализировать сервис получения локации.
  Future<void> initialize();

  /// Получить текущую локацию.
  ///
  /// При отсутствии разрешения на геолокацию бросает [LocationPermissionNotGrantedException].
  Future<Point> getLocation();

  /// Получить последнюю известную локацию.
  Future<Point?> getLastKnownLocation();
}

/// Состояние разрешения на геолокацию.
enum LocationPermissionState {
  /// Разрешение на геолокацию получено.
  granted,

  /// Разрешение на геолокацию не получено, но пользователь может его дать.
  denied,

  /// Разрешение на геолокацию не получено.
  deniedForever,
}

/// Исключение, бросаемое при отсутствии разрешения на геолокацию.
class LocationPermissionNotGrantedException implements Exception {
  /// @nodoc.
  const LocationPermissionNotGrantedException();
}

/// Исключение, бросаемое при отсутствии проверки разрешения на геолокацию.
class LocationPermissionNotCheckedException implements Exception {
  /// @nodoc.
  const LocationPermissionNotCheckedException();
}

/// Лимит на время запроса локации.
const kLocationRequestTimeLimit = Duration(seconds: 20);
