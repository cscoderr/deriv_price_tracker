part of 'price_bloc.dart';

abstract class PriceEvent extends Equatable {
  const PriceEvent();

  @override
  List<Object> get props => [];
}

class GetPriceEvent extends PriceEvent {
  const GetPriceEvent(this.symbol, this.prevPrice);

  final String symbol;
  final double prevPrice;
  @override
  List<Object> get props => [symbol, prevPrice];
}
