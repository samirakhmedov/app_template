import 'package:app_target/app_target.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestScopeWrapper extends StatelessWidget {
  const TestScopeWrapper({
    required this.appScope,
    required this.child,
    super.key,
  });

  final IAppScope appScope;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: appScope,
      child: child,
    );
  }
}
