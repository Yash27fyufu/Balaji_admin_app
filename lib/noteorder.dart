// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, import_of_legacy_library_into_null_safe, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pdf/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'aboutPage.dart';
import 'package:path_provider/path_provider.dart';
import 'globalvar.dart';
import 'feedback.dart';
import 'mainpage.dart';
import 'package:pdf/widgets.dart' as pw;

import 'tnc.dart';

class NoteOrder extends StatefulWidget {
  const NoteOrder({Key? key}) : super(key: key);

  @override
  State<NoteOrder> createState() => _NoteOrderState();
}

class _NoteOrderState extends State<NoteOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //readfiles();
  }

  var shopname = TextEditingController(text: tempshopame);
  var contactnumber = TextEditingController(text: tempphonenum);
  var gstnumber = TextEditingController(text: tempgstnum);
  var address = TextEditingController(text: tempaddress);
  var lorry = TextEditingController(text: templorry);
  var writtenorder = TextEditingController(text: temporder);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          pathxy = "Home";
          pgtitle = "Home";
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      title: "Home",
                    )),
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 105,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                    ),
                    margin: const EdgeInsets.all(0.0),
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'SHRI BALAJI ENTERPRISES',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: 0),
                  dense: true,
                  title: Text(
                    'Home',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    pgtitle = "Home";
                    pathxy = "Home";
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(
                                title: pgtitle,
                              )),
                    );
                  },
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: 0),
                  dense: true,
                  tileColor: Colors.grey[350],
                  title: Text(
                    'Order',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    readalldata();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NoteOrder()),
                    );
                  },
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: 0),
                  dense: true,
                  title: Text(
                    'About Us',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 350,
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: 0),
                  dense: true,
                  title: Text(
                    "Terms of Use",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Tnc()),
                    );
                  },
                ),
                ListTile(
                  visualDensity: VisualDensity(vertical: 0),
                  dense: true,
                  title: Text(
                    "Contact Developer",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedbackPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: const Text(
              "Order",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              tempshopame = value;
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("shopname", value);
                            },
                            controller: shopname,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                label: Text("Shop Name"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("phonenum", value);
                              tempphonenum = value;
                            },
                            controller: contactnumber,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9, \\- ]")),
                            ],
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                label: Text("Contact Number"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("gstnum", value);
                              tempgstnum = value;
                            },
                            controller: gstnumber,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                label: Text("GST Number"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("address", value);
                              tempaddress = value;
                            },
                            minLines: 1,
                            maxLines: 5,
                            controller: address,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                label: Text("Address"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("lorry", value);
                              templorry = value;
                            },
                            minLines: 1,
                            maxLines: 5,
                            controller: lorry,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                label: Text("Lorry Name"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("order", value);
                              temporder = value;
                            },
                            minLines: 5,
                            maxLines: 10,
                            textAlign: TextAlign.justify,
                            controller: writtenorder,
                            decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15), // add padding to adjust icon
                                  child: IconButton(
                                    iconSize: 40,
                                    icon: const Icon(Icons.close),
                                    onPressed: () async {
                                      temporder = "";
                                      writtenorder.clear();

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString("order", "");
                                      // var dir =
                                      //     await getApplicationDocumentsDirectory();

                                      // writeorder(dir);
                                    },
                                  ),
                                ),
                                alignLabelWithHint: true,
                                label: Text("Write your order here..."),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(
                                  200, 40) // put the width and height you want
                              ),
                          child: Wrap(children: const <Widget>[
                            //place Icon here

                            Text(
                              "Send Order",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          onPressed: () => sendmail(),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }

  sendmail() async {
    //writedata();

    await createpdf();

    //return;

    // String email = Uri.encodeComponent("shribalajienterprises2006@gmail.com");
    // String subject = Uri.encodeComponent(shopname.text.toString().trim() == ""
    //     ? "Order"
    //     : shopname.text.toLowerCase().trim());
    // String body = Uri.encodeComponent(
    //     "${writtenorder.text.toString().trim() == "" ? "I would like to place an order " : writtenorder.text.toString().trim()}\nContact no:${contactnumber.text}");

    // Uri mail = Uri.parse(
    // "mailto:$email?subject=$subject&body=/storage/emulated/0/Android/data/com.latest.sbe.catalogue/files/Order.pdf");
    // if (await launchUrl(mail)) {
    //   //email app opened

    // } else {
    //   //email app is not opened
    // }
  }

  Future<void> createpdf() async {
    temporder = temporder.trim();
    print(temporder + "ssssssssssssssssssssssss");

    if (temporder.length == 0) {
      const snackBar = SnackBar(
        content: Text('Enter your order'),
        duration: Duration(milliseconds: 500),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (tempshopame.trim().length == 0) {
      const snackBar = SnackBar(
        content: Text('Enter your Shop name'),
        duration: Duration(milliseconds: 500),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (tempphonenum.trim().length == 0) {
      const snackBar = SnackBar(
        content: Text('Enter your Phone number'),
        duration: Duration(milliseconds: 500),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (tempgstnum.trim().length == 0) {
      const snackBar = SnackBar(
        content: Text('Enter your GST number'),
        duration: Duration(milliseconds: 500),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (tempaddress.trim().length == 0) {
      const snackBar = SnackBar(
        content: Text('Enter your Address'),
        duration: Duration(milliseconds: 500),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    // PdfDocument doc = PdfDocument();
    // final page = doc.pages.add();

    // page.graphics
    //     .drawString(tempshopame, PdfStandardFont(PdfFontFamily.helvetica, 50));

    // page.graphics.drawLine(PdfPens.black, Offset(0, 100), Offset(500, 100));

    var numoflines = "\n".allMatches(temporder).length;

    List temptemporder = [];

    var numofpdfpages = ((numoflines + (temporder.length / 32)) / 18).ceil();

    temporder = temporder.replaceAll("\n", "                                ");

    for (int i = 0; i < numofpdfpages; i++) {
      temptemporder.add("");
      for (int j = 576 * i;
          j < (576 * (numofpdfpages + 1)) && j < temporder.length;
          j++) {
        temptemporder[i] += temporder[j];
      }

      temptemporder[i] =
          temptemporder[i].replaceAll("                                ", "\n");
    }

    final pdf = pw.Document();
    for (int i = 0; i < numofpdfpages; i++) {
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Container(
            height: 1000,
            child: pw.Column(children: [
              pw.Text(
                tempshopame.toUpperCase(),
                style:
                    pw.TextStyle(fontSize: 35, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                "Ph.No:$tempphonenum",
                style: pw.TextStyle(fontSize: 22),
              ),
              pw.Text(
                "Address:$tempaddress",
                style: pw.TextStyle(fontSize: 22),
              ),
              if (templorry.trim().length != 0)
                pw.Text(
                  "Lorry:$templorry",
                  style: pw.TextStyle(fontSize: 18),
                ),
              pw.Container(
                  width: 600,
                  child: pw.Row(children: [
                    pw.Text(
                      "GSTin:${tempgstnum.toUpperCase()}",
                      style: pw.TextStyle(fontSize: 22),
                    ),
                    pw.Spacer(),
                    pw.Container(
                        margin: pw.EdgeInsets.only(right: 10),
                        child: pw.Text(
                          "Page:${i + 1}",
                          style: pw.TextStyle(
                            fontSize: 20,
                          ),
                        )),
                  ])),
              pw.Container(
                height: 2,
                color: PdfColors.black,
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                  margin: pw.EdgeInsets.only(left: 20, right: 20),
                  height: 500,
                  width: 700,
                  child: pw.Text(temptemporder[i],
                      style: pw.TextStyle(fontSize: 25),
                      textAlign: pw.TextAlign.justify)),
            ])); // Center
      })); // Page
    }

    // List<int> bytes = await doc.save();

    // doc.dispose();

    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/Order.pdf');
    // await file.writeAsBytes(bytes, flush: true);

    await file.writeAsBytes(await pdf.save());
    // deleteFile(File('$path/Order.pdf'));
    if (await File(
            "/storage/emulated/0/Android/data/com.latest.sbe.catalogue/files/Order.pdf")
        .exists()) {
      print("object");
    }

    shareFile();

    // await launch("https://wa.me/${"+919150066366"}?text=Hello");

    if (await File("$path/Order.pdf").exists()) {
      await Share.shareFiles(["$path/Order.pdf"],
          text: "I would like to place an order");
      deleteFile(File('$path/Order.pdf'));
    }
  }

// /storage/emulated/0/Android/data/com.latest.sbe.catalogue/files/Order.pdf
  Future<void> shareFile() async {
    // await WhatsappShare.shareFile(
    //   text: 'Whatsapp share text',
    //   phone: '911234567890',
    //   filePath: [
    // '/storage/emulated/0/Android/data/com.latest.sbe.catalogue/files/Order.pdf'
    //   ],
    // );

    {
      // final file = File('/storage/emulated/0/Download/d.jpeg');

      // if (await file.exists()) {
      //   print("jjjjjjjjjjjjjjjjj");
      // }
      // final url = 'whatsapp://send';
      // final params = <String, String>{
      //   'text': 'See attached image',
      //   'phone': '919150066366', // Replace with the recipient's phone number
      //   'attachment': file.path,
      // };
      // final urlString = '$url${Uri(queryParameters: params)}';
      // if (await canLaunch(urlString)) {
      //   await launch(urlString);
      // } else {
      //   throw 'Could not launch $urlString';
      // }
    }

    {
      // final Email email = Email(
      //   body: 'Email body',
      //   subject: 'Email subject',
      //   recipients: ['example@example.com'],
      //   cc: ['cc@example.com'],
      //   bcc: ['bcc@example.com'],
      //   attachmentPaths: ['/path/to/attachment.zip'],
      //   isHTML: false,
      // );

      // await FlutterEmailSender.send(email);
    }

    // const url =
    //     'https://wa.me/+919150066366?text&src=/storage/emulated/0/Android/data/com.latest.sbe.catalogue/files/Order.pdf';

    // await launch(
    //   url,
    // );
  }
}
