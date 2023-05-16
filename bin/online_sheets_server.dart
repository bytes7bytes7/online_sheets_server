import 'dart:async';

import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  final eventController = StreamController.broadcast();

  var handler = webSocketHandler((WebSocketChannel webSocket) {
    eventController.stream.listen((event) {
      webSocket.sink.add(event);
    });

    webSocket.stream.listen((message) {
      print(message);
      eventController.add(message);
    });
  });

  shelf_io.serve(handler, '127.0.0.1', 8080).then((server) {
    print('Serving at ws://${server.address.host}:${server.port}');
  });
}
