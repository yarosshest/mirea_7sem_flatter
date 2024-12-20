import 'package:flutter/material.dart';

import '../api/DogImage.dart';

class PractListViewSep extends StatefulWidget {
  const PractListViewSep({super.key});

  @override
  State<PractListViewSep> createState() => _PractListViewSepState();
}

class _PractListViewSepState extends State<PractListViewSep> {
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
    return Column(children: [
      ElevatedButton(
          onPressed: () => addImage(), child: const Text("Добавть фото")),
      (_images.isEmpty)
          ? const CircularProgressIndicator()
          : Expanded(
              child: ListView.separated(
              itemCount: _images.length,
              itemBuilder: (_, index) {
                return ListTile(
                    title: _images[index],
                    trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => setState(() {
                              _images.removeAt(index);
                            })));
              },
              separatorBuilder: (_, __) => const Divider(),
            ))
    ]);
  }
}
