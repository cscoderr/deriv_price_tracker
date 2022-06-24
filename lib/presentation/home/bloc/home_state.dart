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
    this.markets = const [
      MarketModel(key: 'forex', title: 'Forex'),
      MarketModel(key: 'synthetic_index', title: 'Synthetic Indicies'),
      MarketModel(key: 'indices', title: 'Stock & Indicies'),
      MarketModel(key: 'cryptocurrency', title: 'Cryptocurrencies'),
      MarketModel(key: 'basket_index', title: 'Basket Indicies'),
      MarketModel(key: 'commodities', title: 'Commodities'),
    ],
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
  final List<MarketModel> markets;
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
