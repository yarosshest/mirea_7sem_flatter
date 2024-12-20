import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/DogImage.dart';


class ExColumn extends StatefulWidget {
  const ExColumn({ super.key });
  @override
  State<ExColumn> createState() => _ExColumnState();
}
class _ExColumnState extends State<ExColumn> {
  late List<Image> _images = [];

  getImages() async {
    _images = await getDogImages(10);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) getImages();
    return  (_images.isEmpty)? const CircularProgressIndicator() :
        SingleChildScrollView(
          child: Column(children: _images,),
        );
  }
}



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: const ExColumn()
        )
    );
  }
}