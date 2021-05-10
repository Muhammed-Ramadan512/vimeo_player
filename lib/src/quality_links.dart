import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import "dart:collection";

//throw UnimplementedError();

class QualityLinks {
  String videoId;

  QualityLinks(this.videoId);

  getQualitiesSync() {
    return getQualitiesAsync();
  }
 
  /*Future<SplayTreeMap> getQualitiesAsyncOld() async {
    try {
      var response = await http
          .get('https://player.vimeo.com/video/' + videoId + '/config');
      var jsonData =
          jsonDecode(response.body)['request']['files']['progressive'];
      SplayTreeMap videoList = SplayTreeMap.fromIterable(jsonData,
          key: (item) => "${item['quality']} ${item['fps']}",
          value: (item) => item['url']);
      return videoList;
    } catch (error) {
      print('=====> REQUEST ERROR: $error');
      return null;
    }
  }*/

   Future<SplayTreeMap> getQualitiesAsync() async {
    try {
      final response =
          await http.get("https://api.vimeo.com/me/videos/$videoId", headers: {
        "Authorization": "Bearer 711542deb175eeab25582fa917400463",
      });
      var jsonData = jsonDecode(response.body)['download'];
      SplayTreeMap videoList = SplayTreeMap.fromIterable(jsonData,
          key: (item) => "${item["public_name"]}  ${item["size_short"]} ",
          value: (item) => item['link']);
      return videoList;
    } catch (error) {
      print('=====> REQUEST ERROR: $error');
      return null;
    }
  }
}
