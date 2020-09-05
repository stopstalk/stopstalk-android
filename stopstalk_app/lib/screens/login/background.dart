import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            ClipPath(
              clipper: RightBox(),
              child: Container(
                color: Colors.grey[900],
              ),
            ),
            ClipPath(
              clipper: BottomBox(),
              child: Container(
                color: Colors.purple[900],
              ),
            ),
            Positioned(
              top: 100,
              left: 150,
              child: Container(
                child: SvgPicture.network(
                    'https://visualpharm.com/assets/843/Spy%20Male-595b40b85ba036ed117da3de.svg',
                    width: 120,
                    height: 120),
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
    path.moveTo(size.width, size.height / 1.4);
    path.lineTo(size.width / 1.5, size.height / 1.2);
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
