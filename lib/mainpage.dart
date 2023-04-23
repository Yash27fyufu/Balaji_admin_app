// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:new_version_plus/new_version_plus.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'aboutPage.dart';
import 'globalvar.dart';
import 'noteorder.dart';
import 'tnc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'addDetails.dart';
import 'feedback.dart';
import 'gridwidget.dart';

import 'landingpage.dart';

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
    categories.clear();
    img.clear();
    //_checkVersion2();

    activateListeners(pathxy);
  }

  final searchtext = TextEditingController();

  var focussearchbar = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pathxy == "Home") {
          if (issearchon) {
            issearchon = false;
            setState(() {
              temp.clear();
              img.clear();

              for (int i = 0; i < temptempforsearch.length; i++) {
                temp.add(temptempforsearch[i]);
                img.add(tempimgforsearch[i]);
              }
              temptempforsearch.clear();
              tempimgforsearch.clear();
              searchtext.clear();
              issearchon = false;
            });
            return false;
          }
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
                          textStyle: const TextStyle(
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
                tileColor: Colors.grey[350],
                title: const Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  issearchon = false;
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
                  issearchon = false;

                  readalldata();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NoteOrder()),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'About Us',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  issearchon = false;

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
                title: const Text(
                  "Terms of Use",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  issearchon = false;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Tnc()),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  "Contact Developer",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  issearchon = false;

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
        appBar: issearchon && landingpg != "yes"
            ? AppBar(
                title: Column(
                  children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: <Widget>[
                          TextField(
                            focusNode: focussearchbar,
                            autofocus: true,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            controller: searchtext,
                            cursorColor: Colors.black,
                            onChanged: (value) {
                              temp.clear();
                              img.clear();

                              for (int i = 0;
                                  i < temptempforsearch.length;
                                  i++) {
                                if (value == '') {
                                  for (int i = 0;
                                      i < temptempforsearch.length;
                                      i++) {
                                    temp.add(temptempforsearch[i]);
                                    img.add(tempimgforsearch[i]);
                                  }
                                  break;
                                } else {
                                  if (temptempforsearch[i]
                                      .toString()
                                      .toLowerCase()
                                      .contains(
                                          value.toString().toLowerCase())) {
                                    temp.add(temptempforsearch[i]);
                                    img.add(tempimgforsearch[i]);
                                  }
                                }
                              }
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                            ),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {
                                temp.clear();
                                img.clear();

                                for (int i = 0;
                                    i < temptempforsearch.length;
                                    i++) {
                                  temp.add(temptempforsearch[i]);
                                  img.add(tempimgforsearch[i]);
                                }
                                temptempforsearch.clear();
                                tempimgforsearch.clear();
                                searchtext.clear();
                                issearchon = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : AppBar(
                actions: <Widget>[
                  if (landingpg != "yes")
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        // do something
                        issearchon = true;
                        tempimgforsearch.clear();
                        temptempforsearch.clear();

                        for (int i = 0; i < temp.length; i++) {
                          temptempforsearch.add(temp[i]);
                          tempimgforsearch.add(img[i]);
                        }
                        setState(() {});
                        focussearchbar.requestFocus();
                      },
                    ),
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
                            child: isSelected
                                ? const Text(
                                    "Edit is off",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 203, 19, 19),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Text(
                                    "Edit is on",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                  ),
                ],
                title: Text(
                  pgtitle,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
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
                : GridWidget(
                    length: temp.length,
                    text: temp,
                    acti: activateListeners,
                    isSelected: isSelected,
                  ),
        floatingActionButton: landingpg == "yes"
            ? null
            : FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  pickedimgList.clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AddDetails()),
                  );
                },
              ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Future<void> activateListeners(String x) async {
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
            if ((event.snapshot.child(k).child("images").value == "[]")) {
              var gf = event.snapshot.child(k).key;
              print(gf);
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
    });
  }

  void _checkVersion2() {
    final newVersion = NewVersionPlus(
      iOSId: 'com.sbe.catalogue',
      androidId: 'com.sbe.catalogue',
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = true;

    if (simpleBehavior) {
      basicStatusCheck(newVersion);
    }
  }

  basicStatusCheck(NewVersionPlus newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersionPlus newVersion) async {
    final status = await newVersion.getVersionStatus();
    print(status);
    if (status != null) {
      print(status.releaseNotes);
      print(status.appStoreLink);
      print(status.localVersion);
      print(status.storeVersion);
      print(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
      );
    }
  }
}

//shribalajienterprises2006@gmail.com
//address old no.3 new no.5
//044-2538 6153
//9840628674
//A2Z PLUMBING SOLUTION