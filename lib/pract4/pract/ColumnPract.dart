import 'package:flutter/material.dart';

import '../api/DogImage.dart';

class PractColumn extends StatefulWidget {
  const PractColumn({super.key});

  @override
  State<PractColumn> createState() => _PractColumnState();
}

class _PractColumnState extends State<PractColumn> {
  late List<Image> _images = [];

  getImages() async {
    _images = await getDogImages(10);
    setState(() {});
  }

  addImage() async {
    _images.addAll(await getDogImages(1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) getImages();
    return SingleChildScrollView(
        child: Column(children: [
      ElevatedButton(
          onPressed: () => addImage(), child: const Text("Добавть фото")),
      (_images.isEmpty)
          ? const CircularProgressIndicator()
          : Column(
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
                  .toList())
    ]));
  }
}
