import 'package:app_assets/app_assets.dart';
import 'package:app_presentation/app_presentation.dart';
import 'package:common_presentation/common_presentation.dart';
import 'package:core/core.dart';
import 'package:debug_domain/debug_domain.dart';
import 'package:debug_presentation/debug_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptics_presentation/haptics_presentation.dart';
import 'package:uikit/uikit.dart';

/// {@template debug_layout}
/// A layout for the debug screen.
/// {@endtemplate}
class DebugLayout extends Layout<DebugViewModel> {
  /// {@macro debug_layout}
  const DebugLayout({
    required super.viewModel,
    super.key,
  });

  @override
  Widget layout(DebugViewModel vm) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const TemplateBackgroundWidget(),
          ShimmerComponent(
            shimmerShaderPath: AppShaders.shimmerFrag,
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.all(vm.sizes.paddingMedium),
                children: [
                  Text(
                    vm.easterEgg,
                    style: vm.text.headline,
                  ),
                  Height(vm.sizes.paddingGeneral),
                  _ServerSwitchCard(
                    debugBloc: vm.debugBloc,
                    onUrlRadioButtonPressed: vm.setBaseUri,
                  ),
                  const _HapticFeedbackCard(),
                  const _ShimmerCard(),
                  const _ShimmerCard(),
                  _EasterEggButton(vm: vm),
                  const _SnackQueueButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SnackQueueButton extends StatelessWidget {
  const _SnackQueueButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.appSizesScheme.paddingMedium),
        child: AppPrimaryButton(
          onPressed: () => SnackQueueComponent.of(context).addSnack(
            l10n.debugScreenSnackTestMessage,
            messageType: SnackMessageType.success,
          ),
          size: .small,
          child: Text(l10n.debugScreenSnackQueueTestButton),
        ),
      ),
    );
  }
}

class _EasterEggButton extends StatelessWidget {
  const _EasterEggButton({required this.vm});

  final DebugViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.appSizesScheme.paddingMedium),
        child: AppPrimaryButton(
          onPressed: vm.openEasterEgg,
          size: .small,
          child: Text(context.l10n.debugScreenEasterEggButton),
        ),
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard();

  @override
  Widget build(BuildContext context) {
    final paddingGeneral = context.appSizesScheme.paddingGeneral;

    return Card(
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
    );
  }
}

class _ServerSwitchCard extends StatelessWidget {
  const _ServerSwitchCard({required this.debugBloc, required this.onUrlRadioButtonPressed});

  final StateStreamable<DebugState> debugBloc;
  final ValueChanged<Urls?> onUrlRadioButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.appSizesScheme.paddingMedium),
        child: Column(
          children: <Widget>[
            Text(context.l10n.debugScreenServerSubtitle),
            BlocBuilder<StateStreamable<DebugState>, DebugState>(
              builder: (ctx, state) {
                return Column(
                  children: [
                    ...Urls.values.map(
                      (url) => RadioListTile<Urls>(
                        value: url,
                        groupValue: state.baseUrl,
                        onChanged: onUrlRadioButtonPressed,
                        title: Text(url.toString()),
                        subtitle: Text(url.value),
                      ),
                    ),
                  ],
                );
              },
              bloc: debugBloc,
            ),
          ],
        ),
      ),
    );
  }
}

class _HapticFeedbackCard extends StatelessWidget {
  const _HapticFeedbackCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(context.appSizesScheme.paddingMedium),
        child: Column(
          children: <Widget>[
            Text(l10n.debugScreenHapticFeedbackTitle),
            Wrap(
              spacing: context.appSizesScheme.paddingSmall,
              runSpacing: context.appSizesScheme.paddingSmall,
              children: <Widget>[
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).impact(.light),
                  size: .small,
                  child: Text(l10n.debugScreenHapticLightImpactButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).impact(.medium),
                  size: .small,
                  child: Text(l10n.debugScreenHapticMediumImpactButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).impact(.heavy),
                  size: .small,
                  child: Text(l10n.debugScreenHapticHeavyImpactButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).impact(.soft),
                  size: .small,
                  child: Text(l10n.debugScreenHapticSoftImpactButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).impact(.rigid),
                  size: .small,
                  child: Text(l10n.debugScreenHapticRigidImpactButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).notification(.success),
                  size: .small,
                  child: Text(l10n.debugScreenHapticSuccessNotificationButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).notification(.error),
                  size: .small,
                  child: Text(l10n.debugScreenHapticErrorNotificationButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).notification(.warning),
                  size: .small,
                  child: Text(l10n.debugScreenHapticWarningNotificationButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).selection(),
                  size: .small,
                  child: Text(l10n.debugScreenHapticSelectionHapticButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).feedback(.contextClick),
                  size: .small,
                  child: Text(l10n.debugScreenHapticContextClickFeedbackButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).feedback(.dragStart),
                  size: .small,
                  child: Text(l10n.debugScreenHapticDragStartFeedbackButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).feedback(.gestureEnd),
                  size: .small,
                  child: Text(l10n.debugScreenHapticGestureEndFeedbackButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).feedback(.gestureStart),
                  size: .small,
                  child: Text(l10n.debugScreenHapticGestureStartFeedbackButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).feedback(.textHandleMove),
                  size: .small,
                  child: Text(l10n.debugScreenHapticTextHandleMoveFeedbackButton),
                ),
                AppPrimaryButton(
                  onPressed: () => HapticsComponent.of(context).feedback(.virtualKeyRelease),
                  size: .small,
                  child: Text(l10n.debugScreenHapticVirtualKeyReleaseFeedbackButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
