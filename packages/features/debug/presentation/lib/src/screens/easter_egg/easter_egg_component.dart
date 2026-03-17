import 'package:app_presentation/app_presentation.dart';
import 'package:debug_presentation/src/screens/easter_egg/easter_egg_layout.dart';
import 'package:flutter/widgets.dart';

/// {@template easter_egg_component}
/// A component for the easter egg screen.
/// {@endtemplate}
class EasterEggComponent extends Component<EasterEggViewModel, EasterEggLayout> {
  /// {@macro easter_egg_component}
  const EasterEggComponent({super.key});

  @override
  ComponentState<EasterEggComponent, EasterEggViewModel, EasterEggLayout> createState() => _EasterEggComponentState();
}

class _EasterEggComponentState extends ComponentState<EasterEggComponent, EasterEggViewModel, EasterEggLayout>
    implements EasterEggViewModel {
  late final _logoKey = GlobalKey();

  @override
  EasterEggLayout view() => EasterEggLayout(viewModel: this);

  @override
  GlobalKey get logoKey => _logoKey;
}

/// {@template easter_egg_view_model}
/// A view model for the easter egg screen.
/// {@endtemplate}
abstract class EasterEggViewModel implements ViewModel {
  /// The logo key.
  GlobalKey get logoKey;
}
