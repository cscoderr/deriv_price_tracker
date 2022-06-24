part of 'price_bloc.dart';

abstract class PriceEvent extends Equatable {
  const PriceEvent();

  @override
  List<Object> get props => [];
}

class GetPriceEvent extends PriceEvent {
  const GetPriceEvent(this.symbol);

  final String symbol;
  @override
  List<Object> get props => [symbol];
}

class PriceChangedEvent extends PriceEvent {
  const PriceChangedEvent(this.price);

  final PriceModel price;
  @override
  List<Object> get props => [price];
}
