import 'package:app_template/core/architecture/presentation/widgets/layout.dart';
import 'package:app_template/features/common/presentation/widgets/layout/height.dart';
import 'package:app_template/features/common/presentation/widgets/layout/width.dart';
import 'package:app_template/features/common/presentation/widgets/shimmer/shimmer_block.dart';
import 'package:app_template/features/common/presentation/widgets/shimmer/shimmer_loading_component.dart';
import 'package:app_template/features/splash/presentation/screens/splash_central_component.dart';
import 'package:app_template/util/extensions/l10n.dart';
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

/// {@template splash_layout}
/// A layout for the splash.
/// {@endtemplate}
class SplashCentralLayout extends Layout<SplashViewModel> {
  /// {@macro splash_layout}
  const SplashCentralLayout({
    required super.viewModel,
    super.key,
  });

  @override
  Widget layout(SplashViewModel vm) {
    return Stack(
      children: [
        /// We place shimmer under the splash so that we avoid
        /// delay for the first fragment shader render.
        _ShimmerCard(),
        Scaffold(
          body: Center(
            child: RepaintBoundary(
              child: FadeTransition(
                opacity: vm.fadeAnimation,
                child: FlutterLogo(
                  size: 200,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final paddingGeneral = context.appSizesScheme.paddingGeneral;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.appSizesScheme.paddingMedium),
        child: Column(
          children: <Widget>[
            Text(l10n.debugScreenShimmerTitle),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShimmerLoadingComponent(
                      isLoading: true,
                      child: ShimmerBlock(width: 200, height: 50),
                    ),
                    Width(paddingGeneral),
                    ShimmerLoadingComponent(
                      isLoading: true,
                      child: ShimmerBlock(width: 50, height: 50),
                    ),
                  ],
                ),
                Height(paddingGeneral),
                ShimmerLoadingComponent(
                  isLoading: true,
                  child: ShimmerBlock(width: 300, height: 25),
                ),
                Height(paddingGeneral),
                ShimmerLoadingComponent(
                  isLoading: true,
                  child: ShimmerBlock(width: 200, height: 50),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
