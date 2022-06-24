class SymbolModel {
  const SymbolModel({
    this.allowForwardStarting,
    this.displayName,
    this.exchangeIsOpen,
    this.isTradingSuspended,
    this.market,
    this.marketDisplayName,
    this.pip,
    this.submarket,
    this.submarketDisplayName,
    this.symbol,
    this.symbolType,
  });

  factory SymbolModel.fromJson(Map<String, dynamic> json) => SymbolModel(
        allowForwardStarting: json['allow_forward_starting'] as int?,
        displayName: json['display_name'] as String?,
        exchangeIsOpen: json['exchange_is_open'] as int?,
        isTradingSuspended: json['is_trading_suspended'] as int?,
        market: json['market'] as String?,
        marketDisplayName: json['market_display_name'] as String?,
        pip: json['pip'] as double?,
        submarket: json['submarket'] as String,
        submarketDisplayName: json['submarket_display_name'] as String?,
        symbol: json['symbol'] as String?,
        symbolType: json['symbol_type'] as String?,
      );

  final int? allowForwardStarting;
  final String? displayName;
  final int? exchangeIsOpen;
  final int? isTradingSuspended;
  final String? market;
  final String? marketDisplayName;
  final double? pip;
  final String? submarket;
  final String? submarketDisplayName;
  final String? symbol;
  final String? symbolType;
}
