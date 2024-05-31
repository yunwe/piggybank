import 'package:flutter/widgets.dart';

class Spacing extends StatelessWidget {
  final double height;
  final double width;

  const Spacing._(this.height, this.width);

  const Spacing.h20() : this._(20, 0);

  const Spacing.h12() : this._(12, 0);

  const Spacing.h8() : this._(8, 0);

  const Spacing.w5() : this._(0, 5);

  const Spacing.w15() : this._(0, 15);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
