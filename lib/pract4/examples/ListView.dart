import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/DogImage.dart';


class ExListView extends StatefulWidget {
  const ExListView({ super.key });
  @override
  State<ExListView> createState() => _ExListViewState();
}
class _ExListViewState extends State<ExListView> {
  late List<Image> _images = [];

  getImages() async {
    _images = await getDogImages(10);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) getImages();
    return  (_images.isEmpty)? const CircularProgressIndicator() :
    ListView.separated(
      itemCount: _images.length,
      itemBuilder: (_, index) => _images[index],
      separatorBuilder: (_, __) => const Divider(),
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
            body: const ExListView()
        )
    );
  }
}