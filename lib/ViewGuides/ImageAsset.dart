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
      
        child: checkForImage()
    );}
    Widget checkForImage() {
  if (widget.imageAsset == '') {
    // If image asset is empty, return an empty Text widget
    return Text('');
  } else {
    // If image asset is not empty, return an AssetImage widget
    return Image.asset(widget.imageAsset);
  }
}

}


