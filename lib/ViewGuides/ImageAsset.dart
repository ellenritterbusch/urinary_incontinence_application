import 'package:flutter/material.dart';


class ImageAsset extends StatefulWidget {
  final String imageAsset;
  const ImageAsset({required this.imageAsset});

  @override
  State<ImageAsset> createState() => _ImageAssetState();
}

class _ImageAssetState extends State<ImageAsset> {
  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Image(
          image: AssetImage(widget.imageAsset),
       ),
      );
  }
}