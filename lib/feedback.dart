import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
import 'aboutPage.dart';
import 'globalvar.dart';
import 'mainpage.dart';
import 'tnc.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  var feedbacktext = new TextEditingController();

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
                    margin: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(10.0),
                  ),
                ),
                ListTile(
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
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 350,
                ),
                ListTile(
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
                      MaterialPageRoute(builder: (context) => Tnc()),
                    );
                  },
                ),
                ListTile(
                  tileColor: Colors.grey[350],
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
                      MaterialPageRoute(builder: (context) => FeedbackPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(
              "Contact Developer",
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
                    padding: EdgeInsets.only(top: 25),
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
                                label: Text("Provide your Contact Developer"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                  200, 40) // put the width and height you want
                              ),
                          child: Wrap(children: <Widget>[
                            //place Icon here

                            const Text(
                              "Send mail",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          onPressed: () => sendmail(),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 40,
                          padding: EdgeInsets.only(left: 20),
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
                          padding: EdgeInsets.only(left: 20),
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
                          padding: EdgeInsets.only(left: 20),
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              launchUrl(
                                  Uri.parse("mailto:everystint@gmail.com"));
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

  sendmail() async {
    String email = Uri.encodeComponent("everystint@gmail.com");
    String subject = Uri.encodeComponent("Provide Contact Developer - Reg.");
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
