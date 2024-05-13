import 'package:flutter/material.dart';

//This class is used as the template for the image asset in the ListTile_DropDown tile. 
//Its attribute "imageAsset" is given as "String imageAsset" in LT_DD.
class ImageAsset extends StatefulWidget {
  final String imageAsset; //Location of image in the "image" sub-folder in assets folder. Should take the form of "assets/image/IMAGEFILENAME.png"
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
    return Text(''); //If no image is available, just make an empty text box. Otherwise there would be an error
  } else {
    // If image asset is not empty, return an AssetImage widget
    return Image.asset(widget.imageAsset);
  }
}

}


