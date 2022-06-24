part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure,
}

class HomeState extends Equatable {
  const HomeState({
    this.symbols = const [],
    this.price = const PriceModel(),
    this.status = HomeStatus.initial,
  });

  HomeState copyWith({
    List<SymbolModel>? symbols,
    PriceModel? price,
    HomeStatus? status,
  }) {
    return HomeState(
      price: price ?? this.price,
      symbols: symbols ?? this.symbols,
      status: status ?? this.status,
    );
  }

  final List<SymbolModel> symbols;
  final PriceModel price;
  final HomeStatus status;
  @override
  List<Object?> get props => [price, symbols, status];
}
