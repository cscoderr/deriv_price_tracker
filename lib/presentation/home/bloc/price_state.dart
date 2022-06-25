part of 'price_bloc.dart';

abstract class PriceState extends Equatable {
  const PriceState();

  @override
  List<Object> get props => [];
}

class PriceInitial extends PriceState {
  const PriceInitial();
}

class PriceLoading extends PriceState {
  const PriceLoading();
}

class PriceFailure extends PriceState {
  const PriceFailure(this.error);

  final String error;
  @override
  List<Object> get props => [error];
}

class PriceSuccess extends PriceState {
  const PriceSuccess(
    this.price,
  );

  final PriceModel price;
  @override
  List<Object> get props => [price];
}
