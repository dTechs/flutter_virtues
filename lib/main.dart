import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Virtues'),
      home: Virtues(),
    );
  }
}

class Virtues extends StatefulWidget {
  @override
  _VirtuesState createState() => _VirtuesState();
}

class _VirtuesState extends State<Virtues> {
  @override
  Widget build(BuildContext context) {
    var futurebuilder = FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          //return Text("Press button to start");
          case ConnectionState.waiting:
            return Text("Loading...");
          default:
            if (snapshot.hasError)
              return Text("Error: ${snapshot.error}");
            else
              //return Text("Result: ${snapshot.data}");
              return createListView(context, snapshot);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Virtues"),
      ),
      body: Center(child: futurebuilder),
    );
  }

  Future<List<String>> _getData() async {
    var values = List<String>();
    values.add("Horses");

    await new Future.delayed(Duration(seconds: 2));

    return values;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;

    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(values[index]),
            )
          ],
        );
      },
    );
  }
}