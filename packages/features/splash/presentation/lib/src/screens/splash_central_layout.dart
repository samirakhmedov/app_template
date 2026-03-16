import 'package:app_assets/app_assets.dart';
import 'package:app_presentation/app_presentation.dart';
import 'package:common_presentation/common_presentation.dart';
import 'package:flutter/material.dart';
import 'package:splash_presentation/splash_presentation.dart';
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
    final paddingGeneral = context.appSizesScheme.paddingGeneral;

    return ShimmerComponent(
      shimmerShaderPath: AppShaders.shimmerFrag,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(context.appSizesScheme.paddingMedium),
          child: Column(
            children: <Widget>[
              Text(context.l10n.debugScreenShimmerTitle),
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
      ),
    );
  }
}
