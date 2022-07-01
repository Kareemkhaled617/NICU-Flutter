import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GoogleMapServicesScreen {
  final String key = 'AIzaSyCE72on2xFyiR8_S0oxh3FxSfNFp0cvBZ4';

  Future<String> getPlaceId(String input) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery";

    var response = await http.get(Uri.parse(url)); //to get ulr from http

    var json = convert.jsonDecode(response.body); //to convert url to json file

    var placeId =
        json['candidates'][0]['place_id'] as String; //to get any field

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);
    final String urlPlace =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?place_id=$placeId&key=$key';

    var response = await http.get(Uri.parse(urlPlace)); //to get ulr from http

    var json = convert.jsonDecode(response.body); //to convert url to json file

    var results = json['result'] as Map<String, dynamic>;
    print(results);
    return results;
  }
}
