part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.channel,
  });

  HomeState copyWith({
    WebSocketChannel? channel,
  }) {
    return HomeState(
      channel: channel ?? this.channel,
    );
  }

  final WebSocketChannel? channel;
  @override
  List<Object?> get props => [channel];
}
