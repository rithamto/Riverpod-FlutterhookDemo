import 'dart:convert';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final counterProvider = StateNotifierProvider<MainLogic, String>((_) => MainLogic());

class MainLogic extends StateNotifier<String> {
  MainLogic() : super("ok");

  Future<String> getURL() async {
    var client = HttpClient();
    var uri = Uri.parse('https://api.thecatapi.com/v1/images/search');
    HttpClientRequest request = await client.getUrl(uri);
    HttpClientResponse response = await request.close();
    var data = await response.transform(utf8.decoder).join();
    var map = json.decode(data);
    state = map[0]['url'].toString();
    return state;
  }
}