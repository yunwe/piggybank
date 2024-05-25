import 'package:flutter/widgets.dart';

class Spacing extends StatelessWidget {
  final double height;

  const Spacing._(this.height);

  const Spacing.h20() : this._(20);

  const Spacing.h8() : this._(8);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
