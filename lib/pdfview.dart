// ignore_for_file: unused_import, unused_local_variable, await_only_futures, unnecessary_new, deprecated_member_use, depend_on_referenced_packages

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
  void initState() {
    // TODO: implement initState
    super.initState();
    filenameinurl = pdfurl.toString().substring(
        pdfurl.toString().lastIndexOf("%2F") + 3,
        pdfurl.toString().lastIndexOf("?alt="));
    asd = pathxy.toString().replaceAll("/", "");
    asd = asd.toString().replaceAll(" ", "");

    isloadin = true;

    downloadfile();
  }

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
                      sharefile(asd);
                      // ...
                    },
                  ),
                ),
              ],
            ),
            body: Container(
                child: isloadin
                    ? const Center(child: CircularProgressIndicator())
                    :
                    //  PDF().cachedFromUrl(
                    //     pdfurl,
                    //     maxAgeCacheObject:
                    //         const Duration(days: 7), //duration of cache
                    //     placeholder: (progress) =>
                    //         Center(child: Text('$progress %')),
                    //     errorWidget: (error) =>
                    //         Center(child: Text(error.toString())),
                    //   )
                    const PDF().fromPath(
                        '/storage/emulated/0/Download/SBE/$asd/$filenameinurl.pdf'))));
  }

  downloadfile() async {
    //check for permission
<<<<<<< HEAD
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

    setState(() {
      isloadin = true;
    });
    if (!await Directory('storage/emulated/0/Download/SBE').exists()) {
      await Directory('storage/emulated/0/Download/SBE').create();
    }

    if (!await Directory('storage/emulated/0/Download/SBE/$asd').exists()) {
      await Directory('storage/emulated/0/Download/SBE/$asd').create();
      savethepdfindevice(asd);
    } else {
      setState(() {
        isloadin = false;
      });

      var filesinfolder = "";
      var filenameindevice = "";
      if (await Directory('storage/emulated/0/Download/SBE/$asd')
          .listSync(recursive: true, followLinks: false)
          .isNotEmpty) {
        filesinfolder = await Directory('storage/emulated/0/Download/SBE/$asd')
            .listSync(recursive: true, followLinks: false)[0]
            .toString();
        filenameindevice = filesinfolder.substring(
            filesinfolder.lastIndexOf("/") + 1, filesinfolder.length - 5);
      }

      if (filenameindevice.toString() == "") {
        savethepdfindevice(asd);
      } else if (filenameindevice != filenameinurl) {
        deleteFile(File(
            filesinfolder.toString().substring(7, filesinfolder.length - 1)));
        savethepdfindevice(asd);
      }
    }

=======
    try {
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

      setState(() {
        isloadin = true;
      });
      if (!await Directory('storage/emulated/0/Download/SBE').exists()) {
        await Directory('storage/emulated/0/Download/SBE').create();
      }

      if (!await Directory('storage/emulated/0/Download/SBE/$asd').exists()) {
        await Directory('storage/emulated/0/Download/SBE/$asd').create();
        savethepdfindevice(asd);
      } else {
        setState(() {
          isloadin = false;
        });

        var filesinfolder = "";
        var filenameindevice = "";
        if (await Directory('storage/emulated/0/Download/SBE/$asd')
            .listSync(recursive: true, followLinks: false)
            .isNotEmpty) {
          filesinfolder =
              await Directory('storage/emulated/0/Download/SBE/$asd')
                  .listSync(recursive: true, followLinks: false)[0]
                  .toString();
          filenameindevice = filesinfolder.substring(
              filesinfolder.lastIndexOf("/") + 1, filesinfolder.length - 5);
        }

        if (filenameindevice.toString() == "") {
          savethepdfindevice(asd);
        } else if (filenameindevice != filenameinurl) {
          deleteFile(File(
              filesinfolder.toString().substring(7, filesinfolder.length - 1)));
          savethepdfindevice(asd);
        }
      }
    } catch (e) {
      print(e);
    }
>>>>>>> 45823a0ee6fed4e8e47523240f959a60c4350396
    //deleteFile(File('/storage/emulated/0/Download/sdff.pdf'));
  }

  savethepdfindevice(asd) async {
    // write file in local storage
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(pdfurl));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);

    File file =
        File('/storage/emulated/0/Download/SBE/$asd/$filenameinurl.pdf');
    await file.writeAsBytes(bytes);

    setState(() {
      isloadin = false;
    });
  }

  sharefile(asd) async {
    await Share.shareFiles(
        ['/storage/emulated/0/Download/SBE/$asd/$filenameinurl.pdf']);
  }
}
