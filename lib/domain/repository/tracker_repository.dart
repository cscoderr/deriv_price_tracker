import 'package:price_tracker/domain/models/models.dart';

abstract class TrackerRepository {
  Stream<List<SymbolModel>> symbols();

  Stream<List<SymbolModel>> marketSymbol(String market);

  Future<List<PriceModel>> tick();
}
