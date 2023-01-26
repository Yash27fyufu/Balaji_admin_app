import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Home',
        theme: ThemeData(
          fontFamily: "OpenSans",
          primarySwatch: Colors.amber,
        ),
      home: Home(title: "Home"));
  }
}

/*

showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Update"),
                      content: Text("Do you want to update the app now ?"),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text("No"),
                        ),
                        FlatButton(
                            onPressed: () {
                              http
                                  .get(Uri.parse(
                                      "https://vehicle-8c2b1-default-rtdb.firebaseio.com/UpdateUrl.json"))
                                  .then((resp) {
                                launch(json.decode(resp.body));
                              });
                            },
                            child: Text("Yes "))
                      ],
                    );
                  });

*/
