import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ImageAnimation extends StatelessWidget {
  String image;
   ImageAnimation({required String this.image});


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      // SystemUiOverlay.bottom
    ]);
    return Scaffold(
      body: InkWell(
        onTap:()=>Navigator.of(context).pop() ,
      child: Align(
        alignment: Alignment.center,
        child: Hero(
          tag: "hero-rectangle",
          createRectTween: (Rect? begin, Rect? end) {
            return MaterialRectCenterArcTween(begin: begin, end: end);
          },
          child: BoxWidget(
            size: const Size(double.infinity, 350.0),
            color: Colors.black,
            image: image!,
          ),
        ),
      ),
      ),
    );
  }
}
class BoxWidget extends StatelessWidget {
  const BoxWidget({
    super.key,
    required this.size,
    required this.color,
    required this.image,
  });

  final Size size;
  final Color color;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height:double.infinity,
      color: color,
      child: Image.network(image,
            width: size.width,
            height: size.height,
            fit: BoxFit.contain,
            ),
    );
  }
}
