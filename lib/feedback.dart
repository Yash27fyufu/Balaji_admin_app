// ignore_for_file: library_prefixes, depend_on_referenced_packages, avoid_unnecessary_containers, unnecessary_string_escapes, deprecated_member_use, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
import 'aboutPage.dart';
import 'globalvar.dart';
import 'mainpage.dart';
import 'noteorder.dart';
import 'tnc.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  var feedbacktext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          pathxy = "Home";
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
                  visualDensity: const VisualDensity(vertical: 0),
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
                  visualDensity: const VisualDensity(vertical: 0),
                  dense: true,
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
                      MaterialPageRoute(builder: (context) => NoteOrder()),
                    );
                  },
                ),
                ListTile(
                  visualDensity: const VisualDensity(vertical: 0),
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
                  visualDensity: const VisualDensity(vertical: 0),
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
                  visualDensity: const VisualDensity(vertical: 0),
                  tileColor: Colors.grey[350],
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
              "Contact Developer",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: deletingdata
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  child: SingleChildScrollView(
                    child: Container(
                        color: Colors.white,
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 25),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextFormField(
                                  minLines: 5,
                                  maxLines: 15,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(
                                        "[0-9a-zA-Z .,\' \( \) \[ \\] \\n \{ \}]")),
                                  ],
                                  controller: feedbacktext,
                                  decoration: const InputDecoration(
                                      alignLabelWithHint: true,
                                      label: Text("Provide your feedback"),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(200,
                                        40) // put the width and height you want
                                    ),
                                child: Wrap(children: const <Widget>[
                                  //place Icon here

                                  Text(
                                    "Send mail",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ]),
                                onPressed: () => sendmail(),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 55,
                                padding: const EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Having problem with opening the pdf ?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    deletsbefolder();
                                  },
                                  child: Text("Clear PDF Data")),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 40,
                                padding: const EdgeInsets.only(left: 20),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  'Connect us : ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                height: 30,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    UrlLauncher.launch("tel://+91 91500 66366");
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.call,
                                        color: Colors.grey[800],
                                        size: 30.0,
                                      ),
                                      Text(
                                        "+91 91500 66366",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    launchUrl(Uri.parse(
                                        "mailto:everystint@gmail.com"));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                        color: Colors.grey[800],
                                        size: 30.0,
                                      ),
                                      Text(
                                        " everystint@gmail.com",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
        ));
  }

  deletsbefolder() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Clear data "),
            content:
                const Text("Are you sure you want to delete all app data?"),
            actions: [
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeedbackPage()),
                  );
                },
                child: const Text("No"),
              ),
              RawMaterialButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        deletingdata = true;
                      });

                      var status = await Permission.storage.status;

                      if (status.isDenied) {
                        // You can request multiple permissions at once.
                        Map<Permission, PermissionStatus> statuses = await [
                          Permission.storage,
                        ].request();
                      }
                      status = await Permission.storage.status;
                      if (status.isDenied) {
                        var snackBar = const SnackBar(
                          content: Text("Please provide permission to proceed"),
                          duration: Duration(milliseconds: 500),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }

                      var dirPath = '/storage/emulated/0/Download/SBE';
                      final dir = Directory(dirPath);

                      if (await dir.exists()) {
                        dir.deleteSync(recursive: true);
                      }

                      var snackBar = const SnackBar(
                        content: Text("All data cleared"),
                        duration: Duration(milliseconds: 500),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } catch (error) {
                      print(error);
                      setState(() {
                        deletingdata = false;
                      });
                      var snackBar = SnackBar(
                        content: Text(error.toString()),
                        duration: Duration(milliseconds: 1500),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } finally {
                      setState(() {
                        deletingdata = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FeedbackPage()),
                      );
                    }
                  },
                  child: const Text("Yes "))
            ],
          );
        });
  }

  sendmail() async {
    if (feedbacktext.text.toString().trim() == "showversion") {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      var snackBar = SnackBar(
        content: Text(packageInfo.toString()),
        duration: const Duration(seconds: 10),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    String email = Uri.encodeComponent("everystint@gmail.com");
    String subject =
        Uri.encodeComponent("Provide feedback to the developer - Reg.");
    String body = Uri.encodeComponent(feedbacktext.text.toString().trim() == ""
        ? "I would like to contact you "
        : feedbacktext.text.toString().trim());

    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }
}
