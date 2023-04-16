import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';
import 'aboutPage.dart';
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
  var shopname = TextEditingController(text: tempshopame);
  var contactnumber = TextEditingController(text: tempphonenum);
  var writtenorder = TextEditingController(text: temporder);

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
                            onChanged: (value) => {
                              tempshopame = value,
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
                            onChanged: (value) => {
                              tempphonenum = value,
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
                            onChanged: (value) => {
                              temporder = value,
                            },
                            minLines: 5,
                            maxLines: 45,
                            textAlign: TextAlign.justify,
                            controller: writtenorder,
                            decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15), // add padding to adjust icon
                                  child: IconButton(
                                    iconSize: 40,
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      writtenorder.clear();
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
    saveUserData("shopname", shopname.text.toString());
    saveUserData("phonenum", contactnumber.text.toString());
    saveUserData("order", writtenorder.text.toString());
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
}
