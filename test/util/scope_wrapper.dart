import 'package:app_template/features/app/di/i_app_scope.dart';
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
