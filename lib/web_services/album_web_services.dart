import 'dart:convert';

import 'package:network_training/model/album_model.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class AlbumWebServices {
  static Future<Album> getAlbum() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch Album.");
    }
  }

  static Future<Album> deleteAlbum() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
    if (response.statusCode == 200) {
      return Album.empty();
    } else {
      throw Exception("Failed to delete Album.");
    }
  }

  static WebSocketChannel webSocket() {
    final channel =
        WebSocketChannel.connect(Uri.parse("wss://echo.websocket.org"));
    return channel;
  }
}
