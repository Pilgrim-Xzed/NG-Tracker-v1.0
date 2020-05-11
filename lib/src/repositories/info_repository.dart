import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kdresponse/src/helpers/helper.dart';
import 'package:kdresponse/src/models/ncdc_model.dart';
Future<Stream<NcdcModel>> getInfo() async {
  final String url = 'https://kd-covid-api.herokuapp.com/';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .map((data) {
        
    return NcdcModel.fromJson(data);
  });
}
