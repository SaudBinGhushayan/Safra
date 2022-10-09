import 'package:safra/objects/Places.dart';
import 'package:http/http.dart' as http;

class httpHandler {
  Future<List<Places>?> getPlaces(String city, String category) async {
    var client = http.Client();

    var uri =
        Uri.parse('http://10.0.2.2:5000/api?query1=${city}&query2=${category}');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return placesFromJson(json);
    }
  }
}
