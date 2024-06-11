import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Radio Buttons';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.black,
        // accentColor: Colors.black,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: const Center(child: RadioButtons()),
      ),
    );
  }
}

enum Pet { dog, cat }

class RadioButtons extends StatefulWidget {
  const RadioButtons({Key? key}) : super(key: key);

  @override
  State<RadioButtons> createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  Pet _pet = Pet.dog;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        title: const Text('Dog'),
        leading: Radio<Pet>(
          value: Pet.dog,
          groupValue: _pet,
          onChanged: (Pet? value) {
            setState(() {
              _pet = value!;
              print('Selected Pet: $_pet');
            });
          },
        ),
      ),
      ListTile(
        title: const Text('Cat'),
        leading: Radio<Pet>(
          value: Pet.cat,
          groupValue: _pet,
          onChanged: (Pet? value) {
            setState(() {
              _pet = value!;
              print('Selected Pet: $_pet');
            });
          },
        ),
      ),
    ]);
  }
}
