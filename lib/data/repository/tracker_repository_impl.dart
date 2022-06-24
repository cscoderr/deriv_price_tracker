import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:price_tracker/data/api/tracker_api.dart';
import 'package:price_tracker/data/cache/cache.dart';
import 'package:price_tracker/domain/models/models.dart';
import 'package:price_tracker/domain/repository/tracker_repository.dart';

class TrackerRepositoryImpl extends TrackerRepository {
  TrackerRepositoryImpl({
    TrackerApi? trackerApi,
    Cache<String, List<SymbolModel>>? cache,
  })  : _trackerApi = trackerApi ?? TrackerApi(),
        _cache = cache ?? InAppMemory<String, List<SymbolModel>>();

  final TrackerApi _trackerApi;
  final Cache<String, List<SymbolModel>> _cache;

  @visibleForTesting
  final String symbolKey = '__symbol_key__';

  @override
  Stream<List<SymbolModel>> marketSymbol(String market) async* {
    final _streamController = StreamController<List<SymbolModel>>.broadcast();
    if (_cache.contains(symbolKey)) {
      final symbols = _cache.get(market)!;
      _streamController.add(_getMarketSymbols(symbols, market));
      yield* _streamController.stream;
    }
    final symbols = symbolsWithMarket(market);
    yield* symbols;
  }

  List<SymbolModel> _getMarketSymbols(List<SymbolModel> data, String market) {
    final response = data.where((element) => element.market == market).toList();
    return response;
  }

  Stream<List<SymbolModel>> symbolsWithMarket(String market) async* {
    final _streamController = StreamController<List<SymbolModel>>.broadcast();
    _trackerApi.getSymbols().listen(
      (dynamic data) {
        final resData = jsonDecode(data as String) as Map<String, dynamic>;
        final response = resData['active_symbols'] as List;
        final symbols = response
            .map((dynamic e) => SymbolModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final marketSymbols = _getMarketSymbols(symbols, market);
        _streamController.add(marketSymbols);
        _cache.set(symbolKey, symbols);
      },
      onError: (dynamic error) {
        print(error);
        throw Exception(error);
      },
    );
    yield* _streamController.stream;
  }

  @override
  Stream<List<SymbolModel>> symbols() async* {
    final _streamController = StreamController<List<SymbolModel>>.broadcast();
    _trackerApi.getSymbols().listen(
      (dynamic data) {
        final resData = jsonDecode(data as String) as Map<String, dynamic>;
        final response = resData['active_symbols'] as List;
        final symbols = response
            .map((dynamic e) => SymbolModel.fromJson(e as Map<String, dynamic>))
            .toList();
        _streamController.add(symbols);
        _cache.set(symbolKey, symbols);
      },
      onError: (dynamic error) {
        print(error);
        throw Exception(error);
      },
    );
    yield* _streamController.stream;
  }

  @override
  Future<List<PriceModel>> tick() {
    // TODO: implement tick
    throw UnimplementedError();
  }
}
