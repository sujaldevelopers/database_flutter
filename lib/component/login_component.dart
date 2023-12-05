import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingComponent  extends StatelessWidget {
  const LoadingComponent ({super.key, this.radius=10});
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: radius,
      color: Colors.black,
    );
  }
}