// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'aboutPage.dart';
import 'package:path_provider/path_provider.dart';
import 'globalvar.dart';
import 'feedback.dart';
import 'mainpage.dart';
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
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5),
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
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.7),
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
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.7),
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
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.7),
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
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.7),
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
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.7),
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
                            // initialValue: tempshopame,
                            onChanged: (value) async {
                              // var dir =
                              //     await getApplicationDocumentsDirectory();
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString("shopname", value);
                              // writeshopname(dir);
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
                              // var dir =
                              //     await getApplicationDocumentsDirectory();
                              // writephonenum(dir);
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
                              // var dir =
                              //     await getApplicationDocumentsDirectory();

                              // writegst(dir);
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
                              // var dir =
                              //     await getApplicationDocumentsDirectory();

                              // writeaddress(dir);
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
                              prefs.setString("order", value);
                              // var dir =
                              //     await getApplicationDocumentsDirectory();

                              // writeorder(dir);
                            },
                            minLines: 5,
                            maxLines: 15,
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

    String email = Uri.encodeComponent("shribalajienterprises2006@gmail.com");
    String subject = Uri.encodeComponent(shopname.text.toString().trim() == ""
        ? "Order"
        : shopname.text.toLowerCase().trim());
    String body = Uri.encodeComponent((writtenorder.text.toString().trim() == ""
            ? "I would like to place an order "
            : writtenorder.text.toString().trim()) +
        "\nContact no:" +
        contactnumber.text.toString());

    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      //email app opened

    } else {
      //email app is not opened
    }
  }

  Future<File> writedata() async {
    var dir = await getApplicationDocumentsDirectory();

    writeshopname(dir);
    writeaddress(dir);
    writegst(dir);
    writephonenum(dir);
    return writeorder(dir);
  }

  writeshopname(dir) {
    print("hiiiiii");
    var file = File(dir.path! + "/shop.txt");
    file.writeAsString(shopname.text);
  }

  writeaddress(dir) {
    print("hiisssssiiii");

    var file = File(dir.path! + "/address.txt");
    file.writeAsString(address.text);
  }

  writegst(dir) {
    print("hissssssssssccccccccccciiiii");

    var file = File(dir.path! + "/gst.txt");
    file.writeAsString(gstnumber.text);
  }

  writephonenum(dir) {
    print("hiiiivvvvvvii");

    var file = File(dir.path! + "/number.txt");
    file.writeAsString(contactnumber.text);
  }

  writeorder(dir) {
    print("hiibnnnnnnnnnnnniiii");

    var file = File(dir.path! + "/order.txt");
    file.writeAsString(writtenorder.text);
  }
}
