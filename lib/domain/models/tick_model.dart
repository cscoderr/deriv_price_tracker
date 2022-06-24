class Tick {
  const Tick({
    this.ask,
    this.bid,
    this.epoch,
    this.id,
    this.pipSize,
    this.quote,
    this.symbol,
  });

  factory Tick.fromJson(Map<String, dynamic> json) => Tick(
        ask: json['ask'] as double?,
        bid: json['bid'] as double?,
        epoch: json['epoch'] as int?,
        id: json['id'] as String?,
        quote: json['quote'] as double?,
        symbol: json['symbol'] as String?,
      );
  final double? ask;
  final double? bid;
  final int? epoch;
  final String? id;
  final int? pipSize;
  final double? quote;
  final String? symbol;
}
