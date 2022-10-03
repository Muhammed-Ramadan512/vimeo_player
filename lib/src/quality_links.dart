import 'dart:async';
import "dart:collection";
import 'dart:convert';

import 'package:http/http.dart' as http;

//throw UnimplementedError();

class QualityLinks {
  String videoId;
  String token;

  QualityLinks(this.videoId, this.token);

  getQualitiesSync() {
    return getQualitiesAsync();
  }

  // Future<SplayTreeMap> getQualitiesAsync() async {
  //   try {
  //     var response = await http
  //         .get('https://player.vimeo.com/video/' + videoId + '/config');
  //     var jsonData =
  //         jsonDecode(response.body)['request']['files']['progressive'];
  //     SplayTreeMap videoList = SplayTreeMap.fromIterable(jsonData,
  //         key: (item) => "${item['quality']} ${item['fps']}",
  //         value: (item) => item['url']);
  //     return videoList;
  //   } catch (error) {
  //     print('=====> REQUEST ERROR: $error');
  //     return null;
  //   }
  // }

  Future<SplayTreeMap> getQualitiesAsync() async {
    print("token: Bearer $token");
    try {
      final response = await http
          .get(Uri.parse("https://api.vimeo.com/me/videos/$videoId"), headers: {
        "Authorization": "Bearer $token",
      });
      var jsonData = jsonDecode(response.body)['download'];
      print(jsonData);
      SplayTreeMap videoList = SplayTreeMap.fromIterable(jsonData,
          key: (item) => "${item["public_name"]}  ${item["size_short"]} ",
          value: (item) => item['link']);

      videoList.forEach((key, value) {
        print("key: " + key.toString() + "   value: " + value.toString());
      });
      return videoList;
    } catch (error) {
      print('=====> REQUEST ERROR: $error');
      return null;
    }
  }
}
