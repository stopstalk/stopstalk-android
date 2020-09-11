import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../fragments/animations.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[300],
                Colors.blue[200],
                Colors.blue,
                Colors.blue[900],
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Stack(
          children: [
            FadeIn(
              ClipPath(
                clipper: RightBox(),
                child: Container(
                  color: Colors.grey[900],
                ),
              ),
              1,
            ),
            FadeIn(
              ClipPath(
                clipper: BottomBox(),
                child: Container(
                  color: Colors.grey[900],
                ),
              ),
              1,
            ),
            Positioned(
              top: 100,
              left: width / 2.6,
              child: FadeIn(
                Container(
                  child: SvgPicture.asset('assets/images/Spy.svg',
                      width: 120, height: 120),
                ),
                2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RightBox extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height / 1.1);
    path.lineTo(size.width / 1.4, size.height / 2);

    var firstControlPoint = new Offset(size.width, size.height / 3);
    var firstEndPoint = new Offset(size.width / 1.1, size.height / 3.4);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width / 2.2, 0.0);

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomBox extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, size.height / 1.65);
    path.lineTo(size.width / 1.5, size.height / 1.2);
    var firstControlPoint = new Offset(size.width / 1.6, size.height / 1.18);
    var firstEndPoint = new Offset(size.width / 1.4, size.height / 1.1);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width / 1.2, size.height);
    path.lineTo(size.width, size.height);

    /* var firstControlPoint = new Offset(size.width, size.height / 3);
    var firstEndPoint = new Offset(size.width / 1.1, size.height / 3.4);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width / 3, 0.0); */

    ///finally close the path by reaching start point from top right corner
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
