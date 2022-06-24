part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure,
}

enum PriceStatus {
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
    this.market = '',
    this.symbol = '',
  });

  HomeState copyWith({
    List<SymbolModel>? symbols,
    PriceModel? price,
    HomeStatus? status,
    String? market,
    String? symbol,
  }) {
    return HomeState(
      price: price ?? this.price,
      symbols: symbols ?? this.symbols,
      status: status ?? this.status,
      market: market ?? this.market,
      symbol: symbol ?? this.symbol,
    );
  }

  final List<SymbolModel> symbols;
  final PriceModel price;
  final HomeStatus status;
  final String market;
  final String symbol;

  @override
  List<Object?> get props => [
        price,
        symbols,
        status,
        market,
        symbol,
      ];
}
