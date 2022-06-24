part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialEvent extends HomeEvent {}

class SymbolsEvent extends HomeEvent {
  SymbolsEvent(this.market);

  final String market;

  @override
  List<Object?> get props => [market];
}

class MarketChangeEvent extends HomeEvent {
  MarketChangeEvent(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class MarketSymbolEvent extends HomeEvent {
  MarketSymbolEvent(this.symbol);

  final String symbol;

  @override
  List<Object?> get props => [symbol];
}

class SymbolPriceEvent extends HomeEvent {
  SymbolPriceEvent(this.symbol);

  final String symbol;

  @override
  List<Object?> get props => [symbol];
}
