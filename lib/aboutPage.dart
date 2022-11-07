import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'feedback.dart';
import 'globalvar.dart';
import 'showFullImage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:label_marker/label_marker.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'mainpage.dart';
import 'tnc.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int activeIndex = 0;

  static const _initialCameraPosition = CameraPosition(
      target: LatLng(13.090041991532244, 80.28658581252913), zoom: 17);
  GoogleMapController? _googlecontroller;
  Set<Marker> _markers = {};

  @override
  void dispose() {
    _googlecontroller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _markers.addLabelMarker(LabelMarker(
        label: "Click me to find the route",
        
        markerId: MarkerId("1"),
        position: LatLng(13.089846455861958, 80.28667655856152)));

    img.clear();
    phonenumbers.clear();
    abtpgdetails.clear();

    getabtpgdetails();
  }

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
                        "SHRI BALAJI ENTERPRISES",
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
                tileColor: Colors.grey[350],
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
        appBar: AppBar(title: Text("About Us ")),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'A2Z PLUMBING SOLUTIONS',
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
                Container(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: img.isEmpty
                        ? null
                        : CarouselSlider.builder(
                            itemCount: img.length,
                            options: CarouselOptions(
                                height:
                                    MediaQuery.of(context).size.height - 550,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                autoPlay: true,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll:
                                    img.length == 1 ? false : true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                                onPageChanged: (index, reason) {
                                  setState(() => activeIndex = index);
                                }),
                            itemBuilder: (context, index, realIndex) {
                              return InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ShowFullmages(
                                              url: img[index],
                                            ))),
                                child: Container(
                                  margin: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: NetworkImage(img[index]),
                                    ),
                                  ),
                                ),
                              );
                            }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: abtpgdetails.isEmpty
                      ? null
                      : Column(
                          children: [
                            Text(
                              abtpgdetails[4].toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              abtpgdetails[0].toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "${abtpgdetails[1].toString()}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    UrlLauncher.launch(
                                        "tel://${phonenumbers[index]}");
                                  },
                                  child: Text(
                                    phonenumbers[index],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: phonenumbers.length,
                            ),
                          ],
                        ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.blueGrey[700],
                  height: MediaQuery.of(context).size.height * 1 / 2 - 50,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      GoogleMap(
                        onMapCreated: (controller) =>
                            _googlecontroller = controller,
                        markers: _markers,
                        initialCameraPosition: _initialCameraPosition,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        gestureRecognizers: Set()
                          ..add(Factory<PanGestureRecognizer>(
                              () => PanGestureRecognizer())),
                      ),
                      Container(
                          alignment: Alignment.topRight,
                          child: FloatingActionButton(
                            child: Icon(
                              Icons.center_focus_strong,
                              size: 30,
                            ),
                            onPressed: () => _googlecontroller?.animateCamera(
                                CameraUpdate.newCameraPosition(
                                    _initialCameraPosition)),
                            mini: true,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getabtpgdetails() {
    vehicleStream = database.child("AboutPageDetails").once().then((event) {
      dynamic data = event.snapshot.value;

      abtpgdetails.add(data["Address"]);
      abtpgdetails.add(data["Mail"]);
      abtpgdetails.add(data["Phonenumber"]);

      abtpgdetails.add(data["Images"]);
      abtpgdetails.add(data["Name"]);

      abtpgdetails[3] = abtpgdetails[3].toString().split(","); // split the urls

      abtpgdetails[2] =
          abtpgdetails[2].toString().split(","); // split the phone numbers

      for (var mx in abtpgdetails[3]) {
        if (mx == "") continue;
        img.add(mx);
      }
      for (var mx in abtpgdetails[2]) {
        if (mx == "") continue;
        phonenumbers.add(mx);
      }

      setState(() {});
    });
  }
}
