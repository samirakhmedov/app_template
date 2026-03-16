import 'dart:async';

import 'package:debug_data/debug_data.dart';
import 'package:storage/storage.dart';

/// {@template debug_service}
/// A service for the debug.
/// {@endtemplate}
class DebugService implements IDebugService {
  /// The debug storage.
  final IDebugStorage _debugStorage;

  Uri? _baseUri;

  @override
  Uri? get baseUri => _baseUri;

  /// {@macro debug_service}
  DebugService({required IDebugStorage debugStorage}) : _debugStorage = debugStorage;

  @override
  Future<void> dispose() async {
    unawaited(_debugStorage.setBaseUri(_baseUri?.toString() ?? ''));
  }

  @override
  Future<void> initialize() async {
    final uri = await _debugStorage.getBaseUri();

    _baseUri = Uri.tryParse(uri ?? '');
  }

  @override
  Future<void> setBaseUri(Uri uri) async {
    await _debugStorage.setBaseUri(uri.toString());

    _baseUri = uri;
  }
}
