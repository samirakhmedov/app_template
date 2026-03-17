// ignore_for_file: avoid-passing-async-when-sync-expected

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:debug_domain/debug_domain.dart';
import 'package:debug_presentation/debug_presentation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:surf_widget_test_composer/surf_widget_test_composer.dart';
import 'package:uikit/uikit.dart';

class MockDebugViewModel extends Mock implements DebugViewModel {}

class MockDebugBloc extends Mock implements StateStreamable<DebugState> {}

void main() {
  late final DebugViewModel mockDebugViewModel;
  late final StateStreamable<DebugState> mockDebugBloc;

  setUpAll(() {
    mockDebugBloc = MockDebugBloc();
    mockDebugViewModel = MockDebugViewModel();

    registerFallbackValue(Urls.release);

    when(() => mockDebugViewModel.debugBloc).thenReturn(mockDebugBloc);
    when(() => mockDebugViewModel.setBaseUri(any<Urls?>())).thenReturn(null);
    when(mockDebugViewModel.openEasterEgg).thenReturn(null);
  });

  group('Debug Screen Tests', () {
    testWidget(
      widgetBuilder: (_, _) => DebugLayout(viewModel: mockDebugViewModel),
      desc: 'Debug Screen - Release URL',
      setup: (ctx, _) {
        when(() => mockDebugViewModel.sizes).thenReturn(ctx.appSizesScheme);
        when(() => mockDebugViewModel.text).thenReturn(ctx.appTextScheme);
        when(() => mockDebugViewModel.colors).thenReturn(ctx.appColorScheme);
        when(
          () => mockDebugBloc.stream,
        ).thenAnswer((_) => Stream.value(DebugState(baseUrl: Urls.release)));
        when(() => mockDebugBloc.state).thenReturn(DebugState(baseUrl: Urls.release));
        when(() => mockDebugViewModel.easterEgg).thenReturn('Release URL has been chosen!');
      },
      screenState: 'release',
    );

    testWidget(
      widgetBuilder: (_, _) => DebugLayout(viewModel: mockDebugViewModel),
      desc: 'Debug Screen - Debug URL',
      setup: (ctx, _) {
        when(() => mockDebugViewModel.sizes).thenReturn(ctx.appSizesScheme);
        when(() => mockDebugViewModel.text).thenReturn(ctx.appTextScheme);
        when(() => mockDebugViewModel.colors).thenReturn(ctx.appColorScheme);
        when(
          () => mockDebugBloc.stream,
        ).thenAnswer((_) => Stream.value(DebugState(baseUrl: Urls.development)));
        when(() => mockDebugBloc.state).thenReturn(DebugState(baseUrl: Urls.development));
        when(() => mockDebugViewModel.easterEgg).thenReturn('Debug URL has been chosen!');
      },
      screenState: 'debug',
    );
  });
}
