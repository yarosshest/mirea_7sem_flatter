import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/DogImage.dart';


class ExGestureDetector extends StatefulWidget {
  const ExGestureDetector({ super.key });
  @override
  State<ExGestureDetector> createState() => _ExGestureDetectorState();
}
class _ExGestureDetectorState extends State<ExGestureDetector> {
  late List<Image> _images = [];

  getImages() async {
    _images = await getDogImages(10);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) getImages();
    return  (_images.isEmpty)? const CircularProgressIndicator() :
    ListView(
      children: _images.map((it)=> GestureDetector(
        child: ListTile(
          key: ValueKey(it),
          title: it,
          trailing: IconButton(icon: const Icon(Icons.delete),
              onPressed: () => setState(() {
                _images.remove(it);
              })),
        ),
      )).toList()
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
            body: const ExGestureDetector()
        )
    );
  }
}