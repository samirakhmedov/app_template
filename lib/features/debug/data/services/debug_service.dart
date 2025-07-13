import 'dart:async';

import 'package:app_template/features/debug/data/services/i_debug_service.dart';
import 'package:flutter/foundation.dart';
import 'package:storage/storage.dart';

/// {@template debug_service}
/// A service for the debug.
/// {@endtemplate}
class DebugService implements IDebugService {
  /// The debug storage.
  final IDebugStorage _debugStorage;

  final _baseUri = ValueNotifier<Uri?>(null);

  @override
  ValueListenable<Uri?> get baseUri => _baseUri;

  /// {@macro debug_service}
  DebugService({required IDebugStorage debugStorage}) : _debugStorage = debugStorage;

  @override
  Future<void> dispose() async {
    unawaited(_debugStorage.setBaseUri(_baseUri.value?.toString() ?? ''));

    _baseUri.dispose();
  }

  @override
  Future<void> initialize() async {
    final uri = await _debugStorage.getBaseUri();

    _baseUri.value = Uri.tryParse(uri ?? '');
  }

  @override
  Future<void> setBaseUri(Uri uri) async {
    await _debugStorage.setBaseUri(uri.toString());

    _baseUri.value = uri;
  }
}
