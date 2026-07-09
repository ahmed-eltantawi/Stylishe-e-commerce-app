import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

///* This method is used to show image in app with different types of image formats
Widget showImage({required String image, BoxFit? fit}) {
  // in the case of svg
  if (image.endsWith('.svg')) {
    return SvgPicture.asset(image, fit: fit ?? BoxFit.contain);
  }
  // in the case of network image
  else if (image.startsWith('http') || image.startsWith('https')) {
    return CachedNetworkImage(
      imageUrl: image,
      fit: fit,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
  // in the case of asset image
  else {
    return Image.asset(image, fit: fit);
  }
}
