import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TrackerApi {
  TrackerApi();
  WebSocketChannel? _channel;

  @visibleForTesting
  final String socketUrl = 'wss://ws.binaryws.com/websockets/v3?app_id=1089';

  Stream<dynamic> getSymbols() async* {
    if (_channel != null) await _channel!.sink.close();
    _channel = WebSocketChannel.connect(
      Uri.parse(socketUrl),
    );
    _channel!.sink.add(
      jsonEncode(
        {
          'active_symbols': 'brief',
          'product_type': 'basic',
        },
      ),
    );
    yield* _channel!.stream;
  }

  Stream<void> getPriceTicks() async* {
    if (_channel != null) await _channel!.sink.close();
    _channel = WebSocketChannel.connect(
      Uri.parse(socketUrl),
    );
    _channel!.sink.add(
      jsonEncode(
        {
          'ticks': 'R_50',
          'subscribe': 1,
        },
      ),
    );
    yield* _channel!.stream;
  }
}
