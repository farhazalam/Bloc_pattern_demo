import 'dart:convert';

import 'package:bloc_patterndemo2/ImageModel.dart';
import 'package:bloc_patterndemo2/key.dart';
import 'package:http/http.dart' show get;

class ImageAPI {
  Future<List<Images>> makeRequest(String query) async {
    List<Images> images = [];

    final response = await get(
        'https://api.unsplash.com/search/photos?query=$query&client_id=$ACCESS_KEY');
    final parsedResponse = json.decode(response.body);
    final List results = parsedResponse['results'];
    results.forEach((result) => images.add(Images.fromJson(result)));

    return images;
  }
}
