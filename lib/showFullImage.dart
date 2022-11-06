import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowFullmages extends StatelessWidget {
  ShowFullmages({Key? key, required this.url}) : super(key: key);
  String url;
  @override
  Widget build(BuildContext context) {
    return PhotoView(imageProvider: NetworkImage(url));
  }
}
