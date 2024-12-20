import 'package:flutter/material.dart';

import '../api/DogImage.dart';

class PractListView extends StatefulWidget {
  const PractListView({super.key});

  @override
  State<PractListView> createState() => _PractListViewState();
}

class _PractListViewState extends State<PractListView> {
  late List<Image> _images = [];

  getImages() async {
    _images = await getDogImages(10);
    setState(() {});
  }

  addImage() async {
    _images.addAll(await getDogImages(1));
    setState(() {});
  }

  Widget getTopBar() {
    return ElevatedButton(
        onPressed: addImage(), child: const Text("Добавть фото"));
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) getImages();
    return Column(children: [
      ElevatedButton(
          onPressed: () => addImage(), child: const Text("Добавть фото")),
      (_images.isEmpty)
          ? const CircularProgressIndicator()
          : Expanded(
              child: ListView(
                  children: _images
                      .map((it) => GestureDetector(
                            child: ListTile(
                              key: ValueKey(it),
                              title: it,
                              trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => setState(() {
                                        _images.remove(it);
                                      })),
                            ),
                          ))
                      .toList()))
    ]);
  }
}
