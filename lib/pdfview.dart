import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'globalvar.dart';
import 'mainpage.dart';

void main() {
  runApp(MaterialApp(home: PDFViewpage()));
}

class PDFViewpage extends StatefulWidget {
  @override
  State<PDFViewpage> createState() => _PDFViewpageState();
}

class _PDFViewpageState extends State<PDFViewpage> {
  @override
  Widget build(BuildContext context) {
    String pdfpagetitle = "View PDF";

    pdfpagetitle = pgtitle.toString();
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      title: pgtitle,
                    )),
          );
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
                title: Text(pdfpagetitle), //appbar title
                backgroundColor: Colors.amber //appbar background color
                ),
            body: Container(
                child: PDF().cachedFromUrl(
              pdfurl,
              maxAgeCacheObject: const Duration(days: 7), //duration of cache
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            ))));
  }
}
