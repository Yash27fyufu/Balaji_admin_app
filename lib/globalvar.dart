import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'mainpage.dart';

final formkey = GlobalKey<FormState>();
var pathxy = "Home";
var pgtitle = "Home";
var landingpg;
var alreadyimgcount = 0;

var desc, price;
List img = [];
List categories = [];
List pickedimgList = [];
int count = 0;
dynamic images = [];
List names = [];
List temp = [];
var database = FirebaseDatabase.instance.ref();
var vehicleStream;
Map<String, List> dummy = {};
var imgstorage = FirebaseStorage.instance;
var pp;
var abtpgdetails = [];
List phonenumbers = [];
var smap = new Map<String, String>();
var smapkeys = [];
var smapval = [];
var storageImages = [];
var noimglink =
    "https://media.istockphoto.com/vectors/black-linear-photo-camera-like-no-image-available-vector-id1055079680?k=20&m=1055079680&s=612x612&w=0&h=ujFxkvnp-VclErGByAsr2RYLJObedAtK7NNLgNJY_8A=";

Future<void> getimgurl(String pathforimg) async {
  final FirebaseStorage storage = FirebaseStorage.instance;

  final result = await storage.ref(pathforimg).list();
  final List<Reference> allFiles = result.items;

  await Future.forEach<Reference>(allFiles, (file) async {
    final String fileUrl = await file.getDownloadURL();

    storageImages.add(fileUrl);
  });
}

gotolastpage(var context) {
  pgtitle = pathxy;
  if (pathxy != "Home") {
    pgtitle = pathxy.substring(pathxy.lastIndexOf("/") + 1);
  }

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => Home(
              title: pgtitle,
            )),
  );
}

delete_images_from_db_which_are_not_used() {
  if (temp[2] == []) return;

  temp[2].removeWhere((element) => pickedimgList.contains(element));

  for (var xy in temp[2]) {
    FirebaseStorage.instance.refFromURL(xy.toString().trim()).delete();
  } // deletes the images from database which are deselected from the list
}
