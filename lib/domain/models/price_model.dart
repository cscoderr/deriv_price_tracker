import 'package:price_tracker/domain/models/models.dart';

class PriceModel {
  const PriceModel({
    this.msgType,
    this.tick,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
        msgType: json['msg_type'] as String,
        tick: Tick.fromJson(json['tick'] as Map<String, dynamic>),
      );

  final String? msgType;
  final Tick? tick;
}
