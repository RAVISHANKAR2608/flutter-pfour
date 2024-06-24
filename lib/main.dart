import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  double fontSizeValue = 14;

  void _decrementCounter() {
    setState(() {
      fontSizeValue--;
    });
  }

  void _incrementCounter() {
    setState(() {
      fontSizeValue++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Use State",
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'Outfit'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Demo Set State"),
          leading: const Center(child: Text("Leading")),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: _decrementCounter,
            ),
            IconButton(
                onPressed: _incrementCounter,
                icon: const Icon(Icons.add)),
          ],
        ),
        body: Center(
          child: Text(
            "Hello World",
            style: TextStyle(
              color: const Color(0xFF373737),
              fontSize: fontSizeValue,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            setState(() {
              fontSizeValue++;
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
