import 'package:price_tracker/domain/models/models.dart';

class SymbolModel {
  const SymbolModel({
    this.msgType,
    this.tick,
  });

  factory SymbolModel.fromJson(Map<String, dynamic> json) => SymbolModel(
        msgType: json['msg_type'] as String,
        tick: Tick.fromJson(json['tick'] as Map<String, dynamic>),
      );

  final String? msgType;
  final Tick? tick;
}
