import 'dart:async';

import 'globalvar.dart';
import 'mainpage.dart';
import 'updateData.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GridWidget extends StatelessWidget {
  int length;
  Function acti;
  bool isSelected;
  List text;
  GridWidget({
    Key? key,
    required this.length,
    required this.text,
    required this.acti,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
      ),
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      itemCount: length,
      itemBuilder: (context, idx) {
        return InkWell(
          onTap: () {
            pgtitle = categories[idx];

            pathxy += "/" + categories[idx];
            !isSelected
                ? callupda(context)
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              title: categories[idx],
                            )),
                  );
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      img[idx].toString().trim(),
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            text[idx].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 22,
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Delete ${text[idx]}"),
                                  content: const Text(
                                      "Are you sure you want to delete?"),
                                  actions: [
                                    RawMaterialButton(
                                      onPressed: () {
                                        gotolastpage(context);
                                      },
                                      child: const Text("No"),
                                    ),
                                    RawMaterialButton(
                                        onPressed: () {
                                          database
                                              .child(pathxy)
                                              .child(text[idx])
                                              .remove()
                                              .whenComplete(() {
                                            gotolastpage(context);
                                          });
                                          final snackBar = SnackBar(
                                            content:
                                                Text('Deleted ${text[idx]}'),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                        child: const Text("Yes "))
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  callupda(var context) {
    temp.clear();
    pickedimgList.clear();
    vehicleStream = database.child(pathxy).once().then((event) {
      dynamic data = event.snapshot.value;
      if (data["lp"] == "yes") {
        temp.add("yes");
        temp.add(event.snapshot.key);
        temp.add(data["images"]);

        temp.add(data["desc"]);
        temp.add(data["price"]);
      } else {
        temp.add("no");
        temp.add(event.snapshot.key);
        temp.add(data["images"]);
      }
    });

    print(temp);

    var _timer = new Timer(const Duration(milliseconds: 800), () {
      temp[2] = temp[2].toString().substring(
          1,
          temp[2].toString().length -
              1); //get only the urls by removing square brackets

      temp[2] = temp[2].toString().split(","); // split the urls

      // assign the values

      for (var mx in temp[2]) {
        if (mx == "") continue;
        pickedimgList.add(mx);
      }

      alreadyimgcount = pickedimgList.length;

      for (var i = 2; i < temp.length; i++) {
        if (temp[i] == null) {
          temp[i] = "";
        }
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateDetails(),
        ),
      );
    });
  }
}
