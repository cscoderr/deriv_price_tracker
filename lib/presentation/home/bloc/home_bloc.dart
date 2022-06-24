import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ConnectedEvent>(connect);
  }

  WebSocketChannel? _channel;

  Future<void> connect(
    ConnectedEvent event,
    Emitter<HomeState> emit,
  ) async {
    print('enter');
    if (_channel != null) await _channel?.sink.close();
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.binaryws.com/websockets/v3?app_id=1089'),
    );
    _channel!.sink.add(
      jsonEncode(
        {'ticks': 'R_100'},
      ),
    );
    print('connected');
    emit(state.copyWith(channel: _channel));
  }

  @override
  Future<void> close() {
    _channel?.sink.close();
    return super.close();
  }
}
