
import 'dart:async';

import 'package:new_version_plus/new_version_plus.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:sbe/noteorder.dart';

import 'aboutPage.dart';
import 'globalvar.dart';
import 'tnc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'feedback.dart';
import 'gridwidget.dart';

import 'landingpage.dart';
import 'updateappdialog.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  String title;

  Home({Key? key, required this.title}) : super(key: key);

  @override
  State<Home> createState() => _MainPageState();
}

class _MainPageState extends State<Home> {
  final database = FirebaseDatabase.instance.reference();
  bool isSelected = true;
  @override
  void initState() {
    super.initState();
    _checkVersion2();

    activateListeners(pathxy);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pathxy == "Home") {
          return true;
        }

        pathxy = pathxy.substring(0, pathxy.lastIndexOf("/"));
        gotolastpage(context);
        return false;
      },
      child: Scaffold(
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
                            fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
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
                tileColor: Colors.grey[350],
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
                    MaterialPageRoute(builder: (context) => const NoteOrder()),
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
                    MaterialPageRoute(builder: (context) => const AboutPage()),
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
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: landingpg == "yes"
                  ? null
                  : MaterialButton(
                      minWidth: 100,
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            isSelected = !isSelected;
                          });
                        }
                      },
                    ),
            ),
          ],
          title: Text(
            pgtitle,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: categories.isEmpty
            ? const Align(
                alignment: Alignment.center,
                child: Text(
                  "No Data Found",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              )
            : landingpg == "yes"
                ? LandingPage()
                : PageStorage(
                    bucket: globalBucket,
                    key: const PageStorageKey(0),
                    child: GridWidget(
                      length: temp.length,
                      text: temp,
                      acti: activateListeners,
                      isSelected: isSelected,
                    ),
                  ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Future<void> activateListeners(String x) async {
    categories.clear();
    img.clear();

    vehicleStream = database.child(x).onValue.listen((event) async {
      dynamic data = event.snapshot.value;

      temp = [];

      landingpg = await event.snapshot.child("lp").value;

      if (landingpg == "yes") {
        temp.add(event.snapshot.value);
      } else {
        data.forEach((k, v) async {
          if (k != "lp" &&
              k != "desc" &&
              k != "price" &&
              k != "images" &&
              k != "pdf") {
            if (k != "images") {
              temp.add(k);
            }
            if (event.snapshot.child(k).child("images").value == "[]") {
              img.add(noimglink);
            } else {
              img.add(event.snapshot
                  .child(k)
                  .child("images")
                  .value
                  .toString()
                  .substring(
                      1,
                      event.snapshot
                                  .child(k)
                                  .child("images")
                                  .value
                                  .toString()
                                  .indexOf(",") ==
                              -1
                          ? event.snapshot
                                  .child(k)
                                  .child("images")
                                  .value
                                  .toString()
                                  .length -
                              1
                          : event.snapshot
                              .child(k)
                              .child("images")
                              .value
                              .toString()
                              .indexOf(",")));
            }
          }
        });
        bool isSwapped = false;
        do {
          isSwapped = false;
          for (int i = 0; i < temp.length - 1; i++) {
            if (temp[i].compareTo(temp[i + 1]) > 0) {
              String tr = temp[i + 1];
              temp[i + 1] = temp[i];
              temp[i] = tr;
              isSwapped = true;
              //sort the images along with the category names
              String imgtr = img[i + 1];
              img[i + 1] = img[i];
              img[i] = imgtr;
            }
          }
        } while ((isSwapped));
      }
      setState(() {
        img = img;
        categories = temp;
      });

      setState(() {});
    });
  }

  void _checkVersion2() async {
    final newVersion = NewVersionPlus(
      iOSId: 'com.latest.sbe.catalogue',
      androidId: 'com.latest.sbe.catalogue',
    );

    final status = await newVersion.getVersionStatus();

    if (status!.canUpdate) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateDialog(
            allowDismissal: true,
            description: status!.releaseNotes!,
            version: status.storeVersion,
            appLink: status.appStoreLink,
          );
        },
      );
    } 
  }
}



//shribalajienterprises2006@gmail.com
//address old no.3 new no.5
//044-2538 6153
//9840628674
//A2Z PLUMBING SOLUTION