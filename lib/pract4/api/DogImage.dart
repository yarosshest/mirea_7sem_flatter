import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DogImage {
  final String url;
  final Image img;

  const DogImage(this.url, this.img);

  factory DogImage.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'image': String url,
      } =>
          DogImage(url, Image(width: 100, height: 100,
              image: NetworkImage(url)),
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

Future<DogImage> fetchDogImage() async {
  final response = await http
      .get(Uri.parse('https://randomfox.ca/floof/'));
  if (response.statusCode == 200) {
    return DogImage.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Image>> getDogImages(int n) async {
  List<Future> corPool = [];
  for (int i = 0; i < n; i++){
    corPool.add(fetchDogImage());
  }
  var dogImages = await Future.wait(corPool);
  List<Image> res =[];
  for (DogImage dog in dogImages){
    res.add(dog.img);
  }
  return res;
}

