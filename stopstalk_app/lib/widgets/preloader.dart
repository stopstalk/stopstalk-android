import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Preloader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPouringHourglass(
        color: Color(0xFF2542ff),
      ),
    );
  }
}

class PreloaderDualRing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitDualRing(
        color: Color(0xFF2542ff),
      ),
    );
  }
}
