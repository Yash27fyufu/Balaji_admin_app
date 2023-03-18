import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:share_plus/share_plus.dart';

import 'globalvar.dart';
import 'mainpage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:path_provider/path_provider.dart';

void main() async {
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
              backgroundColor: Colors.amber, //appbar background color

              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      downloadfileandshare();
                      // ...
                    },
                  ),
                ),
              ],
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

downloadfileandshare() async {
  //check for permission
  var status = await Permission.storage.status;

  if (status.isDenied) {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }
  status = await Permission.storage.status;
  if (status.isDenied) {
    return;
  }

// write file in local storage
  var httpClient = new HttpClient();
  var request = await httpClient.getUrl(Uri.parse(pdfurl));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  File file = File('/storage/emulated/0/Download/sdff.pdf');
  await file.writeAsBytes(bytes);

  //share file;
  await Share.shareFiles(['/storage/emulated/0/Download/sdff.pdf']);

  // delete the locally stored file

 deleteFile(File('/storage/emulated/0/Download/sdff.pdf'));
}

Future<void> deleteFile(File file) async {
  try {
    if (await file.exists()) {
      await file.delete();
    }
  } catch (e) {
    // Error in getting access to the file.

  }
}
